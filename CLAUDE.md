# CLAUDE.md — prime_design (package Flutter)

Design system **flat 2026** (fonte Inter) com **cor de marca parametrizável**, publicável.
Genérico e reutilizável em qualquer app. Repo: `arivanjuniordev/prime_design`.

## O que é

Package Flutter (`publish_to: none` por enquanto) que entrega tema, tokens e ~27
componentes `Prime*`. Consumido via git dependency:

```yaml
prime_design:
  git:
    url: https://github.com/arivanjuniordev/prime_design.git
    ref: v0.1.0
```

```dart
import 'package:prime_design/prime_design.dart';
MaterialApp(theme: PrimeTheme.light(brand: const Color(0xFF16A34A)));
```

## Estrutura

```
lib/
├── prime_design.dart          # barrel (ÚNICA API pública — exporta src/*)
└── src/
    ├── theme/
    │   ├── prime_colors.dart   # PrimePalette (neutros/semânticos const) +
    │   │                       #   PrimeColors (ThemeExtension, marca resolvida) + context.cs
    │   ├── prime_theme.dart     # PrimeTheme.light/dark({brand, fontFamily})
    │   ├── prime_tokens.dart    # PrimeSpacing/Radius/Elevation/Motion/Breakpoint
    │   ├── prime_text.dart      # PrimeText (escala tipográfica)
    │   └── prime_styles.dart    # PrimeStyles (tokens responsivos: scale por tela, context.styles)
    ├── design_system/prime_*.dart   # 27 componentes (1 classe pública por arquivo)
    │                                #   inclui prime_reveal.dart (animação de entrada fade+slide)
    ├── prime_money.dart         # PrimeMoney/PrimeLitros/PrimeMoneyInputFormatter
    ├── prime_masks.dart         # PrimeCpfMask/Cnpj/Telefone/Cep/Placa/Renavam
    ├── ui/prime_haptics.dart    # PrimeHaptics
    └── services/prime_export_service.dart  # PrimeExportService (CSV/Excel/PDF via compute())
assets/fonts/                    # Inter bundlada (packages/prime_design/Inter)
example/                         # galeria; troca marca + claro/escuro em runtime
test/                            # 69 testes: lógica/interação + property-based
                                 #   (glados) + leak tracking (flutter_test_config.dart)
doc/PERFORMANCE.md · doc/RESPONSIVE.md
```

## Convenções obrigatórias

- **Tudo `Prime*`** — classes E arquivos (`prime_<nome>.dart`). Sem `App*` na API.
- **Cor de marca via parâmetro**, nunca hardcoded. Widget lê cor por `context.cs.accent`
  (do `PrimeColors`/`ThemeExtension`); neutros/semânticos fixos em `PrimePalette`.
- **Tokens, nunca valores soltos**: `PrimeSpacing`/`PrimeRadius`/`PrimeText`.
- **Dinheiro em centavos (int)**, **litros em mililitros (int)** — nunca `double`.
- **dartdoc em TODA a API pública** (lint `public_member_api_docs: true` — é gate).
- **Perf**: zero `Opacity`/`saveLayer`/`ClipPath`/`ColorFilter`/intrinsics; esmaecer com
  `withValues(alpha:)`; listas com `.builder`; CPU pesado em `compute()`. Ver [doc/PERFORMANCE.md](doc/PERFORMANCE.md).
- **Responsivo**: `PrimeBreakpoint` é a fonte única; `SafeArea` em sheets. Ver [doc/RESPONSIVE.md](doc/RESPONSIVE.md).
- Um arquivo `prime_<x>.dart` → uma classe/componente público; adicione o `export` no barrel.
- pt-BR nos comentários e docs.

## Comandos

```bash
flutter pub get
flutter analyze lib test     # deve dar "No issues found!"
flutter test                 # 32 testes — manter verde
cd example && flutter run     # galeria (medir perf aqui, em --profile)
```

## AI tooling

- `.mcp.json` carrega o `dart mcp-server` (analyze/test/format/hot-reload). Prefira-o ao shell.
- Skills em `.agents/skills/` (Flutter + Dart) — ex.: `flutter-add-widget-test`, `dart-collect-coverage`.

## Ao adicionar um componente

1. `lib/src/design_system/prime_<nome>.dart` com 1 classe `Prime<Nome>`.
2. Cores via `context.cs`, espaçamento via tokens, dartdoc em tudo.
3. `export` no barrel `lib/prime_design.dart`.
4. Teste em `test/` (smoke no mínimo). `flutter analyze lib test` + `flutter test` verdes.
5. Atualize o `CHANGELOG.md`.
