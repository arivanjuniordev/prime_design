import 'package:flutter/material.dart';

import '../theme/prime_colors.dart';
import 'prime_badge.dart';

/// Mapeia status textuais comuns (ativo, pendente, vencido...) para cores
/// semânticas e renderiza um PrimeBadge. Centraliza a paleta de status do app.
class PrimeStatusChip extends StatelessWidget {
  /// Cria um chip para o [status] textual informado.
  const PrimeStatusChip(this.status, {super.key});

  /// Status textual da entidade (ex.: `ativo`, `vencido`, `em_andamento`).
  final String status;

  /// Cor semântica correspondente ao [status] (sucesso, alerta, erro ou info).
  static Color colorFor(String status) {
    switch (status.toLowerCase()) {
      case 'ativo':
      case 'concluida':
      case 'pago':
      case 'valido':
        return PrimePalette.success;
      case 'manutencao':
      case 'agendada':
      case 'em_andamento':
      case 'pendente':
      case 'planejada':
      case 'afastado':
      case 'recorrido':
        return PrimePalette.warning;
      case 'inativo':
      case 'cancelado':
      case 'cancelada':
      case 'vencido':
        return PrimePalette.error;
      default:
        return PrimePalette.info;
    }
  }

  /// Rótulo legível do [status], trocando `_` por espaço.
  static String labelFor(String status) => status.replaceAll('_', ' ');

  @override
  Widget build(BuildContext context) {
    // Cor sozinha não é acessível (depende de visão de cor). Anuncia o status
    // textualmente e exclui o texto UPPERCASE do badge para não ler duplicado.
    return Semantics(
      label: 'Status: ${labelFor(status)}',
      container: true,
      child: ExcludeSemantics(
        child: PrimeBadge(text: labelFor(status), color: colorFor(status)),
      ),
    );
  }
}
