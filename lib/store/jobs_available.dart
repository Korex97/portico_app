import 'dart:io';

class JobsAvailable {
  final String name;
  final String description;
  final String salaryExpected;
  final int
      jobType; // 1=FullTime 2 = Remote 3 = Hybrid 4= Parttime 5 = Ghost Worker
  final String role;
  final String jobId;

  JobsAvailable(this.name, this.description, this.salaryExpected, this.jobType,
      this.role, this.jobId);
}

List<JobsAvailable> availableJobs = [];
List xyz = ["", 2, true, null];

JobsAvailable jobs = JobsAvailable(
    "Senior Flutter Developer at Alamu Obo",
    "Full Description about job",
    "100000 - 300000",
    2,
    "Mobile Engineer",
    "TYYY457");

class JobApplicants {
  late String _name;
  late String _address;
  late File _resume;
  late List<String> _experience;
  late List<String> _education;
  late String _dateOfBirth;
  late int _maritalStatus;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  File get resume => _resume;

  set resume(File value) {
    _resume = value;
  }

  List<String> get experience => _experience;

  set experience(List<String> value) {
    _experience = value;
  }

  List<String> get education => _education;

  set education(List<String> value) {
    _education = value;
  }

  String get dateOfBirth => _dateOfBirth;

  set dateOfBirth(String value) {
    _dateOfBirth = value;
  }

  int get maritalStatus => _maritalStatus;

  set maritalStatus(int value) {
    _maritalStatus = value;
  } // 1- Married 2 - Single 3 - Divorced 4 - Complicated 5 - You will Die Alone 6 - We are Deceiving Ourselves
}

JobApplicants applicants = JobApplicants();

