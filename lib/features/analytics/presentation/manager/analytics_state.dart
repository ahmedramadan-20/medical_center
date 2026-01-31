import 'package:equatable/equatable.dart';
import 'package:medical_center/features/analytics/data/models/analytics_model.dart';

/// Base state for analytics
abstract class AnalyticsState extends Equatable {
  const AnalyticsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AnalyticsInitial extends AnalyticsState {}

/// Loading analytics data
class AnalyticsLoading extends AnalyticsState {}

/// Analytics loaded successfully
class AnalyticsLoaded extends AnalyticsState {
  const AnalyticsLoaded(this.analytics);
  final AnalyticsModel analytics;

  @override
  List<Object?> get props => [analytics];
}

/// Error loading analytics
class AnalyticsError extends AnalyticsState {
  const AnalyticsError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
