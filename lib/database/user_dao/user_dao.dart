import 'package:floor/floor.dart';
import 'package:localdbcrud/database/user_dao/user_database.dart';
@dao
abstract class UserDao{
  @insert
  Future<int> insertUser(User user);

  @Query('SELECT * FROM user')
  Future<List<User>> getUser();

  @Query('SELECT * FROM user WHERE id = :id')
  Future<User?> getUserDetails(int id);

  @Query('UPDATE user SET name = :name ,pass = :pass WHERE id = :id')
  Future<User?> UpdateUserDetails(int id, String name, String pass);

  @Query("DELETE FROM USER WHERE id = :id")
  Future<void> deleteUser(int id);


}