import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract class IndexControllerEventBase {
  IndexControllerEventBase({
    required this.animation,
  });

  final bool animation;

  final completer = Completer<void>();
  Future<void> get future => completer.future;
  void complete() {
    if (!completer.isCompleted) {
      completer.complete();
    }
  }
}

mixin TargetedPositionControllerEvent on IndexControllerEventBase {
  double get targetPosition;
}
mixin StepBasedIndexControllerEvent on TargetedPositionControllerEvent {
  int get step;
  int calcNextIndex({
    required int currentIndex,
    required int itemCount,
    required bool loop,
    required bool reverse,
  }) {
    var cIndex = currentIndex;
    if (reverse) {
      cIndex -= step;
    } else {
      cIndex += step;
    }

    if (!loop) {
      if (cIndex >= itemCount) {
        cIndex = itemCount - 1;
      } else if (cIndex < 0) {
        cIndex = 0;
      }
    }
    return cIndex;
  }
}

class NextIndexControllerEvent extends IndexControllerEventBase
    with TargetedPositionControllerEvent, StepBasedIndexControllerEvent {
  NextIndexControllerEvent({
    required bool animation,
  }) : super(
          animation: animation,
        );

  @override
  int get step => 1;

  @override
  double get targetPosition => 0;
}

class PrevIndexControllerEvent extends IndexControllerEventBase
    with TargetedPositionControllerEvent, StepBasedIndexControllerEvent {
  PrevIndexControllerEvent({
    required bool animation,
  }) : super(
          animation: animation,
        );
  @override
  int get step => -1;

  @override
  double get targetPosition => 1;
}

class MoveIndexControllerEvent extends IndexControllerEventBase
    with TargetedPositionControllerEvent {
  MoveIndexControllerEvent({
    required this.newIndex,
    required this.oldIndex,
    required bool animation,
  }) : super(
          animation: animation,
        );
  final int newIndex;
  final int oldIndex;
  @override
  double get targetPosition => newIndex > oldIndex ? 1 : 0;
}

class IndexController extends ChangeNotifier {
  IndexControllerEventBase? event;
  int index = 0;
  Future<void> move(int index, {bool animation = true}) {
    final e = event = MoveIndexControllerEvent(
      animation: animation,
      newIndex: index,
      oldIndex: this.index,
    );
    notifyListeners();
    return e.future;
  }

  Future<void> next({bool animation = true}) {
    final e = event = NextIndexControllerEvent(animation: animation);
    notifyListeners();
    return e.future;
  }

  Future<void> previous({bool animation = true}) {
    final e = event = PrevIndexControllerEvent(animation: animation);
    notifyListeners();
    return e.future;
  }
}
