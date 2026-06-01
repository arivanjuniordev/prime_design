// Exportação de listas para CSV, Excel (.xlsx) e PDF.
// Salva o arquivo via file_saver (download no web, share/salvar no mobile/desktop).
//
// PDF e Excel são gerados fora da main isolate via compute() para não travar a UI.
// CSV é leve e fica síncrono.

import 'dart:convert';

import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

enum PrimeExportFormat { csv, excel, pdf }

/// Argumento serializável passado aos isolates (compute).
/// Apenas tipos primitivos / coleções → seguro para cruzar o isolate boundary.
@immutable
class _ExportArgs {
  const _ExportArgs({
    required this.title,
    required this.headers,
    required this.rows,
  });

  final String title;
  final List<String> headers;
  final List<List<String>> rows;
}

class PrimeExportService {
  PrimeExportService._();

  /// Gera o arquivo no formato pedido e dispara o save/download.
  /// PDF/Excel são gerados em background isolate (compute).
  static Future<void> export({
    required PrimeExportFormat format,
    required String baseFilename,
    required String title,
    required List<String> headers,
    required List<List<String>> rows,
  }) async {
    final Uint8List bytes;
    final String ext;
    final MimeType mime;
    final args = _ExportArgs(title: title, headers: headers, rows: rows);
    switch (format) {
      case PrimeExportFormat.csv:
        bytes = csvBytes(headers, rows);
        ext = 'csv';
        mime = MimeType.csv;
      case PrimeExportFormat.excel:
        bytes = await compute(_excelIsolate, args);
        ext = 'xlsx';
        mime = MimeType.microsoftExcel;
      case PrimeExportFormat.pdf:
        bytes = await compute(_pdfIsolate, args);
        ext = 'pdf';
        mime = MimeType.pdf;
    }
    await FileSaver.instance.saveFile(
      name: baseFilename,
      bytes: bytes,
      ext: ext,
      mimeType: mime,
    );
  }

  /// CSV separado por ';' (padrão pt-BR no Excel), com BOM UTF-8 para acentos.
  static Uint8List csvBytes(List<String> headers, List<List<String>> rows) {
    final buffer = StringBuffer();
    buffer.writeln(headers.map(_csvCell).join(';'));
    for (final row in rows) {
      buffer.writeln(row.map(_csvCell).join(';'));
    }
    // BOM (0xEF 0xBB 0xBF) faz o Excel reconhecer UTF-8 (acentos).
    final body = utf8.encode(buffer.toString());
    return Uint8List.fromList([0xEF, 0xBB, 0xBF, ...body]);
  }

  // Caracteres que disparam fórmula no Excel/Sheets/LibreOffice quando estão
  // no início da célula (CSV injection — OWASP).
  // Ref: https://owasp.org/www-community/attacks/CSV_Injection
  static const _csvInjectionTriggers = {'=', '+', '-', '@', '\t', '\r'};

  static String _csvCell(String value) {
    // 1) Neutraliza CSV injection: prefixa com aspa simples antes do escape.
    var sanitized = value;
    if (sanitized.isNotEmpty && _csvInjectionTriggers.contains(sanitized[0])) {
      sanitized = "'$sanitized";
    }
    // 2) Escape RFC 4180: envolve em aspas quando há ; " \n \r.
    if (sanitized.contains(';') ||
        sanitized.contains('"') ||
        sanitized.contains('\n') ||
        sanitized.contains('\r')) {
      return '"${sanitized.replaceAll('"', '""')}"';
    }
    return sanitized;
  }

  /// Geração síncrona do .xlsx (usada nos testes). Em produção, `export`
  /// chama esta lógica dentro de um isolate via `compute`.
  static Uint8List excelBytes(List<String> headers, List<List<String>> rows) {
    return _buildExcel(headers, rows);
  }

  /// Wrapper assíncrono que roda a geração do PDF fora da main isolate.
  static Future<Uint8List> pdfBytes(
    String title,
    List<String> headers,
    List<List<String>> rows,
  ) async {
    return compute(
      _pdfIsolate,
      _ExportArgs(title: title, headers: headers, rows: rows),
    );
  }
}

// ---------------------------------------------------------------------------
// Funções top-level executadas no isolate (compute). Tudo que usam (excel/pdf)
// é construído DENTRO da função — nada compartilhado com a main isolate.
// ---------------------------------------------------------------------------

Uint8List _excelIsolate(_ExportArgs args) =>
    _buildExcel(args.headers, args.rows);

Uint8List _buildExcel(List<String> headers, List<List<String>> rows) {
  final excel = Excel.createExcel();
  final sheet = excel[excel.getDefaultSheet() ?? 'Sheet1'];
  sheet.appendRow([for (final h in headers) TextCellValue(h)]);
  for (final row in rows) {
    sheet.appendRow([for (final c in row) TextCellValue(c)]);
  }
  final encoded = excel.encode();
  return Uint8List.fromList(encoded ?? const []);
}

Future<Uint8List> _pdfIsolate(_ExportArgs args) async {
  final doc = pw.Document();
  final geradoEm = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4.landscape,
      build: (context) => [
        pw.Header(
          level: 0,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                args.title,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'Eco Frota — Ecosafety • gerado em $geradoEm',
                style: const pw.TextStyle(
                  fontSize: 9,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 8),
        pw.TableHelper.fromTextArray(
          headers: args.headers,
          data: args.rows,
          headerStyle: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.white,
            fontSize: 9,
          ),
          headerDecoration: const pw.BoxDecoration(
            color: PdfColor.fromInt(0xFF0E7C5A),
          ),
          cellStyle: const pw.TextStyle(fontSize: 8),
          cellAlignment: pw.Alignment.centerLeft,
          rowDecoration: const pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5),
            ),
          ),
        ),
      ],
    ),
  );
  // compute() resolve o Future devolvido pela função do isolate antes de
  // retornar à main isolate.
  return doc.save();
}
