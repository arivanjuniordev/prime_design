import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';
import 'app_search_field.dart';

class PickerOption {
  const PickerOption(this.id, this.label);
  final String id;
  final String label;
}

/// Seletor de entidade por id (veículo, motorista...).
///
/// Abre um bottom sheet pesquisável: campo de busca no topo que filtra os
/// itens em tempo real pelo label (case-insensitive). A API pública é
/// mantida idêntica ao antigo dropdown.
class EntityPickerField extends StatelessWidget {
  const EntityPickerField({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.emptyLabel,
  });

  final String label;
  final String? value;
  final List<PickerOption> options;
  final ValueChanged<String?> onChanged;

  /// Se != null, adiciona uma opção "vazia" (ex.: "Sem motorista").
  final String? emptyLabel;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final ids = options.map((o) => o.id).toSet();
    final safeValue = (value != null && ids.contains(value)) ? value : null;

    final String displayText;
    final bool isPlaceholder;
    if (safeValue != null) {
      displayText = options.firstWhere((o) => o.id == safeValue).label;
      isPlaceholder = false;
    } else if (emptyLabel != null) {
      displayText = emptyLabel!;
      isPlaceholder = false;
    } else {
      displayText = 'Selecione...';
      isPlaceholder = true;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: () => _openPicker(context, safeValue),
          child: InputDecorator(
            decoration: const InputDecoration(),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    displayText,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isPlaceholder ? cs.textMuted : cs.textPrimary,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: cs.textSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openPicker(BuildContext context, String? safeValue) async {
    final selected = await showModalBottomSheet<_PickerResult>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: context.cs.surface,
      builder: (ctx) => _EntityPickerSheet(
        title: label,
        value: safeValue,
        options: options,
        emptyLabel: emptyLabel,
      ),
    );
    if (selected != null) {
      onChanged(selected.id);
    }
  }
}

/// Resultado do sheet. Envolvido pra distinguir "fechou sem escolher" (null)
/// de "escolheu a opção vazia" (id == null).
class _PickerResult {
  const _PickerResult(this.id);
  final String? id;
}

class _EntityPickerSheet extends StatefulWidget {
  const _EntityPickerSheet({
    required this.title,
    required this.value,
    required this.options,
    required this.emptyLabel,
  });

  final String title;
  final String? value;
  final List<PickerOption> options;
  final String? emptyLabel;

  @override
  State<_EntityPickerSheet> createState() => _EntityPickerSheetState();
}

class _EntityPickerSheetState extends State<_EntityPickerSheet> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final q = _query.trim().toLowerCase();
    final filtered = q.isEmpty
        ? widget.options
        : widget.options
              .where((o) => o.label.toLowerCase().contains(q))
              .toList();
    final showEmptyOption = widget.emptyLabel != null && q.isEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.7,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  0,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: AppSearchField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Flexible(
                child: filtered.isEmpty && !showEmptyOption
                    ? Padding(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        child: Text(
                          'Nenhum resultado.',
                          style: TextStyle(color: cs.textMuted),
                        ),
                      )
                    : ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        children: [
                          if (showEmptyOption)
                            _OptionTile(
                              label: widget.emptyLabel!,
                              selected: widget.value == null,
                              onTap: () => Navigator.of(
                                context,
                              ).pop(const _PickerResult(null)),
                            ),
                          for (final o in filtered)
                            _OptionTile(
                              label: o.label,
                              selected: o.id == widget.value,
                              onTap: () => Navigator.of(
                                context,
                              ).pop(_PickerResult(o.id)),
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return ListTile(
      title: Text(label, overflow: TextOverflow.ellipsis),
      selected: selected,
      selectedColor: cs.accent,
      trailing: selected
          ? Icon(Icons.check, color: cs.accent)
          : null,
      textColor: cs.textPrimary,
      onTap: onTap,
    );
  }
}
