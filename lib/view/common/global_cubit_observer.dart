import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class GlobalCubitObserver extends BlocObserver {
  @override
  void onChange(BlocBase cubit, Change change) {
    geaLog.debug('${cubit.runtimeType}, $change');
    super.onChange(cubit, change);
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    geaLog.debug('${cubit.runtimeType}, $error, $stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}