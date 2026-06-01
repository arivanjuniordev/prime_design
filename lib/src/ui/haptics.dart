import 'package:flutter/services.dart';

/// Wrappers centralizados de feedback tátil. Use estes ao invés de chamar
/// `HapticFeedback.*` direto — assim podemos no futuro desligar global ou
/// trocar a intensidade por contexto.
class Haptics {
  Haptics._();

  /// Tap leve: botões, cards interativos, FABs.
  static Future<void> tap() => HapticFeedback.lightImpact();

  /// Seleção: toggles, picker, mudança de aba.
  static Future<void> select() => HapticFeedback.selectionClick();

  /// Confirmação positiva: save concluído, ação irreversível.
  static Future<void> success() => HapticFeedback.mediumImpact();

  /// Erro / atenção: falha de rede, validação rejeitada.
  static Future<void> error() => HapticFeedback.heavyImpact();
}
