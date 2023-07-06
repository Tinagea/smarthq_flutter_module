import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthq_flutter_module/cubits/stand_mixer_cubits.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/stand_mixer_control_page.dart' as StandMixer;

class StandMixerControlNavigator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        geaLog.debug('RecipeNavigator:onWillPop');
        SystemNavigator.pop();
        return false;
      },
      child: Navigator(
            initialRoute: Routes.STAND_MIXER_CONTROL_PAGE,
            onGenerateRoute: (RouteSettings settings) {
              geaLog.debug('StandMixerControlNavigator:onGenerateRoute: ${settings.name}');
              WidgetBuilder builder;
              switch (settings.name) {
                case Routes.STAND_MIXER_CONTROL_PAGE:
                  builder = (BuildContext _) => MultiBlocProvider(
                  providers: [
                      BlocProvider<RecipeStepsCubit>.value(
                       value: GetIt.I.get<RecipeStepsCubit>(),
                      ),

                      BlocProvider<StandMixerControlCubit>(
                       create: (context) =>  GetIt.I.get<StandMixerControlCubit>(),
                      ),
                  ],
                   child: StandMixer.StandMixerControlPage());
                  break;
                default:
                  throw Exception('Invalid route: ${settings.name}');
              }
              return MaterialPageRoute(builder: builder, settings: settings);
            },
          ),
    );
  }
}