// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  StudentDao? _studentInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `student` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `address` TEXT, `contactNo` TEXT, `image` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  StudentDao get student {
    return _studentInstance ??= _$StudentDao(database, changeListener);
  }
}

class _$StudentDao extends StudentDao {
  _$StudentDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _studentInsertionAdapter = InsertionAdapter(
            database,
            'student',
            (Student item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'address': item.address,
                  'contactNo': item.contactNo,
                  'image': item.image
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Student> _studentInsertionAdapter;

  @override
  Future<List<Student>> getUser() async {
    return _queryAdapter.queryList('SELECT * FROM student',
        mapper: (Map<String, Object?> row) => Student(
            name: row['name'] as String?,
            address: row['address'] as String?,
            contactNo: row['contactNo'] as String?,
            id: row['id'] as int?,
            image: row['image'] as String?));
  }

  @override
  Future<Student?> getStudentById(int id) async {
    return _queryAdapter.query('SELECT * FROM student WHERE id= ?1',
        mapper: (Map<String, Object?> row) => Student(
            name: row['name'] as String?,
            address: row['address'] as String?,
            contactNo: row['contactNo'] as String?,
            id: row['id'] as int?,
            image: row['image'] as String?),
        arguments: [id]);
  }

  @override
  Future<Student?> updateStudentById(
      int id, String name, String contact, String address, String image) async {
    return _queryAdapter.query(
        'UPDATE student SET name=?2 ,contactNo=?3,address=?4,image=?5 WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Student(name: row['name'] as String?, address: row['address'] as String?, contactNo: row['contactNo'] as String?, id: row['id'] as int?, image: row['image'] as String?),
        arguments: [id, name, contact, address, image]);
  }

  @override
  Future<void> deleteStudentById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE  FROM student WHERE id =?1', arguments: [id]);
  }

  @override
  Future<int> insertUser(Student student) {
    return _studentInsertionAdapter.insertAndReturnId(
        student, OnConflictStrategy.abort);
  }
}
