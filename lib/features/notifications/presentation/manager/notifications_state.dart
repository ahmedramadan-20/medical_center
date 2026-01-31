import 'package:equatable/equatable.dart';
import 'package:medical_center/features/home/data/models/notification_model.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsSuccess extends NotificationsState {

  const NotificationsSuccess(this.notifications, this.unreadCount);
  final List<NotificationModel> notifications;
  final int unreadCount;

  @override
  List<Object?> get props => [notifications, unreadCount];
}

class NotificationsError extends NotificationsState {

  const NotificationsError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
