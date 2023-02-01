import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:localdbcrud/bloc/user_bloc/user_event.dart';
import 'package:localdbcrud/bloc/user_bloc/user_state.dart';
import 'package:localdbcrud/database/database.dart';
import 'package:localdbcrud/database/student_dao/student_database.dart';
import 'package:localdbcrud/view/shared_widget/toast.dart';
import 'package:localdbcrud/view_model/event_status.dart';

import '../../view/pages/list_page.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(AppDatabase database) : super(UserState()) {
    on<insertUser>((event, emit) async {
      await insertUsers(event, emit, database);
    });
    on<GetUsers>((event, emit) async {
      await _getUsers(event, emit, database);
    });
    on<UpdateStudentEventById>((event, emit) async {
      await _updateStudentEventById(event, emit, database);
    });
    on<GetStudentById>((event, emit) async {
      await _getStudentById(event, emit, database);
    });
    on<DeleteStudent>((event, emit) async {
      await _deleteStudent(event, emit, database);
    });
  }

  insertUsers(insertUser event, Emitter<UserState> emit, AppDatabase database) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));

      int userId =
          await database.student.insertUser(Student(name: event.username, contactNo: event.contactNo, address: event.addresss, image: event.image));
      emit(state.copyWith(stateStatus: StateLoaded(successMessage: 'Data inserted SuccessFully')));
      Navigator.push(
        event.context!,
        MaterialPageRoute(builder: (context) => const ListPage()),
      );
      ToastMessage.success('Data inserted SuccessFully');
    } catch (e) {
      emit(state.copyWith(stateStatus: StateFailed(errorMessage: 'Issue while Insertion')));
      print(e.toString());
    }
  }

  _getUsers(GetUsers event, Emitter<UserState> emit, AppDatabase database) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      List<Student?>? studentList = await database.student.getUser();
      print("The studnet list ======>>>> $studentList");
      emit(state.copyWith(student: studentList, stateStatus: StateLoaded(successMessage: 'List Get Succesffuly')));
    } catch (e) {
      print(e.toString());
    }
  }

  _getStudentById(GetStudentById event, Emitter<UserState> emit, AppDatabase database) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      Student? studentDetails = await database.student.getStudentById(event.id ?? 0);
      emit(state.copyWith(studentDetails: studentDetails, stateStatus: StateLoaded(successMessage: 'List Sucessfully')));
    } catch (e) {
      print(e.toString());
    }
  }

  _updateStudentEventById(UpdateStudentEventById event, Emitter<UserState> emit, AppDatabase database) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      Student? updateStudent = await database.student
          .updateStudentById(event.id ?? 0, event.name.toString(), event.address.toString(), event.contact.toString(), event.image.toString());
      List<Student?>? studentList = await database.student.getUser();
      emit(state.copyWith(student: studentList, stateStatus: StateLoaded(successMessage: 'Data is Edited Successfylly')));
      Navigator.pop(event.context!);
    } catch (e) {}
  }

  _deleteStudent(DeleteStudent event, Emitter<UserState> emit, AppDatabase database) async {
    emit(state.copyWith(stateStatus: StateLoading()));
    await database.student.deleteStudentById(event.id ?? 0);

    List<Student?>? studentList = await database.student.getUser();
    emit(state.copyWith(student: studentList, stateStatus: StateLoaded(successMessage: 'State is Loaded SuccessFuully')));
    ToastMessage.success('Data Deleted Succesfully');
  }
}
