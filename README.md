# Prime Design

Design system Flutter **flat 2026** (fonte Inter), com **cor de marca parametrizável**.
Tema, tokens e ~26 componentes reutilizáveis — extraídos e generalizados do Eco Frota / Sharon.

## Instalação

```yaml
dependencies:
  prime_design:
    git:
      url: https://github.com/ecosafety/prime_design.git
      ref: v0.1.0
    # ou, quando publicado: prime_design: ^0.1.0
```

## Uso

```dart
import 'package:prime_design/prime_design.dart';

MaterialApp(
  theme: PrimeTheme.light(brand: const Color(0xFF16A34A)),
  darkTheme: PrimeTheme.dark(brand: const Color(0xFF16A34A)),
  themeMode: ThemeMode.system,
);
```

A **cor de marca** é o único parâmetro obrigatório do tema — cada app passa a sua.
`accentLight`/`accentDark` são derivados por luminância (HSL), com override opcional.

Dentro dos widgets, leia a paleta resolvida (marca + neutros do brilho atual) via
`context.cs`:

```dart
Container(color: context.cs.accent);
Text('...', style: TextStyle(color: context.cs.textPrimary));
```

## O que vem dentro

- **Tema:** `PrimeTheme.light/dark`, `PrimeColors` (`ThemeExtension`), `AppColors` (neutros/semânticos).
- **Tokens:** `AppSpacing`, `AppRadius`, `AppElevation`, `AppText`, `AppMotion`, `Breakpoint`.
- **Componentes:** `AppButton`, `AppCard`, `AppBadge`, `AppChip`, `AppTextField`,
  `AppDropdownField`, `AppDateField`, `AppSearchField`, `AppEmptyState`, `AppErrorBanner`,
  `AppStatTile`, `StatusChip`, `EntityPicker`, `EntityFormScaffold`, `ExportButton`, … (26 no total).
- **Utilitários:** `formatMoney`/`parseMoney` (centavos), `formatLitros`/`parseLitros` (ml),
  `MoneyTextInputFormatter`, máscaras, `Haptics`, exportação CSV/Excel/PDF.

## Convenções (herdadas)

- **Dinheiro em centavos (int)**, **litros em mililitros (int)** — nunca `double`.
- Cor de marca via tema; neutros/espaçamentos via tokens — nunca hardcoded.
- Design flat: 1 sombra suave + borda 1px, cantos arredondados (raio 14).

## Exemplo

`example/` traz uma galeria que troca a marca em tempo real e alterna claro/escuro:

```bash
cd example && flutter run
```
