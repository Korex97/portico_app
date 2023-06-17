import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/failure_model.dart';
import '../models/job_category.dart';
import '../repository/job_repository.dart';
import '../states/job_category_state.dart';


class JobCategoryController extends StateNotifier<JobCategoryState> {
  JobCategoryController(this.ref) : super(const JobCategoryStateInitial());

  final Ref ref;

  getJobCategories() async {
    state = const JobCategoryStateLaoding();

    Either<Failure, JobCategories> response =
        await ref.read(jobRepositoryProvider).getJobCategories();

    if (response.isRight) {
      state = JobCategoryStateSuccess(response.right);
    } else {
      state = JobCategoryStateError(response.left.message);
    }
  }

  resetState() async {
    state = const JobCategoryStateInitial();
  }

}

final jobCategoryControllerProvider =
    StateNotifierProvider<JobCategoryController, JobCategoryState>((ref) {
  return JobCategoryController(ref);
});

