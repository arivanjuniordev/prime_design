/// Prime Design — design system flat 2026 (Inter, marca parametrizável).
///
/// Uso típico:
/// ```dart
/// import 'package:prime_design/prime_design.dart';
///
/// MaterialApp(
///   theme: PrimeTheme.light(brand: const Color(0xFF16A34A)),
///   darkTheme: PrimeTheme.dark(brand: const Color(0xFF16A34A)),
/// );
/// ```
/// Dentro dos widgets, leia a paleta resolvida via `context.cs`.
library;

// ===== Tema =====
export 'src/theme/prime_colors.dart';
export 'src/theme/prime_text.dart';
export 'src/theme/prime_theme.dart';
export 'src/theme/prime_tokens.dart';
export 'src/theme/prime_styles.dart';

// ===== Utilitários =====
export 'src/prime_money.dart';
export 'src/prime_masks.dart';
export 'src/ui/prime_haptics.dart';
export 'src/services/prime_export_service.dart';

// ===== Componentes =====
export 'src/design_system/prime_badge.dart';
export 'src/design_system/prime_banner.dart';
export 'src/design_system/prime_button.dart';
export 'src/design_system/prime_card.dart';
export 'src/design_system/prime_chip.dart';
export 'src/design_system/prime_circle.dart';
export 'src/design_system/prime_date_field.dart';
export 'src/design_system/prime_dropdown_field.dart';
export 'src/design_system/prime_empty_state.dart';
export 'src/design_system/prime_error_banner.dart';
export 'src/design_system/prime_icon_box.dart';
export 'src/design_system/prime_info_box.dart';
export 'src/design_system/prime_info_tile.dart';
export 'src/design_system/prime_page_header.dart';
export 'src/design_system/prime_pill.dart';
export 'src/design_system/prime_pressable.dart';
export 'src/design_system/prime_reveal.dart';
export 'src/design_system/prime_search_field.dart';
export 'src/design_system/prime_section_header.dart';
export 'src/design_system/prime_skeleton.dart';
export 'src/design_system/prime_stat_tile.dart';
export 'src/design_system/prime_text_field.dart';
export 'src/design_system/prime_entity_form_scaffold.dart';
export 'src/design_system/prime_entity_picker.dart';
export 'src/design_system/prime_export_button.dart';
export 'src/design_system/prime_status_chip.dart';
export 'src/design_system/prime_surface.dart';
