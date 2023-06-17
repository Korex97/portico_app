import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/models/job_applicants.dart';
import 'package:potrico/screens/employer/resume/applicant_details.dart';
import '../models/applicant_details_model.dart';
import '../models/failure_model.dart';
import '../repository/job_repository.dart';
import '../states/applicant_details_state.dart';
import '../states/job_Applicants_state.dart';

class ApplicantDetailsController extends StateNotifier<ApplicantDetailsState> {
  ApplicantDetailsController(this.ref)
      : super(const ApplicantDetailsStateInitial());

  final Ref ref;

  getApplicantDetails(String applicant) async {
    state = const ApplicantDetailsStateLaoding();

    Either<Failure, ApplicantDetailsModel> response =
        await ref.read(jobRepositoryProvider).getApplicantDetails(applicant);

    if (response.isRight) {
      state = ApplicantDetailsStateSuccess(response.right);
    } else {
      state = ApplicantDetailsStateError(response.left.message);
    }
  }

  resetState() async {
    state = const ApplicantDetailsStateInitial();
  }
}

final applicantDetailsControllerProvider =
    StateNotifierProvider<ApplicantDetailsController, ApplicantDetailsState>(
        (ref) {
  return ApplicantDetailsController(ref);
});
