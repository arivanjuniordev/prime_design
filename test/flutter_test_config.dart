import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

/// Habilita o leak_tracker (integrado ao flutter_test) para TODOS os testes
/// deste diretório: se um `testWidgets` deixar vazar um objeto descartável
/// (controller, ticker, node não liberado), o teste falha.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  LeakTesting.enable();
  LeakTesting.settings = LeakTesting.settings.withTrackedAllFlutterObjects();
  await testMain();
}
