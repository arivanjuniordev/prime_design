import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prime_design/prime_design.dart';

const _brand = Color(0xFF16A34A);

Future<void> _pump(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(
      theme: PrimeTheme.light(brand: _brand),
      home: Scaffold(body: Center(child: child)),
    ),
  );
}

void main() {
  testWidgets('PrimeCard renderiza o filho', (t) async {
    await _pump(t, const PrimeCard(child: Text('conteúdo')));
    expect(find.text('conteúdo'), findsOneWidget);
  });

  testWidgets('PrimeChip renderiza o label', (t) async {
    await _pump(t, const PrimeChip(label: 'Filtro'));
    expect(find.text('Filtro'), findsOneWidget);
  });

  testWidgets('PrimePill renderiza ícone + texto', (t) async {
    await _pump(t, const PrimePill(icon: Icons.star, text: 'Pro'));
    expect(find.text('Pro'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);
  });

  testWidgets('PrimeCircle renderiza o filho', (t) async {
    await _pump(t, const PrimeCircle(child: Icon(Icons.add)));
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('PrimeIconBox renderiza o ícone', (t) async {
    await _pump(
      t,
      const PrimeIconBox(icon: Icons.directions_car, color: PrimePalette.info),
    );
    expect(find.byIcon(Icons.directions_car), findsOneWidget);
  });

  testWidgets('PrimeInfoBox renderiza texto + ícone', (t) async {
    await _pump(
      t,
      const PrimeInfoBox(
        icon: Icons.info,
        text: 'Aviso',
        color: PrimePalette.info,
      ),
    );
    expect(find.text('Aviso'), findsOneWidget);
  });

  testWidgets('PrimeInfoTile renderiza o título', (t) async {
    await _pump(
      t,
      const PrimeInfoTile(
        icon: Icons.badge,
        iconColor: PrimePalette.info,
        title: 'Motorista',
      ),
    );
    expect(find.text('Motorista'), findsOneWidget);
  });

  testWidgets('PrimeStatTile renderiza label + valor', (t) async {
    await _pump(
      t,
      const PrimeStatTile(
        icon: Icons.local_gas_station,
        color: PrimePalette.success,
        label: 'Consumo',
        value: '12,5 km/L',
      ),
    );
    expect(find.text('Consumo'), findsOneWidget);
    expect(find.text('12,5 km/L'), findsOneWidget);
  });

  testWidgets('PrimePageHeader renderiza o título', (t) async {
    await _pump(t, const PrimePageHeader(title: 'Veículos'));
    expect(find.text('Veículos'), findsOneWidget);
  });

  testWidgets('PrimeSectionHeader renderiza o título', (t) async {
    await _pump(
      t,
      const PrimeSectionHeader(
        title: 'Resumo',
        icon: Icons.dashboard,
        color: PrimePalette.info,
      ),
    );
    expect(find.text('Resumo'), findsOneWidget);
  });

  testWidgets('PrimeEmptyState renderiza o título', (t) async {
    await _pump(t, const PrimeEmptyState(title: 'Nada por aqui'));
    await t.pumpAndSettle(); // drena animações flutter_animate
    expect(find.text('Nada por aqui'), findsOneWidget);
  });

  testWidgets('PrimeErrorBanner renderiza a mensagem', (t) async {
    await _pump(t, const PrimeErrorBanner(message: 'Falha de rede'));
    await t.pumpAndSettle(); // drena animações flutter_animate
    expect(find.text('Falha de rede'), findsOneWidget);
  });

  testWidgets('PrimeBanner renderiza o título', (t) async {
    await _pump(
      t,
      const PrimeBanner(
        icon: Icons.warning_amber,
        title: 'Documento vencido',
        color: PrimePalette.warning,
      ),
    );
    expect(find.text('Documento vencido'), findsOneWidget);
  });

  testWidgets('PrimePressable dispara onTap', (t) async {
    var tapped = false;
    await _pump(
      t,
      PrimePressable(
        onTap: () => tapped = true,
        child: const Text('toque'),
      ),
    );
    await t.tap(find.text('toque'));
    expect(tapped, isTrue);
  });

  testWidgets('PrimeSurface renderiza o filho', (t) async {
    await _pump(t, const PrimeSurface(child: Text('superfície')));
    expect(find.text('superfície'), findsOneWidget);
  });

  testWidgets('PrimeSearchField aceita texto', (t) async {
    final ctrl = TextEditingController();
    var changed = '';
    await _pump(
      t,
      PrimeSearchField(controller: ctrl, onChanged: (v) => changed = v),
    );
    await t.enterText(find.byType(TextField), 'abc');
    expect(changed, 'abc');
  });

  testWidgets('PrimeTextField renderiza o label e aceita texto', (t) async {
    await _pump(t, const PrimeTextField(label: 'Nome'));
    expect(find.text('Nome'), findsOneWidget);
    await t.enterText(find.byType(TextField), 'João');
    expect(find.text('João'), findsOneWidget);
  });

  testWidgets('PrimeDropdownField renderiza o valor selecionado', (t) async {
    await _pump(
      t,
      PrimeDropdownField<String>(
        label: 'UF',
        value: 'RN',
        items: const [
          DropdownMenuItem(value: 'RN', child: Text('RN')),
          DropdownMenuItem(value: 'SP', child: Text('SP')),
        ],
        onChanged: (_) {},
      ),
    );
    expect(find.text('UF'), findsOneWidget);
    expect(find.text('RN'), findsWidgets);
  });

  testWidgets('PrimeDateField renderiza o label', (t) async {
    await _pump(
      t,
      PrimeDateField(label: 'Vencimento', value: null, onChanged: (_) {}),
    );
    expect(find.text('Vencimento'), findsOneWidget);
  });

  testWidgets('PrimeEntityPickerField renderiza o label e o placeholder', (
    t,
  ) async {
    await _pump(
      t,
      PrimeEntityPickerField(
        label: 'Veículo',
        value: null,
        options: const [
          PrimePickerOption('1', 'ABC-1234'),
          PrimePickerOption('2', 'XYZ-5678'),
        ],
        onChanged: (_) {},
      ),
    );
    expect(find.text('Veículo'), findsOneWidget);
    expect(find.text('Selecione...'), findsOneWidget);
  });

  testWidgets('PrimeExportButton renderiza sem itens', (t) async {
    await _pump(
      t,
      PrimeExportButton<Map<String, String>>(
        items: const [],
        headers: const ['Coluna'],
        row: (e) => [e['v'] ?? ''],
        baseFilename: 'export',
        title: 'Relatório',
      ),
    );
    expect(t.takeException(), isNull);
  });

  group('PrimeSkeleton', () {
    testWidgets('PrimeSkeletonBox renderiza', (t) async {
      await _pump(t, const PrimeSkeletonBox(width: 100, height: 12));
      expect(t.takeException(), isNull);
    });

    testWidgets('PrimeSkeletonList renderiza N linhas', (t) async {
      await _pump(t, const SizedBox(height: 400, child: PrimeSkeletonList()));
      expect(t.takeException(), isNull);
    });

    testWidgets('PrimeSkeletonStatTile renderiza', (t) async {
      await _pump(t, const PrimeSkeletonStatTile());
      expect(t.takeException(), isNull);
    });
  });
}
