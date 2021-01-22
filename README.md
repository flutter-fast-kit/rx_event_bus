# rx_event_bus

[![Pub](https://img.shields.io/pub/v/rx_event_bus.svg)](https://pub.dartlang.org/packages/rx_event_bus)
[![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square)]()
[![Awesome Flutter](https://img.shields.io/badge/Platform-Android_iOS-blue.svg?longCache=true&style=flat-square)]()
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](/LICENSE)

基于 `RxDart` 的事件总线。

## 安装

在 `pubspec.yaml` 添加依赖

```
dependencies:
  rx_event_bus: <last_version>
```
## 如何使用

因为 `Dart` 支持顶级函数, 所以可以直接定义

```dart
EventBus eventBus = EventBus();
```

然后定义通讯数据

```dart
class OnAppState {
  int state;
  const OnAppState(this.state); 
}
```

### 🛠 Base Broadcast

#### 1、注册接收器

```dart
eventBus.on<OnAppState>().listen((event) {
  print('event: ${event.state}');
});
```

#### 2、发送事件通知

```dart
eventBus.fire(OnAppState('paused'));
```

### 🧲 Sticky Broadcast

当👆上面的基础用法的发送事件通知在注册接收器前出发, 则消息会丢失, 如果需要得到消息, 则可使用粘性广播.

#### 1、注册接收器

```dart
eventBus.onSticky<OnAppState>().listen((event) {
  print('event: ${event.state}');
});
```

#### 2、发送事件通知

设置 `sticky` 为 `true` 则可发送粘性广播.

```dart
eventBus.fire(OnAppState('paused'), sticky: true);
```

**注意**: 粘性广播默认只会保留上一次的数据, 如需要自定义条数, 可使用如下方式:

```dart
EventBus eventBus = EventBus(maxSize: 10);
```

- maxSize: 粘性广播最大的留存条数