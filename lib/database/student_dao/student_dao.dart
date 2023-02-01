import 'package:floor/floor.dart';
import 'package:localdbcrud/database/student_dao/student_database.dart';

@dao
abstract class StudentDao {
  @insert
  Future<int> insertUser(Student student);

  @Query('SELECT * FROM student')
  Future<List<Student>> getUser();

  @Query('SELECT * FROM student WHERE id= :id')
  Future<Student?> getStudentById(int id);

  @Query('UPDATE student SET name=:name ,contactNo=:contact,address=:address,image=:image WHERE id = :id')
  Future<Student?> updateStudentById(int id, String name, String contact, String address, String image);

  @Query('DELETE  FROM student WHERE id =:id')
  Future<void> deleteStudentById(int id);
}
