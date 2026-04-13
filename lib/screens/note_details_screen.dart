import 'package:flutter/material.dart';
import 'package:secure_notes/data/note_dao.dart';
import 'package:secure_notes/l10n/app_localizations.dart';
import 'package:secure_notes/models/note.dart';

class NoteDetailsScreen extends StatefulWidget {
  final Note note;
  const NoteDetailsScreen({super.key, required this.note});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  final NoteDao _noteDao = NoteDao.instance;
  final _formKey = GlobalKey<FormState>();

  bool _isEdited = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _descController = TextEditingController(text: widget.note.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _updateNote() {
    if (_formKey.currentState!.validate()) {
      _noteDao.update(
        Note(
          id: widget.note.id,
          title: _titleController.text.trim(),
          description: _descController.text.trim(),
          createdAt: widget.note.createdAt,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Hero(
      tag: widget.note.id.toString(),
      child: Material(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: _isEdited ? Colors.green : Colors.grey,
                ),
                onPressed: _updateNote,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    onChanged: (_) => setState(() => _isEdited = true),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: l10n.titleHint,
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.titleRequired;
                      }
                      return null;
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "${widget.note.createdAt.day}/${widget.note.createdAt.month}/${widget.note.createdAt.year}",
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.6,
                        ),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: TextFormField(
                      controller: _descController,
                      onChanged: (_) => setState(() => _isEdited = true),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      decoration: InputDecoration(
                        hintText: l10n.descriptionHint,
                        border: InputBorder.none,
                      ),
                      maxLines: null,
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
        ),
      ),
    );
  }
}
