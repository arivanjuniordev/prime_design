import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:integration_test/integration_test_driver.dart';

/// Driver de performance: recebe o timeline reportado pelo teste (chave
/// `scrolling_timeline`), gera o summary e escreve em `build/`:
///
/// - `build/scrolling_timeline.timeline.json`          (timeline bruto)
/// - `build/scrolling_timeline.timeline_summary.json`  (métricas agregadas:
///   average/worst_frame_build_time_millis, *_rasterizer_time_millis,
///   missed_frame_*_budget_count, frame_count)
Future<void> main() {
  return integrationDriver(
    responseDataCallback: (data) async {
      if (data != null) {
        final timeline = driver.Timeline.fromJson(
          data['scrolling_timeline'] as Map<String, dynamic>,
        );
        final summary = driver.TimelineSummary.summarize(timeline);
        await summary.writeTimelineToFile(
          'scrolling_timeline',
          pretty: true,
          includeSummary: true,
          destinationDirectory: 'build',
        );
      }
    },
  );
}
