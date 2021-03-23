import 'dart:async';

import 'package:rxdart/subjects.dart';

/// 事件总线
///
/// 基于 [rxdart] 的事件总线
class EventBus {
  late PublishSubject _publishSubject;
  late ReplaySubject _replaySubject;

  PublishSubject get publishSubject => _publishSubject;
  ReplaySubject get replaySubject => _replaySubject;

  /// 创建 EventBus
  ///
  /// [sync] 是否使用同步方式, 默认为 [false]
  /// [maxSize] 粘性广播最大支持的回放次数, 默认为1
  EventBus({bool sync = false, maxSize = 1}) {
    _publishSubject = PublishSubject(sync: sync);
    _replaySubject = ReplaySubject(sync: sync, maxSize: maxSize);
  }

  /// 监听广播的回调事件
  Stream<T> on<T>() {
    if (T == dynamic) {
      return _publishSubject.stream as Stream<T>;
    } else {
      return _publishSubject.stream.where((event) => event is T).cast<T>();
    }
  }

  /// 监听粘性广播的回调事件
  ///
  Stream<T> onSticky<T>() {
    if (T == dynamic) {
      return _replaySubject.stream as Stream<T>;
    } else {
      return _replaySubject.stream.where((event) => event is T).cast<T>();
    }
  }

  /// 发送广播
  ///
  /// [sticky] 当值为 true 时, 则发送粘性广播
  void fire(event, {bool sticky = false}) {
    if (sticky) {
      _replaySubject.add(event);
    } else {
      _publishSubject.add(event);
    }
  }

  /// 销毁
  void destroy() {
    _publishSubject.close();
    _replaySubject.close();
  }
}
