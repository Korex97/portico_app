import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/states/authenticated_form_states.dart';
import 'package:potrico/states/user_details_state.dart';
import '../models/failure_model.dart';
import '../models/update_details_model.dart';
import '../models/user_details.dart';
import '../repository/account_repository.dart';


class UserDetailsController extends StateNotifier<UserDetailsState> {
  UserDetailsController(this.ref) : super(const UserDetailsStateInitial());

  final Ref ref;

  getDetails() async {
    state = const UserDetailsStateLaoding();

    Either<Failure, UserDetails> response =
        await ref.read(accountRepositoryProvider).getDetails();

    if (response.isRight) {
      state = UserDetailsStateSuccess(response.right);
    } else {
      state = UserDetailsStateError(response.left.message);
    }
  }

  resetState() async {
    state = const UserDetailsStateInitial();
  }

}

final userDetailsControllerProvider =
    StateNotifierProvider<UserDetailsController, UserDetailsState>((ref) {
  return UserDetailsController(ref);
});

