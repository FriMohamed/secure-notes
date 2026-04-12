import 'package:flutter/material.dart';
import 'package:secure_notes/data/note_dao.dart';
import 'package:secure_notes/l10n/app_localizations.dart';
import 'package:secure_notes/models/note.dart';
import 'package:secure_notes/screens/note_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteDao _noteDao = NoteDao.instance;
  final List<Note> _notes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    NoteDao.instance.getAllNotes().then((notes) {
      setState(() {
        _notes.addAll(notes);
        _isLoading = false;
      });
    });
  }

  void _deleteNote(Note note) {
    _noteDao.delete(note.id);
    _notes.remove(note);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appName),
        centerTitle: true,
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notes.isEmpty
          ? _emptyState()
          : ListView.builder(
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
        onPressed: () {},
        label: Text(AppLocalizations.of(context)!.addNote),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoteCard(Note note) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteDetailsScreen(note: note),
          ),
        );
      },
      onDoubleTap: () {
        // TODO: Navigate to note edit screen
      },
      child: Card(
        elevation: 0,
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Text(
            note.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            note.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
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
            'No notes yet',
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
