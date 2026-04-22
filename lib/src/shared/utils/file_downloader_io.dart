import 'dart:io';
import 'dart:typed_data';

void downloadFile(Uint8List bytes, String fileName) {
  final home = Platform.environment['USERPROFILE'] ?? // Windows
      Platform.environment['HOME'] ?? // macOS / Linux
      '';
  final path =
      '$home${Platform.pathSeparator}Downloads${Platform.pathSeparator}$fileName';
  File(path).writeAsBytesSync(bytes);
}
