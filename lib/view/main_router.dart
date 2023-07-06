import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_edit_cubit.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_entry_cubit.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_get_started_cubit.dart';
import 'package:smarthq_flutter_module/cubits/stand_mixer_cubits.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/resources/channels/routing_parameter/routing_parameter.dart';
import 'package:smarthq_flutter_module/resources/channels/routing_parameter/routing_parameter_body.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';
import 'package:smarthq_flutter_module/services/life_cycle_service.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/utils/no_animation_material_page_route.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/control/common/notification/history/notification_history_page.dart';
import 'package:smarthq_flutter_module/view/control/common/notification_setting_page.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/shortcut_get_started_page.dart';
import 'package:smarthq_flutter_module/view/dialog/push_notification/details/push_notification_alert_details_page.dart';
import 'package:smarthq_flutter_module/view/dialog/push_notification/push_notification_dialog.dart';

import 'package:smarthq_flutter_module/view/control/shortcut_page/shortcut_edit_page.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/shortcut_entry_page.dart';

import 'commissioning/navigator_page/gateway_navigator.dart';
import 'recipes/navigator/recipe_navigator.dart';

class MainRouter extends StatefulWidget {
  MainRouter({Key? key, this.lifeCycleService}) : super(key: key);

  final LifeCycleService? lifeCycleService;
  @override
  State createState() => _MainRouter();
}

class _MainRouter extends State<MainRouter> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    geaLog.debug('MainRouter:build');
    return Column(
      children: [
        Column(
          children: setBlocListeners(),
        ),
        Container(color: Colors.black,),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    geaLog.debug('MainRouter:initState');
    WidgetsBinding.instance.addObserver(this);

    _doRouteScreen();
  }

  @override
  void dispose() {
    super.dispose();
    geaLog.debug('MainRouter:dispose');
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    geaLog.debug('MainRouter:AppLifecycleState: $state');

    _handleLifeCycle(state);
    _handleRouting(state);
  }

  void _handleLifeCycle(AppLifecycleState state) {
    geaLog.debug('MainRouter:_handleLifeCycle: $state');

    if (state == AppLifecycleState.paused) {
      geaLog.debug("MainRouter:lifecycle - paused");
      widget.lifeCycleService?.setStatus = LifeCycleStatus.paused;
    }
    if (state == AppLifecycleState.resumed) {
      geaLog.debug("MainRouter:lifecycle - resumed");
      widget.lifeCycleService?.setStatus = LifeCycleStatus.resumed;
    }
  }

  void _handleRouting(AppLifecycleState state) {
    geaLog.debug('MainRouter:_handleRouting: $state');

    if (state == AppLifecycleState.resumed) {
      // Router is shown by Native Call
      _doRouteScreen();
    }
  }

  List<Widget> setBlocListeners() {
    return [
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.MOVE_TO_PAIR_SENSOR_PAGE
              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
        },
        listener: (context, state) {
          globals.subRouteName = Routes.GATEWAY_PAIR_SENSOR_DESCRIPTION_PAGE;
          Navigator.of(context, rootNavigator: true).pushNamed(
              Routes.GATEWAY_MAIN_NAVIGATOR,
              arguments: GatewayNavigatorArgs(calledFromFirstScreen: true));
        },
        child: Container(),
      ),
      /// Only for StandMixer ------------------------------------------------
      BlocListener<NativeCubit, NativeState>(
        listener: (context, state) {
          if(state.returnedRoute != null && state.returnedRoute!.contains('recipe')){
            moveToRecipeRoute(state.returnedRoute!);
          }
        },
        child: Container(),
      )
      /// --------------------------------------------------------------------
    ];
  }

  void _doRouteScreen() {
    Future.delayed(Duration.zero, () async {

      final nativeStorage = RepositoryProvider.of<NativeStorage>(context);
      final routingType = nativeStorage.routingType;
      final routingParameter = nativeStorage.routingParameter;

      /// Check Routing
      if (!_isPossibleToRoute(routingType)) return;

      geaLog.debug('MainRouter:_doRouteScreen:routingType($routingType), routingParameter:($routingParameter)');

      _initFlags();

      await _fetchEssentialDataFromNative();

      /// Routing Code from here.
      switch (routingType) {
        case RoutingType.initial:
          // The app must not route when RoutingType is RoutingType.initial.
          break;
        case RoutingType.commissioning:
        case RoutingType.commissioningFromDashboard:
          Navigator.of(context).pushNamed(Routes.ADD_APPLIANCE_PAGE);
          break;
        case RoutingType.pairSensor:
          var cubit = BlocProvider.of<BleCommissioningCubit>(context);
          cubit.actionDirectBleGetInfoToPairSensor();
          break;
        case RoutingType.notificationSettingPage:
          Navigator.push(
              context,
              NoAnimationMaterialPageRoute(
                  builder: (context) => NotificationSettingPage()));
          break;
        case RoutingType.notificationHistoryPage:
          /// The app does not use the notification history parameter now, but it will be used in the future.
          /// Since the native has not the info of the device id now.
          RoutingParameterBodyNotificationHistory? body;
          if (routingParameter != null) {
            body = routingParameter.body as RoutingParameterBodyNotificationHistory;
          }

          Navigator.push(
              context,
              NoAnimationMaterialPageRoute(
                builder: (context) => NotificationHistoryPage(arguments: body),
              ),
          );
          break;
        case RoutingType.notificationAlertDetailsPage:
          final kind = routingParameter?.kind;
          assert(kind == RoutingParameterKind.pushNotificationAlertDetails,
          'the kind value must be set as pushNotificationAlertDetails.');
          if (kind == RoutingParameterKind.pushNotificationAlertDetails) {
            final body = routingParameter?.body as RoutingParameterBodyPushNotificationAlertDetails;
            final args = PushNotificationAlertDetailsArgs(
                title: body.title ?? '',
                contentItems: body.contentItems ?? []
            );
            Navigator.push(
                context,
                NoAnimationMaterialPageRoute(
                    builder: (context) => PushNotificationAlertDetailsPage(arguments: args)));
          }
          break;
        case RoutingType.wifiLockerNetworkList:
          globals.subRouteName = Routes.COMMON_SAVED_NETWORK_LIST;
          Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
          break;
        case RoutingType.standMixer:
          BlocProvider.of<ApplianceCubit>(context).setCurrentAppliance().then((value) {
            globals.subRouteName = Routes.STAND_MIXER_CONTROL_PAGE;
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.STAND_MIXER_CONTROL_MAIN_NAVIGATOR);
          });
          break;
        case RoutingType.guidedRecipe:
          BlocProvider.of<ApplianceCubit>(context).setCurrentAppliance().then((value) {
            globals.subRouteName = Routes.RECIPE_DICOVER_PAGE;
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.RECIPE_MAIN_NAVIGATOR, arguments: RecipeFilterArguments(domains: RecipeDomains.SpeedcookGuided, isArthur: false));
          });
          break;

        case RoutingType.shortcut:
          Navigator.push(context, NoAnimationMaterialPageRoute(builder: (context) =>
              BlocProvider(
                  create: (BuildContext context) {
                    return GetIt.I.get<ShortcutEntryCubit>();
                    },
                  child: ShortcutEntryPage()
              )));
          break;

        case RoutingType.editShortcut:
          final routingParameter = nativeStorage.routingParameter;
          final parameterBody = routingParameter?.body as RoutingParameterBodyShortcut;
          Navigator.push(context, NoAnimationMaterialPageRoute(builder: (context) =>
              BlocProvider(
                  create: (BuildContext context) {
                    return GetIt.I.get<ShortcutEditCubit>();
                  },
                  child: ShortcutEditPage(routingParameter: parameterBody)
              )));
          break;

        case RoutingType.getStartedShortcut:
          Navigator.push(context, NoAnimationMaterialPageRoute(builder: (context) =>
              BlocProvider(
                  create: (BuildContext context) {
                    return GetIt.I.get<ShortcutGetStartedCubit>();
                    },
                  child: ShortcutGetStartedPage()
              )));
          break;

        default:
          break;
      }

      nativeStorage.setRoutingType = RoutingType.initial;
    });
  }

  bool _isPossibleToRoute(RoutingType routingType) {
    bool shouldRoute = true;
    /// If isCurrent value is not checked, _handleRouting method can run when this MainRouter is background also.
    /// It will occur unexpected result.
    /// However, there are some issue on Android (isCurrent value)
    /// So, instead of checking the isCurrent Value, the app uses the RoutingType.initial value.
    /// After the app routes the screen, the RoutingType.initial is set
    /// The app must not route if RoutingType is RoutingType.initial.
    if (routingType == RoutingType.initial)
      shouldRoute = false;

    return shouldRoute;
  }

  void moveToRecipeRoute(String routeName)  {
    final nativeStorage = RepositoryProvider.of<NativeStorage>(context);
    final routingType = nativeStorage.routingType;
    geaLog.debug('MainRouter:moveToRecipeRoute:$routeName');
    if(routeName.contains(RecipeRoutingStrings.Archetypes)){
      return;
    } else if (routeName == "/"){
      routeName = Routes.RECIPE_DICOVER_PAGE;
    }
    BlocProvider.of<ApplianceCubit>(context).setCurrentAppliance();
    Future.delayed(Duration(milliseconds: 800)).then((value) {
      globals.subRouteName = routeName;
      if (routingType == RoutingType.guidedRecipe){
        Navigator.of(context, rootNavigator: true).pushNamed(Routes.RECIPE_MAIN_NAVIGATOR, arguments: RecipeFilterArguments(domains: RecipeDomains.SpeedcookGuided, isArthur: false));
      } else {
        Navigator.of(context, rootNavigator: true).pushNamed(Routes.RECIPE_MAIN_NAVIGATOR);
      }
    });
  }

  Future _fetchEssentialDataFromNative() async {
    geaLog.debug('MainRouter:_fetchEssentialDataFromNative');

    await BlocProvider.of<NativeCubit>(context).fetchCountryCode();
  }

  void _initFlags() {
    geaLog.debug('MainRouter:_initFlags()');
    final nativeStorage = RepositoryProvider.of<NativeStorage>(context);
    final routingType = nativeStorage.routingType;

    nativeStorage.setIsStartCommissioningFromDashboard = false;
    nativeStorage.setIsStartPairSensor = false;

    switch (routingType) {
      case RoutingType.commissioning:
        nativeStorage.setIsStartCommissioningFromDashboard = false;
        break;
      case RoutingType.commissioningFromDashboard:
        nativeStorage.setIsStartCommissioningFromDashboard = true;
        break;
      case RoutingType.pairSensor:
        nativeStorage.setIsStartPairSensor = true;
        break;
      default:
        break;
    }
  }

}