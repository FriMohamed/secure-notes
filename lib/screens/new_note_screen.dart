import 'package:flutter/material.dart';
import "package:secure_notes/l10n/app_localizations.dart";
import "../data/note_dao.dart";
import "../models/note.dart";

class NewNoteScreen extends StatefulWidget {
  NewNoteScreen({super.key});

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final NoteDao _noteDao = NoteDao.instance;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      _noteDao.addNote(
        Note(
          title: _titleController.text.trim(),
          description: _descController.text.trim(),
          createdAt: DateTime.now(),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _saveNote,
            child: Text(
              l10n.save,
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                autofocus: true,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: l10n.titleHint,
                  hintStyle: TextStyle(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  ),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.titleRequired;
                  }
                  return null;
                },
              ),

              Divider(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                thickness: 1,
              ),

              const SizedBox(height: 10),

              Expanded(
                child: TextFormField(
                  controller: _descController,
                  maxLines: null,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: l10n.descriptionHint,
                    hintStyle: TextStyle(
                      color: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.descriptionRequired;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
