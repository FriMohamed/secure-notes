import 'package:flutter/material.dart';
import 'package:secure_notes/data/note_dao.dart';
import 'package:secure_notes/l10n/app_localizations.dart';
import 'package:secure_notes/models/note.dart';
import 'package:secure_notes/screens/note_details_screen.dart';
import 'package:secure_notes/screens/new_note_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteDao _noteDao = NoteDao.instance;
  List<Note> _notes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _noteDao.getAllNotes();

    setState(() {
      _notes = notes;
      _isLoading = false;
    });
  }

  Future<void> _deleteNote(Note note) async {
    await _noteDao.delete(note.id!);

    setState(() {
      _notes.remove(note);
    });
  }

  void _navigateToNewNote() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NewNoteScreen()),
    );

    _loadNotes();
  }

  void _navigateToDetails(Note note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NoteDetailsScreen(note: note)),
    );

    _loadNotes();
  }

  Future<void> _onReorder(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex--;

    final movedNote = _notes.removeAt(oldIndex);
    _notes.insert(newIndex, movedNote);

    int start = oldIndex < newIndex ? oldIndex : newIndex;
    int end = oldIndex > newIndex ? oldIndex : newIndex;

    for (int i = start; i <= end; i++) {
      final note = _notes[i];
      note.orderIndex = i;
      await _noteDao.update(note);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appName),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            onPressed: () async {
              await _noteDao.deleteAllNotes();
              setState(() => _notes.clear());
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notes.isEmpty
          ? _emptyState()
          : ReorderableListView.builder(
              onReorder: _onReorder,
              padding: const EdgeInsets.all(12),
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Dismissible(
                  key: Key(note.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: AlignmentDirectional.centerEnd,
                    padding: const EdgeInsetsDirectional.only(end: 20),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: const Icon(
                      Icons.delete_sweep,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  onDismissed: (direction) => _deleteNote(note),
                  child: Hero(
                    tag: note.id.toString(),
                    child: _buildNoteCard(note),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToNewNote(),
        label: Text(AppLocalizations.of(context)!.addNote),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoteCard(Note note) {
    return GestureDetector(
      onTap: () => _navigateToDetails(note),
      child: Card(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  note.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Text(
                "${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}",
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              note.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note,
            size: 80,
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.noNotes,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
