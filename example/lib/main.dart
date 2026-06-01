import 'package:flutter/material.dart';
import 'package:prime_design/prime_design.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  // Troque a marca aqui para ver TODO o design system mudar de cor.
  Color _brand = const Color(0xFF16A34A); // verde
  ThemeMode _mode = ThemeMode.light;

  static const _brands = <(String, Color)>[
    ('Verde', Color(0xFF16A34A)),
    ('Esmeralda', Color(0xFF0E7C5A)),
    ('Azul', Color(0xFF2563EB)),
    ('Roxo', Color(0xFF7C3AED)),
    ('Laranja', Color(0xFFEA580C)),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prime Design',
      debugShowCheckedModeBanner: false,
      theme: PrimeTheme.light(brand: _brand),
      darkTheme: PrimeTheme.dark(brand: _brand),
      themeMode: _mode,
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Prime Design'),
            actions: [
              IconButton(
                icon: Icon(
                  _mode == ThemeMode.light
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                ),
                onPressed: () => setState(() {
                  _mode = _mode == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                }),
              ),
            ],
          ),
          // Conteúdo centralizado e limitado a `maxContentWidth` em telas
          // largas (tablet/desktop), evitando linhas longas demais.
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.styles.maxContentWidth,
              ),
              child: ListView(
                // Padding responsivo: escala com o tamanho da tela.
                padding: EdgeInsets.all(context.styles.lg),
                children: [
                  // Revelação escalonada: cada seção entra logo após a anterior.
                  PrimeReveal.stagger(
                    children: [
                      PrimeSectionHeader(
                        title: 'Marca (parametrizável)',
                        icon: Icons.palette_outlined,
                        color: context.cs.accent,
                      ),
                      Wrap(
                        spacing: PrimeSpacing.sm,
                        runSpacing: PrimeSpacing.sm,
                        children: [
                          for (final (name, color) in _brands)
                            PrimeChip(
                              label: name,
                              active: _brand == color,
                              activeColor: color,
                              onTap: () => setState(() => _brand = color),
                            ),
                        ],
                      ),
                      const SizedBox(height: PrimeSpacing.xl),
                      PrimeSectionHeader(
                        title: 'Botões',
                        icon: Icons.smart_button_outlined,
                        color: context.cs.accent,
                      ),
                      Wrap(
                        spacing: PrimeSpacing.sm,
                        runSpacing: PrimeSpacing.sm,
                        children: [
                          PrimeButton(label: 'Primário', onPressed: () {}),
                          PrimeButton(
                            label: 'Secundário',
                            variant: PrimeButtonVariant.secondary,
                            onPressed: () {},
                          ),
                          PrimeButton(
                            label: 'Perigo',
                            variant: PrimeButtonVariant.danger,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: PrimeSpacing.xl),
                      PrimeSectionHeader(
                        title: 'Badges & Status',
                        icon: Icons.label_outline,
                        color: context.cs.accent,
                      ),
                      Wrap(
                        spacing: PrimeSpacing.sm,
                        runSpacing: PrimeSpacing.sm,
                        children: const [
                          PrimeBadge(text: 'Novo', color: PrimePalette.info),
                          PrimeStatusChip('ativo'),
                          PrimeStatusChip('vencido'),
                        ],
                      ),
                      const SizedBox(height: PrimeSpacing.xl),
                      PrimeSectionHeader(
                        title: 'Card',
                        icon: Icons.credit_card_outlined,
                        color: context.cs.accent,
                      ),
                      PrimeCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dinheiro & litros',
                              style: PrimeText.cardTitle,
                            ),
                            const SizedBox(height: PrimeSpacing.sm),
                            Text(
                              '${PrimeMoney.format(123456)} · ${PrimeLitros.format(40000)}',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: PrimeSpacing.xl),
                      PrimeSectionHeader(
                        title: 'KPIs (StatTile)',
                        icon: Icons.insights_outlined,
                        color: context.cs.accent,
                      ),
                      Row(
                        children: const [
                          Expanded(
                            child: PrimeStatTile(
                              icon: Icons.local_gas_station,
                              color: PrimePalette.success,
                              label: 'Consumo',
                              value: '12,5 km/L',
                            ),
                          ),
                          SizedBox(width: PrimeSpacing.sm),
                          Expanded(
                            child: PrimeStatTile(
                              icon: Icons.speed,
                              color: PrimePalette.info,
                              label: 'Rodados',
                              value: '1.240 km',
                              sub: 'últimos 30 dias',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: PrimeSpacing.xl),
                      PrimeSectionHeader(
                        title: 'Info & elementos',
                        icon: Icons.dashboard_customize_outlined,
                        color: context.cs.accent,
                      ),
                      const PrimeInfoTile(
                        icon: Icons.badge,
                        iconColor: PrimePalette.info,
                        title: 'Motorista',
                        subtitle: 'João da Silva',
                      ),
                      const SizedBox(height: PrimeSpacing.md),
                      Wrap(
                        spacing: PrimeSpacing.sm,
                        runSpacing: PrimeSpacing.sm,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [
                          PrimePill(icon: Icons.star, text: 'Pro'),
                          PrimePill(
                            icon: Icons.bolt,
                            text: 'Elétrico',
                            color: PrimePalette.success,
                          ),
                          PrimeIconBox(
                            icon: Icons.directions_car,
                            color: PrimePalette.info,
                          ),
                          PrimeIconBox(
                            icon: Icons.build,
                            color: PrimePalette.warning,
                          ),
                        ],
                      ),
                      const SizedBox(height: PrimeSpacing.xl),
                      PrimeSectionHeader(
                        title: 'Banners & avisos',
                        icon: Icons.campaign_outlined,
                        color: context.cs.accent,
                      ),
                      const PrimeBanner(
                        icon: Icons.warning_amber,
                        title: 'Documento vencido',
                        color: PrimePalette.warning,
                        message: 'O licenciamento do veículo ABC-1234 venceu.',
                      ),
                      const SizedBox(height: PrimeSpacing.md),
                      const PrimeErrorBanner(message: 'Falha de rede'),
                      const SizedBox(height: PrimeSpacing.xl),
                      PrimeSectionHeader(
                        title: 'Formulário',
                        icon: Icons.edit_note_outlined,
                        color: context.cs.accent,
                      ),
                      const PrimeTextField(label: 'Nome'),
                      const SizedBox(height: PrimeSpacing.md),
                      PrimeDateField(
                        label: 'Vencimento',
                        value: null,
                        onChanged: (_) {},
                      ),
                      const SizedBox(height: PrimeSpacing.md),
                      PrimeEntityPickerField(
                        label: 'Veículo',
                        value: null,
                        options: const [PrimePickerOption('1', 'ABC-1234')],
                        onChanged: (_) {},
                      ),
                      const SizedBox(height: PrimeSpacing.xl),
                      PrimeSectionHeader(
                        title: 'Carregando (skeleton)',
                        icon: Icons.hourglass_empty_outlined,
                        color: context.cs.accent,
                      ),
                      Row(
                        children: const [
                          Expanded(child: PrimeSkeletonStatTile()),
                          SizedBox(width: PrimeSpacing.sm),
                          Expanded(child: PrimeSkeletonStatTile()),
                        ],
                      ),
                      const SizedBox(height: PrimeSpacing.xl),
                      PrimeSectionHeader(
                        title: 'Estado vazio',
                        icon: Icons.inbox_outlined,
                        color: context.cs.accent,
                      ),
                      const PrimeCard(
                        child: PrimeEmptyState(title: 'Nada por aqui'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
