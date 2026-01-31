import 'package:medical_center/features/reviews/data/models/review_model.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class AddReviewLoading extends ReviewState {}

class ReviewSuccess extends ReviewState {
  ReviewSuccess(this.reviews);
  final List<ReviewModel> reviews;
}

class AddReviewSuccess extends ReviewState {
  AddReviewSuccess(this.message);
  final String message;
}

class ReviewActionSuccess extends ReviewState {
  ReviewActionSuccess(this.message);
  final String message;
}

class ReviewError extends ReviewState {
  ReviewError(this.message);
  final String message;
}
