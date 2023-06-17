import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/models/authenticated_form.dart';
import 'package:potrico/models/employee_details_form.dart';
import 'package:potrico/states/authenticated_form_states.dart';
import '../models/add_job_model.dart';
import '../models/apply_for_job_model.dart';
import '../models/education_form_model.dart';
import '../models/experience_form.dart';
import '../models/failure_model.dart';
import '../models/update_details_model.dart';
import '../repository/account_repository.dart';
import '../repository/job_repository.dart';


class AccountFormController extends StateNotifier<AuthenticatedFormState> {
  AccountFormController(this.ref) : super(const AuthenticatedFormStateInitial());

  final Ref ref;

  updateInfo( UpdateDetails details ) async {
    state = const AuthenticatedFormStateLaoding();

    Either<Failure, AuthenticatedForm> response =
        await ref.read(accountRepositoryProvider).userInfo(details);

    if (response.isRight) {
      state = AuthenticatedFormStateSuccess(response.right);
    } else {
      state = AuthenticatedFormStateerror(response.left.message);
    }
  }

  updateEmployerDetails( EmployeeDetailsForm details ) async {
    state = const AuthenticatedFormStateLaoding();

    Either<Failure, AuthenticatedForm> response =
        await ref.read(accountRepositoryProvider).updateEmployeeDetails(details);

    if (response.isRight) {
      state = AuthenticatedFormStateSuccess(response.right);
    } else {
      state = AuthenticatedFormStateerror(response.left.message);
    }
  }

  updateEducationDetails( EducationForm details ) async {
    state = const AuthenticatedFormStateLaoding();

    Either<Failure, AuthenticatedForm> response =
        await ref.read(accountRepositoryProvider).updateEducationDetails(details);

    if (response.isRight) {
      state = AuthenticatedFormStateSuccess(response.right);
    } else {
      state = AuthenticatedFormStateerror(response.left.message);
    }
  }

  deleteEducationDetails( String details ) async {
    state = const AuthenticatedFormStateLaoding();

    Either<Failure, AuthenticatedForm> response =
        await ref.read(accountRepositoryProvider).deleteEducation(details);

    if (response.isRight) {
      state = AuthenticatedFormStateSuccess(response.right);
    } else {
      state = AuthenticatedFormStateerror(response.left.message);
    }
  }

  updateExperienceDetails( ExperienceForm details ) async {
    state = const AuthenticatedFormStateLaoding();

    Either<Failure, AuthenticatedForm> response =
        await ref.read(accountRepositoryProvider).updateExperienceDetails(details);

    if (response.isRight) {
      state = AuthenticatedFormStateSuccess(response.right);
    } else {
      state = AuthenticatedFormStateerror(response.left.message);
    }
  }

  deleteExperienceDetails( String details ) async {
    state = const AuthenticatedFormStateLaoding();

    Either<Failure, AuthenticatedForm> response =
        await ref.read(accountRepositoryProvider).deleteExperience(details);

    if (response.isRight) {
      state = AuthenticatedFormStateSuccess(response.right);
    } else {
      state = AuthenticatedFormStateerror(response.left.message);
    }
  }

  addJob( AddJobModel jobData ) async {
    state = const AuthenticatedFormStateLaoding();

    Either<Failure, AuthenticatedForm> response =
        await ref.read(jobRepositoryProvider).addJob(jobData);

    if (response.isRight) {
      state = AuthenticatedFormStateSuccess(response.right);
    } else {
      state = AuthenticatedFormStateerror(response.left.message);
    }
  }

  applyForJob( ApplyForJobModel applicant ) async {
    state = const AuthenticatedFormStateLaoding();

    Either<Failure, AuthenticatedForm> response =
        await ref.read(jobRepositoryProvider).applyForJob(applicant);

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

final accountFormControllerProvider =
    StateNotifierProvider<AccountFormController, AuthenticatedFormState>((ref) {
  return AccountFormController(ref);
});

