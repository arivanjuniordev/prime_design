import 'package:flutter/material.dart';

import '../services/prime_export_service.dart';

/// Botão de exportação (PDF / Excel / CSV) para listagens.
/// Recebe os cabeçalhos e uma função que extrai a linha de cada item.
class PrimeExportButton<T> extends StatelessWidget {
  const PrimeExportButton({
    super.key,
    required this.items,
    required this.headers,
    required this.row,
    required this.baseFilename,
    required this.title,
  });

  final List<T> items;
  final List<String> headers;
  final List<String> Function(T) row;
  final String baseFilename;
  final String title;

  Future<void> _run(BuildContext context, PrimeExportFormat format) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await PrimeExportService.export(
        format: format,
        baseFilename: baseFilename,
        title: title,
        headers: headers,
        rows: [for (final it in items) row(it)],
      );
      messenger.showSnackBar(
        const SnackBar(content: Text('Exportação concluída')),
      );
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Falha ao exportar: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PrimeExportFormat>(
      tooltip: 'Exportar',
      icon: const Icon(Icons.file_download_outlined),
      enabled: items.isNotEmpty,
      onSelected: (f) => _run(context, f),
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: PrimeExportFormat.pdf,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.picture_as_pdf_outlined),
            title: Text('Exportar PDF'),
          ),
        ),
        PopupMenuItem(
          value: PrimeExportFormat.excel,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.grid_on_outlined),
            title: Text('Exportar Excel'),
          ),
        ),
        PopupMenuItem(
          value: PrimeExportFormat.csv,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.description_outlined),
            title: Text('Exportar CSV'),
          ),
        ),
      ],
    );
  }
}
