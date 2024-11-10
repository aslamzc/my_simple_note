import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _notesTableName = 'notes';
  final String _notesIdColumnName = 'id';
  final String _notesTitleColumnName = 'title';
  final String _notesContentColumnName = 'content';
  final String _notesStatusColumnName = 'status';
  final String _notesCreatedDateColumnName = 'created_at';
  final String _notesUpdatedDateColumnName = 'updated_at';

  DatabaseService._constructor();

  Future<Database> get database async => _db ??= await getDatabase();

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'simple_note.db');
    final database = await openDatabase(
      databasePath,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_notesTableName(
            $_notesIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $_notesTitleColumnName TEXT,
            $_notesContentColumnName TEXT,
            $_notesStatusColumnName INTEGER,
            $_notesCreatedDateColumnName TEXT DEFAULT CURRENT_TIMESTAMP,
            $_notesUpdatedDateColumnName TEXT
          )
        ''');
      },
    );
    return database;
  }

  void addNote(Map<String, dynamic> note) async {
    final db = await database;
    await db.insert(_notesTableName, {
      _notesTitleColumnName: "Test Title",
      _notesContentColumnName: "Test Content",
      _notesStatusColumnName: 1,
      _notesUpdatedDateColumnName: DateTime.now().toString(),
    });
  }
}
