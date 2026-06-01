import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:integration_test/integration_test_driver.dart';

/// Driver de performance: recebe o timeline reportado pelo teste de integração
/// (chave `scrolling_timeline`), gera o summary e escreve em `build/`:
///
/// - `build/scrolling.timeline.json`          (timeline bruto)
/// - `build/scrolling.timeline_summary.json`  (métricas agregadas)
Future<void> main() {
  return integrationDriver(
    responseDataCallback: (data) async {
      if (data != null) {
        final timeline = driver.Timeline.fromJson(
          data['scrolling_timeline'] as Map<String, dynamic>,
        );
        final summary = driver.TimelineSummary.summarize(timeline);
        await summary.writeTimelineToFile(
          'scrolling',
          pretty: true,
          includeSummary: true,
          destinationDirectory: 'build',
        );
      }
    },
  );
}
