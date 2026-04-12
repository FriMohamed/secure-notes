import 'package:flutter/material.dart';
import 'package:secure_notes/models/note.dart';

class NoteDetailsScreen extends StatelessWidget {
  final Note note;
  const NoteDetailsScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: note.id.toString(), // Same tag as the Home Screen card!
      child: Scaffold(
        appBar: AppBar(title: Text(note.title)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SelectableText( // Better for notes so users can copy text
            note.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}