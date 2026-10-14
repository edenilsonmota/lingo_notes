import 'package:flutter/material.dart';

import '../domain/notebook.dart';

const notebookColors = <int>[
  0xFF315C49,
  0xFF315F86,
  0xFF70558C,
  0xFFA05245,
  0xFFB07A24,
  0xFF4F6367,
];

class NotebookFormResult {
  const NotebookFormResult({
    required this.name,
    required this.description,
    required this.colorValue,
  });

  final String name;
  final String description;
  final int colorValue;
}

class NotebookFormDialog extends StatefulWidget {
  const NotebookFormDialog({this.notebook, super.key});

  final Notebook? notebook;

  @override
  State<NotebookFormDialog> createState() => _NotebookFormDialogState();
}

class _NotebookFormDialogState extends State<NotebookFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late int _colorValue;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.notebook?.name);
    _descriptionController = TextEditingController(
      text: widget.notebook?.description,
    );
    _colorValue = widget.notebook?.colorValue ?? notebookColors.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      NotebookFormResult(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        colorValue: _colorValue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.notebook != null;
    return AlertDialog(
      title: Text(editing ? 'Editar caderno' : 'Novo caderno'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  autofocus: true,
                  maxLength: 80,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  textInputAction: TextInputAction.next,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Informe o nome do caderno.'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionController,
                  maxLength: 180,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Descrição (opcional)',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Cor', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  children: [
                    for (final value in notebookColors)
                      Semantics(
                        label: 'Selecionar cor do caderno',
                        selected: _colorValue == value,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () => setState(() => _colorValue = value),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Color(value),
                              shape: BoxShape.circle,
                              border: _colorValue == value
                                  ? Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      width: 3,
                                    )
                                  : null,
                            ),
                            child: _colorValue == value
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                : null,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(editing ? 'Salvar' : 'Criar'),
        ),
      ],
    );
  }
}
