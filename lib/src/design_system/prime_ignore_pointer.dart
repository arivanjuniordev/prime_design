import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Bloqueia hit-tests (ponteiro/toque) no [child] **mas mantém a semântica**
/// para leitores de tela.
///
/// Diferente de `IgnorePointer` (que pode remover semântica) e de
/// `ExcludeSemantics` (que remove o significado): use quando um elemento é
/// visual/decorativo ao toque mas ainda precisa ser anunciado por acessibilidade.
/// Inspirado no app Wonderous (gskinner).
class PrimeIgnorePointerKeepSemantics extends SingleChildRenderObjectWidget {
  /// Cria o wrapper que ignora ponteiro preservando semântica.
  const PrimeIgnorePointerKeepSemantics({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderIgnorePointerKeepSemantics();
}

class _RenderIgnorePointerKeepSemantics extends RenderProxyBox {
  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) => false;
}

/// Ignora **ponteiro e semântica** do [child] (decoração pura, invisível para
/// toque e leitores de tela). Combina `ExcludeSemantics` + `IgnorePointer`.
class PrimeIgnorePointerAndSemantics extends StatelessWidget {
  /// Cria o wrapper que ignora ponteiro e semântica.
  const PrimeIgnorePointerAndSemantics({super.key, required this.child});

  /// Conteúdo decorativo a ser ignorado por toque e acessibilidade.
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      ExcludeSemantics(child: IgnorePointer(child: child));
}
