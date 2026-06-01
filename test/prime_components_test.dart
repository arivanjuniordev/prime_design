import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prime_design/prime_design.dart';

// Política de testes: aqui cobrimos apenas COMPORTAMENTO observável dos
// componentes que têm lógica — não smoke de widgets passivos.
//
// PrimeEntityPickerField tem lógica de domínio real: deriva o texto exibido a
// partir de (value, options, emptyLabel) e protege contra um `value` que não
// existe mais nas opções (id "órfão"). É isso que validamos.

const _brand = Color(0xFF16A34A);

Future<void> _pump(WidgetTester t, Widget child) => t.pumpWidget(
  MaterialApp(
    theme: PrimeTheme.light(brand: _brand),
    home: Scaffold(body: child),
  ),
);

const _options = [
  PrimePickerOption('1', 'ABC-1234'),
  PrimePickerOption('2', 'XYZ-5678'),
];

PrimeEntityPickerField _picker({String? value, String? emptyLabel}) =>
    PrimeEntityPickerField(
      label: 'Veículo',
      value: value,
      options: _options,
      emptyLabel: emptyLabel,
      onChanged: (_) {},
    );

void main() {
  group('PrimeEntityPickerField (lógica de display)', () {
    testWidgets('value nulo sem emptyLabel mostra o placeholder', (t) async {
      await _pump(t, _picker());
      expect(find.text('Selecione...'), findsOneWidget);
    });

    testWidgets('value existente mostra o label da opção', (t) async {
      await _pump(t, _picker(value: '2'));
      expect(find.text('XYZ-5678'), findsOneWidget);
      expect(find.text('Selecione...'), findsNothing);
    });

    testWidgets('value órfão (não está nas opções) cai no placeholder', (
      t,
    ) async {
      // Regressão: um id que foi removido das opções não pode quebrar nem
      // exibir lixo — deve degradar para o placeholder.
      await _pump(t, _picker(value: '999'));
      expect(find.text('Selecione...'), findsOneWidget);
    });

    testWidgets('emptyLabel é exibido quando value é nulo', (t) async {
      await _pump(t, _picker(emptyLabel: 'Sem veículo'));
      expect(find.text('Sem veículo'), findsOneWidget);
    });
  });
}
