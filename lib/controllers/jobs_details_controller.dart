import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/models/job_details_model.dart';
import '../models/failure_model.dart';
import '../repository/job_repository.dart';
import '../states/jobs_states.dart';


class JobDetailsController extends StateNotifier<JobDetailsState> {
  JobDetailsController(this.ref) : super(const JobDetailsStateInitial());

  final Ref ref;

  getJobPosted({String value = "", String location = "", String category = "", String salaryRange = ""}) async {
    state = const JobDetailsStateLaoding();

    Either<Failure, JobDetailsModel> response =
        await ref.read(jobRepositoryProvider).getJobPosted(value: value, location: location, category: category, salaryRange: salaryRange);

    if (response.isRight) {
      state = JobDetailsStateSuccess(response.right);
    } else {
      state = JobDetailsStateError(response.left.message);
    }
  }

  resetState() async {
    state = const JobDetailsStateInitial();
  }

}

final jobDetailsControllerProvider =
    StateNotifierProvider<JobDetailsController, JobDetailsState>((ref) {
  return JobDetailsController(ref);
});

