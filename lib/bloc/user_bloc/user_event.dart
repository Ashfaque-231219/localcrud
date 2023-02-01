import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class insertUser extends UserEvent {
  final int? id;
  final String? username;
  final String? contactNo;
  final String? addresss;
  final BuildContext? context;
  final String? image;

  insertUser({this.id, required this.username, required this.addresss, this.contactNo, this.context, this.image});

  @override
  List<Object?> get props => [];
}

class GetUsers extends UserEvent {
  final BuildContext? context;

  GetUsers({this.context});

  @override
  List<Object?> get props => [];
}

class GetStudentById extends UserEvent {
  final int? id;
  final BuildContext? context;

  GetStudentById({this.context, this.id});

  @override
  List<Object?> get props => [];
}

class UpdateStudentEventById extends UserEvent {
  final int? id;
  final String? name;
  final String? address;
  final String? image;
  final String? contact;
  final BuildContext? context;

  UpdateStudentEventById({this.id, this.address, this.name, this.image, this.contact, this.context});

  @override
  List<Object?> get props => [];
}

class DeleteStudent extends UserEvent {
  final int? id;

  DeleteStudent({
    this.id,
  });

  @override
  List<Object?> get props => [];
}
