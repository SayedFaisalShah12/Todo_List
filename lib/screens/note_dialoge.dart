import 'package:flutter/material.dart';
import '../models/models.dart';

class NoteDialog extends StatefulWidget {
  final NoteModel note;
  final Function(NoteModel) onSave;

  const NoteDialog({required this.note, required this.onSave, super.key});

  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController emailController;
  late TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    descriptionController = TextEditingController(text: widget.note.description);
    emailController = TextEditingController(text: widget.note.email);
    ageController = TextEditingController(text: widget.note.age.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Note'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Priority'),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Duration in hours'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onSave(
              NoteModel(
                id: widget.note.id,
                title: titleController.text,
                description: descriptionController.text,
                email: emailController.text,
                age: int.parse(ageController.text.toString()),
              ),
            );
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}