import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prime_design/prime_design.dart';

void main() {
  group('PrimeLazyIndexedStack (lazy + keep-alive)', () {
    testWidgets('só constrói índices já visitados', (tester) async {
      final built = <int>{};

      Widget host(int index) => Directionality(
        textDirection: TextDirection.ltr,
        child: PrimeLazyIndexedStack(
          index: index,
          children: [
            for (var i = 0; i < 3; i++)
              Builder(
                builder: (_) {
                  built.add(i);
                  return Text('item$i');
                },
              ),
          ],
        ),
      );

      await tester.pumpWidget(host(0));
      // Só o índice 0 foi construído; 1 e 2 continuam lazy.
      expect(built, {0});

      await tester.pumpWidget(host(1));
      // Visitou o 1 → construído. O 2 (nunca visitado) segue lazy.
      expect(built.contains(1), isTrue);
      expect(built.contains(2), isFalse);

      await tester.pumpWidget(host(0));
      // Voltar pro 0 não força o 2 (continua nunca construído).
      expect(built.contains(2), isFalse);
    });
  });

  group('PrimeMeasurable', () {
    testWidgets('reporta o tamanho do filho via onChange', (tester) async {
      Size? measured;
      await tester.pumpWidget(
        Center(
          child: PrimeMeasurable(
            onChange: (s) => measured = s,
            child: const SizedBox(width: 200, height: 100),
          ),
        ),
      );
      await tester.pumpAndSettle(); // drena o microtask do callback
      expect(measured, const Size(200, 100));
    });
  });

  group('PrimeIgnorePointerKeepSemantics', () {
    testWidgets('bloqueia o toque no filho', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: PrimeIgnorePointerKeepSemantics(
              child: GestureDetector(
                onTap: () => tapped = true,
                child: const SizedBox(width: 80, height: 80),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(GestureDetector), warnIfMissed: false);
      expect(tapped, isFalse); // hitTest sempre falha → ponteiro ignorado
    });
  });
}
