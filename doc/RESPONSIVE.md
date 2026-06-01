# Responsividade & Adaptação — prime_design

Como o design system segue o guia [Adaptive & responsive design](https://docs.flutter.dev/ui/adaptive-responsive).

> **Responsivo** = ajustar o layout pra *caber* no espaço. **Adaptativo** = escolher o
> layout/input certo pra ser *usável* naquele espaço. Componentes atômicos (botão, card,
> campo) são responsivos por natureza: preenchem as constraints que recebem. As decisões
> adaptativas (bottom nav × rail × sidebar) ficam no **app**, usando os tokens daqui.

## O que o package oferece

| Ponto do guia | No prime_design |
|---|---|
| **Fonte única de breakpoints** | `PrimeBreakpoint` (`compact <600`, `medium <840`, `expanded <1200`, `large`), com `PrimeBreakpoint.of(context)` via `MediaQuery.sizeOf`. |
| **`LayoutBuilder`/`MediaQuery` em vez de checar device** | Tokens decidem por **largura**, nunca por "é tablet". |
| **`SafeArea`** em superfícies full-screen | `PrimeEntityPicker` (bottom sheet) e `PrimeEntityFormScaffold` envolvem o conteúdo. |
| **Cap de largura em telas grandes** | O sheet do `PrimeEntityPicker` limita a largura máxima (não estica num desktop). |
| **Layout fluido (não hardcoded)** | `Flexible`/`Expanded`/`Wrap` em 9 componentes (banner, page header, section header, info box/tile, form scaffold…). |
| **Respeitar text scaling** | Tipografia via `PrimeText`/`Theme.textTheme` (sem travar altura que cortaria texto ampliado); sem `MediaQuery.textScaler` desativado. |
| **Reduce motion** (acessibilidade de movimento) | `PrimeMotion.*Of(context)` zera durações quando o usuário pede menos animação. |

## Padrão recomendado no app

Use `PrimeBreakpoint` como única fonte de verdade pra alternar layouts:

```dart
import 'package:prime_design/prime_design.dart';

@override
Widget build(BuildContext context) {
  final bp = PrimeBreakpoint.of(context);
  if (bp.isCompact) return const _MobileLayout();      // bottom nav
  if (bp.isAtLeastExpanded) return const _DesktopLayout(); // sidebar
  return const _TabletLayout();                          // rail
}
```

Ou, dentro de um componente, reaja às **constraints** locais:

```dart
LayoutBuilder(
  builder: (context, c) => c.maxWidth < 480
      ? const _Stacked()   // empilha
      : const _SideBySide(),
);
```

## Checklist (app consumidor)

- [ ] Alterna layout por **largura** (`PrimeBreakpoint`/`LayoutBuilder`), não por tipo de device?
- [ ] Conteúdo crítico dentro de `SafeArea`?
- [ ] Larguras fluidas (`Flexible`/`Expanded`/`Wrap`), sem `width:` fixo grande?
- [ ] Testado em retrato/paisagem e com **fonte ampliada** (sem overflow)?
- [ ] Navegação adaptada: bottom nav (compact) × rail (medium) × sidebar (expanded+)?
- [ ] Suporte a teclado/mouse/foco no desktop/web?
