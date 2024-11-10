import 'package:my_simple_note/models/Note.dart';
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
      version: 1,
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
      _notesTitleColumnName: note[_notesTitleColumnName],
      _notesContentColumnName: note[_notesContentColumnName],
      _notesStatusColumnName: 1,
      _notesUpdatedDateColumnName: DateTime.now().toString(),
    });
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final data = await db.query(_notesTableName,
        where: '$_notesStatusColumnName = 1',
        orderBy: '$_notesUpdatedDateColumnName DESC');
    List<Note> notes = data
        .map((note) => Note(
            id: note["id"] as int,
            title: note["title"] as String,
            content: note["content"] as String,
            status: note["status"] as int,
            updated_at: note["updated_at"] as String,
            created_at: note["created_at"] as String))
        .toList();
    return notes;
  }

  Future<List<Note>> getArchivedNotes() async {
    final db = await database;
    final data = await db.query(_notesTableName,
        where: '$_notesStatusColumnName = 2',
        orderBy: '$_notesUpdatedDateColumnName DESC');
    List<Note> notes = data
        .map((note) => Note(
            id: note["id"] as int,
            title: note["title"] as String,
            content: note["content"] as String,
            status: note["status"] as int,
            updated_at: note["updated_at"] as String,
            created_at: note["created_at"] as String))
        .toList();
    return notes;
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete(_notesTableName,
        where: '$_notesIdColumnName = ?', whereArgs: [id]);
  }

  Future<int> archiveNote(int id) async {
    final db = await database;
    return await db.update(
        _notesTableName,
        {
          _notesStatusColumnName: 2,
          _notesUpdatedDateColumnName: DateTime.now().toString(),
        },
        where: '$_notesIdColumnName = ?',
        whereArgs: [id]);
  }
}
