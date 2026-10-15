import 'package:flutter/services.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Given text when it is copied then the clipboard receives it', () async {
    final calls = <MethodCall>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
          calls.add(call);
          return null;
        });
    addTearDown(
      () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, null),
    );

    await const ClipboardProvider().copyText('K7P-3QX');

    final setData = calls.singleWhere((c) => c.method == 'Clipboard.setData');
    expect((setData.arguments as Map)['text'], 'K7P-3QX');
  });
}
