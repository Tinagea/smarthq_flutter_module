import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/cubits/dialog/dialog_cubit.dart';
import 'package:smarthq_flutter_module/cubits/stand_mixer_cubits.dart';

class AppBlocProviders {
  AppBlocProviders._();

  static final List<BlocProvider<dynamic>> blocProviders = [
    BlocProvider<NativeCubit>(
      create: (context) => GetIt.I.get<NativeCubit>(),
    ),
    BlocProvider<CommissioningCubit>(
      create: (context) => GetIt.I.get<CommissioningCubit>(),
    ),
    BlocProvider<BleCommissioningCubit>(
      create: (context) => GetIt.I.get<BleCommissioningCubit>(),
    ),
    BlocProvider<NotificationSettingCubit>(
      create: (context) => GetIt.I.get<NotificationSettingCubit>(),
    ),
    BlocProvider<NotificationHistoryCubit>(
      create: (context) => GetIt.I.get<NotificationHistoryCubit>(),
    ),
    BlocProvider<ErdCubit>(
      create: (context) => GetIt.I.get<ErdCubit>(),
    ),
    BlocProvider<ApplianceCubit>(
      create: (context) =>GetIt.I.get<ApplianceCubit>(),
    ),
  ];

  static final List<BlocProvider<dynamic>> blocProvidersForDialog = [
    BlocProvider<DialogCubit>(
      create: (context) => GetIt.I.get<DialogCubit>(),
    ),
  ];
}