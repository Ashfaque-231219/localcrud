import 'package:floor/floor.dart';

@Entity(tableName: 'student')
class Student {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? name;
  final String? address;
  final String? contactNo;
  final String? image;

  Student({this.name, this.address, this.contactNo, this.id, this.image});
}
