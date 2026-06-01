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
| **Reduce motion** (acessibilidade de movimento) | `PrimeMotion.*Of(context)` zera durações quando o usuário pede menos animação. `PrimeReveal` respeita reduce motion (sem animação se desativado). |
| **Escalar dentro do layout** (sem trocá-lo) | `PrimeStyles` (`context.styles`) aumenta espaçamento/fonte em tablet/desktop mantendo o mesmo layout. |

## Tokens responsivos (PrimeStyles)

Enquanto `PrimeBreakpoint` decide **qual layout** usar, `PrimeStyles` escala **dentro
do layout escolhido**: aumenta espaçamento e fonte em telas maiores sem reorganizar nada.

Acesse via `context.styles`. O fator `scale` vem do **menor lado** da tela:

- menor lado `> 1000` → `scale = 1.2`
- menor lado `> 800` → `scale = 1.1`
- caso contrário → `scale = 1.0`

API:

- `.scale` — fator atual (`1.0` / `1.1` / `1.2`).
- `.sized(double)` — escala um valor arbitrário.
- `.scaleText(TextStyle)` — devolve o `TextStyle` com `fontSize` escalado.
- `.sm` / `.md` / `.lg` / `.xl` — espaçamentos escalados.
- `.maxContentWidth` — largura máxima de conteúdo (`800`).

```dart
import 'package:prime_design/prime_design.dart';

// espaçamento escalado
Padding(padding: EdgeInsets.all(context.styles.lg));

// cap de largura em telas grandes
ConstrainedBox(
  constraints: BoxConstraints(maxWidth: context.styles.maxContentWidth),
  child: child,
);

// fonte escalada mantendo o estilo do token
Text('...', style: context.styles.scaleText(PrimeText.cardTitle));
```

> **Breakpoint × Styles:** o `PrimeBreakpoint` **decide o layout** (bottom nav × rail ×
> sidebar); o `PrimeStyles` **escala dentro** dele. Use os dois juntos.
>
> Padrão inspirado no app **Wonderous** (gskinner).

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
