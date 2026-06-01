import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/design_tokens.dart';
import 'app_button.dart';
import 'app_card.dart';
import 'app_error_banner.dart';

/// Scaffold padrão dos formulários de cadastro: header com voltar, card com
/// os campos, banner de erro e botões cancelar/salvar. Centraliza o layout.
///
/// O rodapé fica no `body` (Column + Expanded), e NÃO em
/// `Scaffold.bottomNavigationBar`: este scaffold é renderizado aninhado dentro
/// do Scaffold do app_shell (rota filha do ShellRoute), e um `bottomNavigationBar`
/// aninhado recebe altura indevida e estoura o layout no mobile.
///
/// UX premium:
/// - tap em área vazia fecha o teclado;
/// - `resizeToAvoidBottomInset: true` (default) + scroll garante campos
///   visíveis sobre o teclado;
/// - banner de erro aparece/some com `AnimatedSize` + crossfade.
class PrimeEntityFormScaffold extends StatelessWidget {
  const PrimeEntityFormScaffold({
    super.key,
    required this.title,
    required this.fields,
    required this.saving,
    required this.onCancel,
    required this.onSave,
    this.errorMessage,
    this.saveLabel = 'Salvar',
    this.saveKey,
  });

  final String title;
  final List<Widget> fields;
  final bool saving;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final String? errorMessage;
  final String saveLabel;
  final Key? saveKey;

  static const double _maxWidth = 960;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(PrimeSpacing.xxl),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _maxWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: onCancel,
                              ),
                              const SizedBox(width: PrimeSpacing.sm),
                              Expanded(
                                child: Text(
                                  title,
                                  style: PrimeText.display.copyWith(
                                    color: cs.textPrimary,
                                    fontSize: PrimeText.s22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: PrimeSpacing.lg),
                          PrimeCard(
                            padding: const EdgeInsets.all(PrimeSpacing.xxl),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AnimatedSize(
                                  duration: PrimeMotion.normal,
                                  curve: PrimeMotion.curve,
                                  alignment: Alignment.topCenter,
                                  child: AnimatedSwitcher(
                                    duration: PrimeMotion.normal,
                                    child: errorMessage == null
                                        ? const SizedBox(
                                            key: ValueKey('no-error'),
                                            width: double.infinity,
                                          )
                                        : Padding(
                                            key: ValueKey(errorMessage),
                                            padding: const EdgeInsets.only(
                                              bottom: PrimeSpacing.lg,
                                            ),
                                            child: PrimeErrorBanner(
                                              message: errorMessage!,
                                            ),
                                          ),
                                  ),
                                ),
                                for (var i = 0; i < fields.length; i++) ...[
                                  if (i > 0)
                                    const SizedBox(height: PrimeSpacing.lg),
                                  fields[i],
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _StickyFooter(
                saving: saving,
                onCancel: onCancel,
                onSave: onSave,
                saveLabel: saveLabel,
                saveKey: saveKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Rodapé fixo com os botões Cancelar/Salvar. Fundo `surface`, borda superior
/// fina (`cs.border`) e conteúdo centralizado respeitando a `maxWidth` do form.
class _StickyFooter extends StatelessWidget {
  const _StickyFooter({
    required this.saving,
    required this.onCancel,
    required this.onSave,
    required this.saveLabel,
    required this.saveKey,
  });

  final bool saving;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final String saveLabel;
  final Key? saveKey;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return Material(
      color: cs.surface,
      child: SafeArea(
        top: false,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: cs.border)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(PrimeSpacing.xxl),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: PrimeEntityFormScaffold._maxWidth,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimeButton(
                        label: 'Cancelar',
                        variant: PrimeButtonVariant.secondary,
                        onPressed: saving ? null : onCancel,
                      ),
                    ),
                    const SizedBox(width: PrimeSpacing.md),
                    Expanded(
                      child: PrimeButton(
                        key: saveKey,
                        label: saveLabel,
                        loading: saving,
                        onPressed: saving ? null : onSave,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
