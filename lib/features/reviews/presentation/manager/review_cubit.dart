import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/features/appointments/data/models/review_model.dart';
import 'package:medical_center/features/reviews/presentation/manager/review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitReview(ReviewModel review) async {
    emit(AddReviewLoading());
    try {
      // 1. Add review to 'reviews' collection
      final reviewRef = _firestore.collection('reviews').doc();
      final reviewWithId = review.toMap()..['id'] = reviewRef.id;
      await reviewRef.set(reviewWithId);

      // 2. Update appointment 'isReviewed' status
      await _firestore
          .collection('appointments')
          .doc(review.appointmentId)
          .update({'isReviewed': true});

      // 3. Update Doctor's rating aggregation
      await _updateDoctorRating(review.doctorId, review.rating);

      emit(AddReviewSuccess('Review submitted successfully!'));
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }

  Future<void> _updateDoctorRating(String doctorId, double newRating) async {
    final doctorRef = _firestore.collection('doctors').doc(doctorId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(doctorRef);
      if (!snapshot.exists) return;

      final double currentAvg =
          (snapshot.data()?['averageRating'] ?? 0.0).toDouble();
      final int currentCount = snapshot.data()?['numberOfReviews'] ?? 0;

      final newCount = currentCount + 1;
      final newAvg = ((currentAvg * currentCount) + newRating) / newCount;

      transaction.update(doctorRef, {
        'averageRating': newAvg,
        'numberOfReviews': newCount,
      });
    });
  }

  void getDoctorReviews(String doctorId) {
    emit(ReviewLoading());
    _firestore
        .collection('reviews')
        .where('doctorId', isEqualTo: doctorId)
        .where('isApproved', isEqualTo: true)
        .snapshots()
        .listen(
      (snapshot) {
        final reviews = snapshot.docs.map((doc) {
          final data = doc.data();
          return ReviewModel.fromJson(data);
        }).toList();

        // Sort in memory to avoid requiring a composite index
        reviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        emit(ReviewSuccess(reviews));
      },
      onError: (e) {
        emit(ReviewError(e.toString()));
      },
    );
  }

  void getAllReviewsForAdmin() {
    emit(ReviewLoading());
    _firestore.collection('reviews').snapshots().listen(
      (snapshot) {
        final reviews = snapshot.docs.map((doc) {
          final data = doc.data();
          return ReviewModel.fromJson(data);
        }).toList();

        reviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        emit(ReviewSuccess(reviews));
      },
      onError: (e) {
        emit(ReviewError(e.toString()));
      },
    );
  }

  Future<void> approveReview(String reviewId) async {
    try {
      await _firestore
          .collection('reviews')
          .doc(reviewId)
          .update({'isApproved': true});
      emit(ReviewActionSuccess('Review approved successfully'));
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }

  Future<void> deleteReview(String reviewId) async {
    try {
      await _firestore.collection('reviews').doc(reviewId).delete();
      emit(ReviewActionSuccess('Review deleted successfully'));
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }
}
