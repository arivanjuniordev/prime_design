import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/prime_tokens.dart';

/// Animação de **entrada** reutilizável (fade + slide suave), inspirada nas
/// revelações coreografadas do app Wonderous (gskinner).
///
/// Respeita *reduce motion*: se o usuário desativou animações, renderiza o
/// [child] direto, sem animar.
///
/// ```dart
/// PrimeReveal(child: PrimeCard(child: ...));               // entra com fade+slide
/// PrimeReveal(delay: 120.ms, child: ...);                  // com atraso
/// PrimeReveal.stagger(children: [a, b, c]);                // revelação escalonada
/// ```
class PrimeReveal extends StatelessWidget {
  /// Cria uma revelação de entrada para [child].
  const PrimeReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.slide = 0.12,
  });

  /// Widget revelado.
  final Widget child;

  /// Atraso antes de iniciar a animação (útil para escalonar).
  final Duration delay;

  /// Deslocamento vertical inicial como fração da altura (0 = só fade).
  final double slide;

  @override
  Widget build(BuildContext context) {
    // Reduce motion (acessibilidade): sem animação, entrega o conteúdo direto.
    if (MediaQuery.disableAnimationsOf(context)) return child;
    final duration = PrimeMotion.normal;
    return child
        .animate(delay: delay)
        .fadeIn(duration: duration, curve: PrimeMotion.curve)
        .slideY(
          begin: slide,
          end: 0,
          duration: duration,
          curve: PrimeMotion.curve,
        );
  }

  /// Empilha [children] numa coluna com revelação **escalonada**: cada filho
  /// entra [interval] depois do anterior. Também respeita *reduce motion*.
  static Widget stagger({
    Key? key,
    required List<Widget> children,
    Duration interval = const Duration(milliseconds: 70),
    Duration initialDelay = Duration.zero,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.stretch,
    double slide = 0.12,
  }) {
    return Column(
      key: key,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        for (var i = 0; i < children.length; i++)
          PrimeReveal(
            delay: initialDelay + interval * i,
            slide: slide,
            child: children[i],
          ),
      ],
    );
  }
}
