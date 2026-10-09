import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

/// Waits until no new event has arrived for [duration], then handles only the
/// latest one. Handlers run one at a time.
EventTransformer<E> debounceSequential<E>(Duration duration) {
  return (events, mapper) =>
      events.transform(_debounce<E>(duration)).asyncExpand(mapper);
}

StreamTransformer<T, T> _debounce<T>(Duration duration) {
  return StreamTransformer<T, T>((input, cancelOnError) {
    Timer? timer;
    StreamSubscription<T>? subscription;
    late final StreamController<T> controller;

    controller = StreamController<T>(
      sync: true,
      onListen: () {
        subscription = input.listen(
          (value) {
            timer?.cancel();
            timer = Timer(duration, () => controller.add(value));
          },
          onError: controller.addError,
          onDone: () {
            timer?.cancel();
            controller.close();
          },
          cancelOnError: cancelOnError,
        );
      },
      onPause: () => subscription?.pause(),
      onResume: () => subscription?.resume(),
      onCancel: () {
        timer?.cancel();
        return subscription?.cancel();
      },
    );

    return controller.stream.listen(null, cancelOnError: cancelOnError);
  });
}
