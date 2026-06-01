import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prime_design/prime_design.dart';

/// Host mínimo com [MediaQuery] controlando `disableAnimations` (reduce motion).
Widget _host({required bool disableAnimations, required Widget child}) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: MediaQuery(
      data: const MediaQueryData().copyWith(
        disableAnimations: disableAnimations,
      ),
      child: child,
    ),
  );
}

void main() {
  group('PrimeReveal respeita reduce motion', () {
    testWidgets(
      'disableAnimations=true: entrega o child DIRETO, sem Animate na árvore',
      (tester) async {
        await tester.pumpWidget(
          _host(
            disableAnimations: true,
            child: const PrimeReveal(child: Text('x')),
          ),
        );

        // Contrato de acessibilidade: nenhum widget Animate é inserido.
        expect(find.byType(Animate), findsNothing);
        // E o conteúdo continua presente.
        expect(find.text('x'), findsOneWidget);
      },
    );

    testWidgets(
      'disableAnimations=false: anima — há ao menos um Animate na árvore',
      (tester) async {
        await tester.pumpWidget(
          _host(
            disableAnimations: false,
            child: const PrimeReveal(child: Text('x')),
          ),
        );

        expect(find.byType(Animate), findsWidgets);
        expect(find.text('x'), findsOneWidget);
        await tester.pumpAndSettle(); // drena a animação (evita timer pendente)
      },
    );
  });

  group('PrimeReveal.stagger', () {
    testWidgets('renderiza todos os filhos numa Column', (tester) async {
      await tester.pumpWidget(
        _host(
          disableAnimations: false,
          child: PrimeReveal.stagger(
            children: const [Text('a'), Text('b'), Text('c')],
          ),
        ),
      );

      expect(find.text('a'), findsOneWidget);
      expect(find.text('b'), findsOneWidget);
      expect(find.text('c'), findsOneWidget);
      // Empilhados numa única Column.
      expect(find.byType(Column), findsOneWidget);
      await tester.pumpAndSettle(); // drena as animações escalonadas
    });

    testWidgets('stagger sob reduce motion: filhos presentes, nenhum Animate', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          disableAnimations: true,
          child: PrimeReveal.stagger(
            children: const [Text('a'), Text('b'), Text('c')],
          ),
        ),
      );

      expect(find.text('a'), findsOneWidget);
      expect(find.text('b'), findsOneWidget);
      expect(find.text('c'), findsOneWidget);
      expect(find.byType(Animate), findsNothing);
    });
  });
}
