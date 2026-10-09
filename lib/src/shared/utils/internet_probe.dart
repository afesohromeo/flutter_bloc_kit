// Picks the internet check for the platform: a DNS lookup where dart:io
// exists, the browser's status on web.
export 'internet_probe_stub.dart'
    if (dart.library.io) 'internet_probe_io.dart'
    if (dart.library.js_interop) 'internet_probe_web.dart';
