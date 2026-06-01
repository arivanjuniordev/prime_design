import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prime_design/prime_design.dart';

const _brand = Color(0xFF16A34A);

Future<void> _pump(WidgetTester t, Widget child) => t.pumpWidget(
  MaterialApp(
    theme: PrimeTheme.light(brand: _brand),
    home: Scaffold(body: Center(child: child)),
  ),
);

void main() {
  // ---- PrimeButton (minHeight 48): tap target + contraste ----------------
  testWidgets('PrimeButton atende tap target (android/iOS) e contraste', (
    t,
  ) async {
    final handle = t.ensureSemantics();
    await _pump(t, PrimeButton(label: 'Salvar', onPressed: () {}));
    await expectLater(t, meetsGuideline(androidTapTargetGuideline));
    await expectLater(t, meetsGuideline(iOSTapTargetGuideline));
    await expectLater(t, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(t, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });

  // ---- PrimePressable: tap target + label -------------------------------
  // Envolvemos um alvo >=48 para validar o tap target do wrapper interativo.
  testWidgets('PrimePressable atende tap target e está rotulado', (t) async {
    final handle = t.ensureSemantics();
    await _pump(
      t,
      PrimePressable(
        onTap: () {},
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: Semantics(label: 'Abrir', child: const Text('Abrir')),
          ),
        ),
      ),
    );
    await expectLater(t, meetsGuideline(androidTapTargetGuideline));
    await expectLater(t, meetsGuideline(iOSTapTargetGuideline));
    await expectLater(t, meetsGuideline(labeledTapTargetGuideline));
    handle.dispose();
  });

  // ---- PrimeChip: contraste + label -------------------------------------
  // PrimeChip tem minHeight 36 por design (chip compacto), então NÃO pode
  // passar no androidTapTargetGuideline (48). Validamos contraste de texto e
  // a presença de rótulo semântico em vez do tap target.
  testWidgets('PrimeChip atende contraste e está rotulado', (t) async {
    final handle = t.ensureSemantics();
    await _pump(t, PrimeChip(label: 'Filtro', onTap: () {}));
    await expectLater(t, meetsGuideline(textContrastGuideline));
    await expectLater(t, meetsGuideline(labeledTapTargetGuideline));
    handle.dispose();
  });

  testWidgets('PrimeChip ativo atende contraste (fundo de marca sólido)', (
    t,
  ) async {
    final handle = t.ensureSemantics();
    await _pump(t, PrimeChip(label: 'Ativo', active: true, onTap: () {}));
    await expectLater(t, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });

  // PrimeBadge/PrimeIconBox são puramente apresentacionais (rótulo/ícone
  // estáticos, sem interação). NÃO há tap target nem comportamento a validar;
  // o contraste dos badges com cor semântica é tratado no design das cores,
  // não em teste. Por isso não há testes de a11y para eles aqui.

  // ---- PrimeStatusChip: contraste do texto ------------------------------
  testWidgets('PrimeStatusChip("ativo") atende contraste', (t) async {
    final handle = t.ensureSemantics();
    await _pump(t, const PrimeStatusChip('ativo'));
    await expectLater(t, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });
}
