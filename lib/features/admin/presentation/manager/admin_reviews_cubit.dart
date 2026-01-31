import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/features/reviews/data/models/review_model.dart';

abstract class AdminReviewsState {}

class AdminReviewsInitial extends AdminReviewsState {}

class AdminReviewsLoading extends AdminReviewsState {}

class AdminReviewsSuccess extends AdminReviewsState {
  AdminReviewsSuccess(this.reviews);
  final List<ReviewModel> reviews;
}

class AdminReviewsError extends AdminReviewsState {
  AdminReviewsError(this.message);
  final String message;
}

/// Manages admin operations for reviews.
///
/// Handles loading and monitoring all reviews in the system with real-time updates.
class AdminReviewsCubit extends Cubit<AdminReviewsState> {
  AdminReviewsCubit() : super(AdminReviewsInitial());

  final _logger = LoggerService('AdminReviewsCubit');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot>? _reviewsSubscription;

  void getReviews() {
    emit(AdminReviewsLoading());
    _logger.info('Loading all reviews for admin panel');
    _reviewsSubscription?.cancel();
    _reviewsSubscription = _firestore
        .collection('reviews')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        final reviews = snapshot.docs.map((doc) {
          final data = doc.data();
          return ReviewModel.fromJson(data).copyWith(id: doc.id);
        }).toList();
        _logger.info('Loaded ${reviews.length} reviews');
        emit(AdminReviewsSuccess(reviews));
      },
      onError: (e) {
        _logger.error('Error loading reviews', e);
        emit(AdminReviewsError(e.toString()));
      },
    );
  }

  Future<void> approveReview(String reviewId) async {
    try {
      await _firestore
          .collection('reviews')
          .doc(reviewId)
          .update({'isApproved': true});
      _logger.info('Review approved: $reviewId');
    } catch (e) {
      _logger.error('Error approving review', e);
      emit(AdminReviewsError(e.toString()));
    }
  }

  Future<void> deleteReview(ReviewModel review) async {
    try {
      await _firestore.collection('reviews').doc(review.id).delete();
      _logger.info('Review deleted: ${review.id}');

      if (review.appointmentId.isNotEmpty) {
        await _firestore
            .collection('appointments')
            .doc(review.appointmentId)
            .update({'isReviewed': false});
      }

      await _updateDoctorRatingOnDelete(review.doctorId, review.rating);
    } catch (e) {
      _logger.error('Error deleting review', e);
      emit(AdminReviewsError(e.toString()));
    }
  }

  Future<void> _updateDoctorRatingOnDelete(
    String doctorId,
    double deletedRating,
  ) async {
    final doctorRef = _firestore.collection('doctors').doc(doctorId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(doctorRef);
      if (!snapshot.exists) return;

      final double currentAvg =
          (snapshot.data()?['averageRating'] ?? 0.0).toDouble();
      final int currentCount = snapshot.data()?['numberOfReviews'] ?? 0;

      if (currentCount <= 1) {
        transaction.update(doctorRef, {
          'averageRating': 0.0,
          'numberOfReviews': 0,
        });
      } else {
        final newCount = currentCount - 1;
        final newAvg = ((currentAvg * currentCount) - deletedRating) / newCount;
        transaction.update(doctorRef, {
          'averageRating': newAvg,
          'numberOfReviews': newCount,
        });
      }
    });
  }

  @override
  Future<void> close() {
    _logger.info('Closing AdminReviewsCubit and cancelling subscriptions');
    _reviewsSubscription?.cancel();
    return super.close();
  }
}
