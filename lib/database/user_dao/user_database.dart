import 'package:floor/floor.dart';

@Entity(tableName: 'user')
class User {
  @PrimaryKey(autoGenerate: true)

  final int? id;
  final String? name;
  final String? pass;

   User({this.id, this.name, this.pass});
}
