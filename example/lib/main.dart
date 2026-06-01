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
          body: ListView(
            padding: const EdgeInsets.all(PrimeSpacing.lg),
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
                    Text('Dinheiro & litros', style: PrimeText.cardTitle),
                    const SizedBox(height: PrimeSpacing.sm),
                    Text(
                      '${PrimeMoney.format(123456)} · ${PrimeLitros.format(40000)}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: PrimeSpacing.xl),
              PrimeSectionHeader(
                title: 'Campo de texto',
                icon: Icons.text_fields_outlined,
                color: context.cs.accent,
              ),
              const PrimeTextField(label: 'Nome'),
            ],
          ),
        ),
      ),
    );
  }
}
