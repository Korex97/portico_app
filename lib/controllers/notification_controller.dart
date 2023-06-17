import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/failure_model.dart';
import '../models/notification_model.dart';
import '../repository/account_repository.dart';
import '../states/notification_state.dart';


class UserNotificationController extends StateNotifier<NotificationState> {
  UserNotificationController(this.ref) : super(const NotificationStateInitial());

  final Ref ref;

  getUserNotifications() async {
    state = const NotificationStateLaoding();

    Either<Failure, NotificationModel> response =
        await ref.read(accountRepositoryProvider).getUserNotifications();

    if (response.isRight) {
      state = NotificationStateSuccess(response.right);
    } else {
      state = NotificationStateError(response.left.message);
    }
  }

  resetState() async {
    state = const NotificationStateInitial();
  }

}

final userNotificationControllerProvider =
    StateNotifierProvider<UserNotificationController, NotificationState>((ref) {
  return UserNotificationController(ref);
});

