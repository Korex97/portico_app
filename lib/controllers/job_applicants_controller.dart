import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/models/job_applicants.dart';
import '../models/failure_model.dart';
import '../repository/job_repository.dart';
import '../states/job_Applicants_state.dart';

class JobApplicantsController extends StateNotifier<JobApplicantsState> {
  JobApplicantsController(this.ref) : super(const JobApplicantsStateInitial());

  final Ref ref;

  getJobApplicants(String job) async {
    state = const JobApplicantsStateLaoding();

    Either<Failure, JobApplicantModel> response =
        await ref.read(jobRepositoryProvider).getJobApplicants(job);

    if (response.isRight) {
      state = JobApplicantsStateSuccess(response.right);
    } else {
      state = JobApplicantsStateError(response.left.message);
    }
  }

  getEmployerJobApplicants() async {
    state = const JobApplicantsStateLaoding();

    Either<Failure, JobApplicantModel> response =
        await ref.read(jobRepositoryProvider).getEmployerApplixants();

    if (response.isRight) {
      state = JobApplicantsStateSuccess(response.right);
    } else {
      state = JobApplicantsStateError(response.left.message);
    }
  }

  getAllJobsUserAppliedfor() async {
    state = const JobApplicantsStateLaoding();

    Either<Failure, JobApplicantModel> response =
        await ref.read(jobRepositoryProvider).getAllJobsUserAppliedfor();

    if (response.isRight) {
      state = JobApplicantsStateSuccess(response.right);
    } else {
      state = JobApplicantsStateError(response.left.message);
    }
  }

  resetState() async {
    state = const JobApplicantsStateInitial();
  }
}

final jobApplicantsControllerProvider =
    StateNotifierProvider<JobApplicantsController, JobApplicantsState>((ref) {
  return JobApplicantsController(ref);
});
