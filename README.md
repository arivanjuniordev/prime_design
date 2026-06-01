# Prime Design

Design system Flutter **flat 2026** (fonte Inter), com **cor de marca parametrizável**.
Tema, tokens e ~27 componentes reutilizáveis, prontos para qualquer app.

## Instalação

```yaml
dependencies:
  prime_design:
    git:
      url: https://github.com/arivanjuniordev/prime_design.git
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

- **Tema:** `PrimeTheme.light/dark`, `PrimeColors` (`ThemeExtension`), `PrimePalette` (neutros/semânticos).
- **Tokens:** `PrimeSpacing`, `PrimeRadius`, `PrimeElevation`, `PrimeText`, `PrimeMotion`, `PrimeBreakpoint`,
  `PrimeStyles` (tokens responsivos — escala espaçamento/fonte por tamanho de tela via `context.styles`).
- **Componentes:** `PrimeButton`, `PrimeCard`, `PrimeBadge`, `PrimeChip`, `PrimeTextField`,
  `PrimeDropdownField`, `PrimeDateField`, `PrimeSearchField`, `PrimeEmptyState`, `PrimeErrorBanner`,
  `PrimeStatTile`, `PrimeStatusChip`, `PrimeEntityPicker`, `PrimeEntityFormScaffold`, `PrimeExportButton`,
  `PrimeReveal` (animação de entrada fade+slide, com `.stagger`; respeita reduce motion), … (27 no total).
- **Utilitários:** `PrimeMoney.format/parse` (centavos), `PrimeLitros.format/parse` (ml),
  `PrimeMoneyInputFormatter`, máscaras (`PrimeCpfMask`, `PrimePlacaMask`…), `PrimeHaptics`,
  `PrimeExportService`/`PrimeExportButton` (CSV/Excel/PDF).

## Convenções (herdadas)

- **Dinheiro em centavos (int)**, **litros em mililitros (int)** — nunca `double`.
- Cor de marca via tema; neutros/espaçamentos via tokens — nunca hardcoded.
- Design flat: 1 sombra suave + borda 1px, cantos arredondados (raio 14).

## Documentação

- [doc/PERFORMANCE.md](doc/PERFORMANCE.md) — anti-padrões evitados, como **medir** (profile mode + DevTools), caçar jank e metas de métricas.
- [doc/RESPONSIVE.md](doc/RESPONSIVE.md) — breakpoints (`PrimeBreakpoint`), tokens responsivos (`PrimeStyles`), `SafeArea`, layout fluido e padrão adaptativo.

## Testes

```bash
flutter test   # 64 testes: tema/marca, money, máscaras, status, tokens, styles,
               #            reveal, a11y, picker (lógica) e interações
```

## Exemplo

`example/` traz uma galeria que troca a marca em tempo real e alterna claro/escuro:

```bash
cd example && flutter run
```
