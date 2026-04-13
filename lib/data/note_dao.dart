import 'package:secure_notes/data/db_helper.dart';
import 'package:secure_notes/models/note.dart';

class NoteDao {
  static final NoteDao instance = NoteDao._internal();
  final _dbProvider = AppDatabase.instance;

  NoteDao._internal();

  Future<int> addNote(Note note) async {
    final db = await _dbProvider.db;
    return await db.transaction((txn) async {
      final id = await txn.insert('notes', note.toInsertMap());
      await txn.update(
        'notes',
        {'order_index': id},
        where: 'id = ?',
        whereArgs: [id],
      );

      return id;
    });
  }

  Future<List<Note>> getAllNotes() async {
    final db = await _dbProvider.db;

    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      orderBy: 'order_index ASC',
    );

    return maps.map((map) => Note.fromMap(map)).toList();
  }

  Future<int> update(Note note) async {
    final db = await _dbProvider.db;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _dbProvider.db;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllNotes() async {
    final db = await _dbProvider.db;
     await db.delete('notes');
  }
}
