import 'package:flutter/widgets.dart';

import 'prime_tokens.dart';

/// Tokens **responsivos**: escalam espaçamento e tipografia conforme o tamanho
/// da tela, no padrão do app Wonderous (gskinner).
///
/// O fator [scale] cresce em telas maiores (tablet/desktop), deixando a UI mais
/// confortável sem mudar o layout. Acesse via `context.styles`:
///
/// ```dart
/// final s = context.styles;
/// Padding(padding: EdgeInsets.all(s.lg), child: ...);          // espaçamento escalado
/// Text('Título', style: s.scaleText(PrimeText.cardTitle));     // fonte escalada
/// ConstrainedBox(constraints: BoxConstraints(maxWidth: s.maxContentWidth));
/// ```
@immutable
class PrimeStyles {
  const PrimeStyles._(this.scale);

  /// Fator de escala aplicado a espaçamentos e fontes (1.0, 1.1 ou 1.2).
  final double scale;

  /// Deriva os tokens responsivos do `BuildContext` atual.
  ///
  /// `scale` vem do **menor lado** da tela: > 1000 → 1.2, > 800 → 1.1,
  /// senão 1.0 (mesma curva do Wonderous).
  factory PrimeStyles.of(BuildContext context) {
    final shortest = MediaQuery.sizeOf(context).shortestSide;
    final scale = shortest > 1000
        ? 1.2
        : shortest > 800
        ? 1.1
        : 1.0;
    return PrimeStyles._(scale);
  }

  /// Escala um valor arbitrário (ex.: tamanho de fonte) pelo [scale] atual.
  double sized(double value) => value * scale;

  /// Retorna uma cópia de [style] com `fontSize`/`height` escalados.
  TextStyle scaleText(TextStyle style) {
    final size = style.fontSize;
    if (size == null) return style;
    return style.copyWith(fontSize: size * scale);
  }

  /// Espaçamento pequeno escalado (`PrimeSpacing.sm`).
  double get sm => PrimeSpacing.sm * scale;

  /// Espaçamento médio escalado (`PrimeSpacing.md`).
  double get md => PrimeSpacing.md * scale;

  /// Espaçamento grande escalado (`PrimeSpacing.lg`).
  double get lg => PrimeSpacing.lg * scale;

  /// Espaçamento extra-grande escalado (`PrimeSpacing.xl`).
  double get xl => PrimeSpacing.xl * scale;

  /// Largura máxima de conteúdo legível — evita linhas longas demais em telas
  /// largas (centralize o conteúdo dentro deste cap).
  double get maxContentWidth => 800;
}

/// Acesso aos tokens responsivos via `BuildContext`. Uso: `context.styles.lg`.
extension PrimeStylesContext on BuildContext {
  /// Tokens responsivos derivados do tamanho atual da tela.
  PrimeStyles get styles => PrimeStyles.of(this);
}
