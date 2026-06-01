import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:prime_design/prime_design.dart';

/// Harness de medição de performance de scroll do Prime Design.
///
/// Monta um [ListView.builder] com 200 [PrimeCard]s (cada um com um
/// [PrimeInfoTile]) e grava o timeline de frames durante flings agressivos.
///
/// ```
/// flutter drive --driver=test_driver/perf_driver.dart \
///   --target=integration_test/perf_scroll_test.dart \
///   --profile --no-dds -d <emulador>
/// ```
/// `--no-dds` é necessário em device/emulador (a doc oficial de profiling).
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('scroll de 200 PrimeCards gera timeline de frames', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: PrimeTheme.light(brand: const Color(0xFF16A34A)),
        home: Scaffold(
          body: SafeArea(
            child: ListView.builder(
              key: const Key('perf_list'),
              padding: const EdgeInsets.all(PrimeSpacing.lg),
              itemCount: 200,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: PrimeSpacing.lg),
                child: PrimeCard(
                  child: PrimeInfoTile(
                    icon: Icons.directions_car_rounded,
                    iconColor: PrimePalette.info,
                    title: 'Item $index',
                    subtitle: 'Linha de medição #$index',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final listFinder = find.byKey(const Key('perf_list'));
    await binding.traceAction(
      () async {
        for (var i = 0; i < 5; i++) {
          await tester.fling(listFinder, const Offset(0, -400), 4000);
          await tester.pumpAndSettle();
          await tester.fling(listFinder, const Offset(0, 400), 4000);
          await tester.pumpAndSettle();
        }
      },
      reportKey: 'scrolling_timeline',
    );
  });
}
