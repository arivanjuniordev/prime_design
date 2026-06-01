import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prime_design/prime_design.dart';

const _brand = Color(0xFF16A34A);

Widget _host(Widget child) => MaterialApp(
  theme: PrimeTheme.light(brand: _brand),
  home: Scaffold(body: child),
);

void main() {
  testWidgets('PrimeButton renderiza o label e dispara onPressed', (
    tester,
  ) async {
    var tapped = false;
    await tester.pumpWidget(
      _host(PrimeButton(label: 'Salvar', onPressed: () => tapped = true)),
    );
    expect(find.text('Salvar'), findsOneWidget);
    await tester.tap(find.text('Salvar'));
    expect(tapped, isTrue);
  });

  testWidgets('PrimeButton desabilitado não dispara', (tester) async {
    await tester.pumpWidget(
      _host(const PrimeButton(label: 'X', onPressed: null)),
    );
    await tester.tap(find.text('X'));
    // sem callback → nada a verificar além de não lançar exceção
    expect(tester.takeException(), isNull);
  });

  testWidgets('PrimeBadge mostra o texto', (tester) async {
    await tester.pumpWidget(
      _host(const PrimeBadge(text: 'Novo', color: PrimePalette.info)),
    );
    // PrimeBadge renderiza o texto em maiúsculas.
    expect(find.text('NOVO'), findsOneWidget);
  });

  testWidgets('PrimeStatusChip renderiza o rótulo legível', (tester) async {
    await tester.pumpWidget(_host(const PrimeStatusChip('em_andamento')));
    expect(find.text('EM ANDAMENTO'), findsOneWidget);
  });

  testWidgets('context.cs.accent reflete a marca do tema', (tester) async {
    late Color seen;
    await tester.pumpWidget(
      _host(
        Builder(
          builder: (context) {
            seen = context.cs.accent;
            return const SizedBox();
          },
        ),
      ),
    );
    expect(seen, _brand);
  });
}
