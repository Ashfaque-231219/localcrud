import 'dart:async';

import 'package:floor/floor.dart';
import 'package:localdbcrud/database/student_dao/student_dao.dart';
import 'package:localdbcrud/database/student_dao/student_database.dart';
import 'package:localdbcrud/database/user_dao/user_dao.dart';
import 'package:localdbcrud/database/user_dao/user_database.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Student])
abstract class AppDatabase extends FloorDatabase {
  StudentDao get student;
}
