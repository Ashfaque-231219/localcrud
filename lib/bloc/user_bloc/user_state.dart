import 'package:localdbcrud/database/student_dao/student_database.dart';
import 'package:localdbcrud/database/user_dao/user_database.dart';

import '../../view_model/event_status.dart';

class UserState {
  final List<Student?>? student;
  final Student? studentDetails;
  final User? allUser;
  final StateStatus stateStatus;

  UserState({this.student, this.allUser, this.studentDetails,this.stateStatus =  const StateNotLoaded()});

  UserState copyWith({final List<Student?>? student, final User? allUser, final Student? studentDetails, final StateStatus ?stateStatus}) {
    return UserState(student: student ?? this.student, allUser: allUser ?? this.allUser, studentDetails: studentDetails ?? this.studentDetails,stateStatus: stateStatus??this.stateStatus);
  }

  @override
  String toString() {
    return "UserState{getUser:$student,allUser:$allUser,studentDetails:$studentDetails}";
  }
}
