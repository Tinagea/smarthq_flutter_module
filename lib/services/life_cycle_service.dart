

import 'package:smarthq_flutter_module/utils/log_util.dart';

abstract class LifeCycleService {

  LifeCycleStatus get status;
  set setStatus(LifeCycleStatus status);

  /// add the observer to listen the information
  void addObserver(LifeCycleObserver observer);
  /// remove the observer
  void removeObserver(LifeCycleObserver observer);
}

enum LifeCycleStatus {
  /// The status that the app has never been paused or resumed after running.
  init,

  /// The status that the app has been paused
  paused,

  /// The status that the app has been resumed
  resumed
}

abstract class LifeCycleObserver {
  void onChangeStatus(LifeCycleStatus status);
}

class LifeCycleServiceImpl implements LifeCycleService {
  static const String tag = "LifeCycleServiceImpl";
  LifeCycleServiceImpl();

  final List<LifeCycleObserver>_observers = [];

  var _status = LifeCycleStatus.init;
  @override set setStatus(LifeCycleStatus status) {
    _status = status;
    _observers.forEach((observer) {
      observer.onChangeStatus(status);
    });
  }
  @override LifeCycleStatus get status => _status;

  @override
  void addObserver(LifeCycleObserver observer) {
    geaLog.debug('$tag::addObserver()');
    _observers.add(observer);
  }

  @override
  void removeObserver(LifeCycleObserver observer) {
    geaLog.debug('$tag::addObserver()');
    _observers.remove(observer);
  }

}