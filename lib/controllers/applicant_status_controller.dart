import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/models/authenticated_form.dart';
import 'package:potrico/states/authenticated_form_states.dart';
import '../models/change_status_model.dart';
import '../models/failure_model.dart';
import '../repository/job_repository.dart';


class ApplicantStatusController extends StateNotifier<AuthenticatedFormState> {
  ApplicantStatusController(this.ref) : super(const AuthenticatedFormStateInitial());

  final Ref ref;


  changeApplicantStatus( ChangeStatusModel applicant ) async {
    state = const AuthenticatedFormStateLaoding();

    Either<Failure, AuthenticatedForm> response =
        await ref.read(jobRepositoryProvider).changeApplicantStatus(applicant);

    if (response.isRight) {
      state = AuthenticatedFormStateSuccess(response.right);
    } else {
      state = AuthenticatedFormStateerror(response.left.message);
    }
  }

  

  resetState() async {
    state = const AuthenticatedFormStateInitial();
  }

}

final applicantStatusControllerProvider =
    StateNotifierProvider<ApplicantStatusController, AuthenticatedFormState>((ref) {
  return ApplicantStatusController(ref);
});

