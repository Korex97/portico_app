import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/failure_model.dart';
import '../models/job_full_details_model.dart';
import '../repository/job_repository.dart';
import '../states/job_details_state.dart';


class JobFullDetailsController extends StateNotifier<JobFullDetailsState> {
  JobFullDetailsController(this.ref) : super(const JobFullDetailsStateInitial());

  final Ref ref;

  getJobDetails(String job) async {
    state = const JobFullDetailsStateLaoding();

    Either<Failure, JobFullDetailsModel> response = await ref.read(jobRepositoryProvider).getJobDetails(job);

    if (response.isRight) {
      state = JobFullDetailsStateSuccess(response.right);
    } else {
      state = JobFullDetailsStateError(response.left.message);
    }
  }

  resetState() async {
    state = const JobFullDetailsStateInitial();
  }

}

final jobFullDetailsControllerProvider =
    StateNotifierProvider<JobFullDetailsController, JobFullDetailsState>((ref) {
  return JobFullDetailsController(ref);
});

