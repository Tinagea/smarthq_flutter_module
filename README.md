# SmartHQ Flutter Module Project

This project supports the commissioning feature and it is used in the SmartHQ Home app developed for iOS and Android.
Actual business logic is implemented in Native, and Flutter Module uses business logic through Flutter Channel.

Currently, most of the Flutter Module Project is consist of UI-related. 
But we have plan to convert the business logic to Flutter Module Project from Native Project, gradually.

## Table of Contents
- [Table of Contents](#table-of-contents)
- [Design Pattern](https://github.com/geappliances/mobile.connected.smarthq.flutter/tree/develop/smarthq_flutter_module/docs/design_pattern.md)
- [Getting Started](#getting-started)
- [Build Environment](#build-environment)
- [Feature Management](#feature-management)
- [How to use in Native](#how-to-use-in-native)
- [Showing and Navigating screen in Flutter](#showing-and-navigating-screen-in-flutter)
- [How to use the WebSocket Resource](#how-to-use-the-websocket-resource)
- [Run with Mock Up in Flutter](#run-with-mock-up-in-flutter)
- [Use TestManager to set the environment like as Native](#use-testmanager-to-set-the-environment-like-as-native)
- [Repositories](#repositories)

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.dev/).

For instructions integrating Flutter modules to your existing applications,
see the [add-to-app documentation](https://flutter.dev/docs/development/add-to-app).


## Build Environment
The Flutter Module Project can be built and run itself.

Execute the script as below in the terminal window, 
```sh
install_flutter.sh
```

and Open the smarthq_fullter_module using Android Studio,

and Type shortcut as below in Android Studio.
> Command key + R
<img width="70%" alt="image" src="https://user-images.githubusercontent.com/32116640/166455226-b8a879b1-16a0-4221-8b31-dfc28a1394ba.png">

## Feature Management
You can enable or disable features that have been developed through EnvFeatureType. 

  - #### Define flag
    ![image](https://user-images.githubusercontent.com/32116012/201808514-8da72f35-4be8-480c-bc1a-bf998cf90fb8.png)
  
  - #### Use code
    ![image](https://user-images.githubusercontent.com/32116012/201808164-a6b1b6c5-61d7-4dc0-8226-9074665d4211.png)
  
  - #### Enable by build Environment
    - Develop<br>
    ![image](https://user-images.githubusercontent.com/32116012/201807838-b1621a06-8732-4432-9725-d09385722685.png)
    - Field<br> 
    ![image](https://user-images.githubusercontent.com/32116012/201807940-c338611e-56a2-4364-b6cf-0f11c8693291.png)
    - Production<br> 
    ![image](https://user-images.githubusercontent.com/32116012/201808013-7aa98ca2-49e8-4d76-b80b-7ca5304cfad5.png)
  
When the feature is finally released to public, you must remove the flags from the codes.


## How to use in Native
As mentioned above, the module operates with Native through Channel.
Therefore, you must understand the flow of the Channel's function to use the module.

- ### Channels
  - #### Native Channel
    Channel for sending and receiving information necessary for Basic app's operation
    ```dart
    /// Called for routing when Native shows the Flutter screen.
    /// It is necessary to return the status screen or commissioning for each home appliance.
    /// key - 'routingType'
    /// value - String
    /// {'routingType':'commissioning'} - commissioning screen must be fixed.
    /// {'routingType':String} - The status screen is a string type, and you can add it in the lowerCamelCase form.
    static const F2N_DIRECT_GET_ROUTING_TYPE = "f2n_direct_get_routing_type";
    /// Called for getting the mobile device token info
    /// key - 'mdt'
    /// value - String
    static const F2N_DIRECT_GET_MDT = "f2n_direct_get_mdt";
    /// Called for getting the ge token info
    /// key - 'geToken'
    /// value - String
    static const F2N_DIRECT_GET_GE_TOKEN = "f2n_direct_get_ge_token";
    /// Called for getting the language preference info
    /// key - 'languagePreference'
    /// value - String
    static const F2N_DIRECT_GET_LANGUAGE_PREFERENCE = "f2n_direct_get_language_preference";


    static const N2F_DIRECT_START_SERVICE = "n2f_direct_start_service";
    ```
    
  - #### Commissioning Channel
    Channel for sending and receiving information necessary for WiFi commissioning
    
    ```dart
    static const ACTION_REQUEST_APPLICATION_PROVISIONING_TOKEN = "action_request_application_provisioninig_token";
    static const LISTEN_APPLICATION_PROVISIONING_TOKEN_RESPONSE = "listen_application_provisioning_token_response"; // isSuccess: bool
    static const ACTION_SAVE_ACM_PASSWORD = "action_save_acm_password"; // acmpassword: String
    static const LISTEN_CONNECTED_GE_MODULE_WIFI = "listen_connected_ge_module_wifi"; // isSuccess: bool
    static const ACTION_REQUEST_COMMISSIONING_DATA = "action_request_commissioning_data";
    static const ACTION_REQUEST_GE_MODULE_REACHABILITY = "action_request_ge_module_reachability"; // isOn: bool
    static const LISTEN_COMMISSIONING_DATA_RESPONSE = "listen_commissioning_data_response"; // isSuccess: bool
    static const ACTION_GET_RECOMMEND_SSID = "action_get_recommend_ssid";
    static const LISTEN_RECOMMEND_SSID = "listen_recommend_ssid"; // ssid: String // if there is not, ""
    static const ACTION_REQUEST_NETWORK_LIST = "action_request_network_list";
    static const LISTEN_NETWORK_LIST = "listen_network_list"; // ssid: String, securityType: String
    static const ACTION_SAVE_SELECTED_NETWORK_INFORMATION = "action_save_selected_network_information"; // ssid: String, securityType: String, password: String
    static const ACTION_START_COMMISSIONING = "action_start_commissioning";
    static const LISTEN_PROGRESS_STEP = "listen_progress_step"; // step: int, isSuccess: bool
    static const ACTION_REQUEST_RELAUNCH = "action_request_relaunch";
    static const ACTION_MOVE_TO_NATIVE_BACK_PAGE = "action_move_to_native_back_page";
    static const ACTION_CHECK_CONNECTED_GE_MODULE_WIFI = "action_check_connected_ge_module_wifi";
    static const ACTION_DIRECT_REQUEST_SELECTED_BRAND_TYPE = "action_direct_request_selected_brand_type";
    static const ACTION_DIRECT_REQUEST_USER_COUNTRY_CODE = "action_direct_request_user_country_code";
    static const ACTION_COMMISSIONING_SUCCESSFUL = "action_commissioning_successful";
    ```
    
  - #### BleCommissioning Channel
    Channel for sending and receiving information necessary for BLE commissioning
    ```dart
    static const ACTION_DIRECT_BLE_GET_SEARCHED_BEACON_LIST = "action_direct_ble_get_searched_beacon_list"; // [applianceType: [String]] and null
    static const ACTION_BLE_MOVE_TO_WELCOME_PAGE = "action_ble_move_to_welcome_page"; // applianceType: String, subType: String, isBleMode: Bool

    static const ACTION_BLE_START_IBEACON_SCANNING = "action_ble_start_ibeacon_scanning"; // durationSecTime: int
    static const LISTEN_BLE_IBEACON_SCANNING_RESULT = "listen_ble_ibeacon_scanning_result"; // [applianceType: String] and null

    static const ACTION_BLE_START_ALL_SCANNING = "action_ble_start_all_scanning"; // durationSecTime: int
    static const ACTION_BLE_START_ADVERTISEMENT_SCANNING = "action_ble_start_advertisement_scanning"; // durationSecTime: int

    static const LISTEN_BLE_DETECTED_SCANNING = "listen_ble_detected_scanning"; // [scanType: String(ibeacon,advertisement), advertisementIndex: int, applianceType: String]
    static const LISTEN_BLE_FINISHED_SCANNING = "listen_ble_finished_scanning";
    static const ACTION_BLE_STOP_SCANNING = "action_ble_stop_scanning";

    static const ACTION_BLE_START_PAIRING_ACTION1 = "action_ble_start_pairing_action1"; // applianceType: String
    static const LISTEN_BLE_START_PAIRING_ACTION1_RESULT = "listen_ble_start_pairing_action1_result"; // applianceType: String, isSuccess: bool
    ```
  - #### Appliance Service Channel
    Channel for sending and receiving information necessary for Websocket (ERD and V2) - coming soon.
    

## Showing and Navigating screen in Flutter
> There are two main ways to navigate.
> 1. Flutter itself renders the entire screen and navigates.
> 2. Native (Android, iOS) renders the full screen, and Flutter renders only a part of them as View, and navigation by Native.

- ### Routing to show the screen
> 1. Show the flutter screen in Native.
> 
>    For this, native side needs some work, please refer to this link
>    
>     [For iOS link](https://github.com/geappliances/mobile.connected.smarthq.ios/blob/develop/README.md#showing-the-entire-screen-with-flutter)
>     
>     [For Android link](https://github.com/geappliances/mobile.connected.smarthq.android/blob/develop/Cafe/SmartHQFlutterFragment.md#how-to-use-flutter-screen-as-appliance-fragment-in-native-code)
  
> 2. show the flutter screen in Development Tool (Android Studio)
> 
>    You can set the routingType in BuildEnvironment.initialize().
>    
>    The Flutter project is able to run itself on Android Studio.
>    
>    The Flutter project will show the screen when starting the app according to the routingType information.
```dart
void main() async {
  geaLog.debug("main() - started");

  WidgetsFlutterBinding.ensureInitialized();
  final channelManager = ChannelManager();

  DeviceEnvironment();
  BuildEnvironment.initialize(
      channelManager: channelManager,
      buildType: BuildType.field,
      routingType: RoutingType.commissioning,   /// HERE!!!
      restApiDataType: CommunicationDataType.cloud);
```


- ### Navigation by Flutter
Basically, the app uses named routing.
So, you need to register the name in advance as shown below.
And you can connect a screen to the name, or you can connect a Navigator.

<img width="641" alt="image" src="https://user-images.githubusercontent.com/32116640/200489387-ca03eab0-adc5-4550-b389-3c2687d2136b.png">

Until now, related screens were managed by grouping them into a single Navigator. 
However, this way causes a lot of unexpected problems, so we plan to improve the app to use only one Navigator in the future.

Please note that use CommonNavigatePage() as initialRoute when creating a Navigator.

<img width="679" alt="image" src="https://user-images.githubusercontent.com/32116640/200492895-e5bc2262-3474-4b84-8e3d-8e1f3fbcf8d7.png">

So, when moving between Navigators, set rootNavigator to true, and set the screen name to move registered in Navigator to subRouteName as below.

```dart
    globals.subRouteName = Routes.WASHER_FRONT_LOAD_GETTING_STARTED_HAIER;
    Navigator.of(context, rootNavigator: true).pushNamed(Routes.WASHER_MAIN_NAVIGATOR);
```
When moving between screens with the same navigator, you do not need to set subRouteName and rootNavigator as shown below.

```dart
    Navigator.of(context).pushNamed(Routes.WASHER_TOP_LOAD);
```

- ### Navigation by Native
The app loads and uses a single Flutter Engine.
Originally, the app has to create an engine for each Flutter View and load the screen.

However, we don't plan to create any additional engines because we plan to migrate our entire app to Flutter.

To route multiple screens with one engine, the following tasks are required.

First, you must set the context in build() function when you make the screen in Flutter as below.
There is a way to access the Context by registering the Global NavigationKey, but it was confirmed that there is a problem with routing in the environment of the app using multiple navigators. Therefore, refactoring to use one Navigator must be done first.
Until then, you have to maintain the cumbersome task of directly registering own context for each screen.

```dart
class NotificationSettingPage extends StatefulWidget {
  NotificationSettingPage({Key? key}) : super(key: key);

  @override
  _NotificationSettingPage createState() => _NotificationSettingPage();
}

class _NotificationSettingPage extends State<NotificationSettingPage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, (){
      BlocProvider.of<NotificationSettingCubit>(context).getNotificationInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;  /// HERE!!!
    
...
```

Second, add the routing type to move in Flutter. (in RoutingModel)
```dart
enum RoutingType {
  initial('/'),
  commissioning('commissioning'),
  commissioningFromDashboard('commissioningFromDashboard'),
  pairSensor('pairSensor'),
  standMixer('standMixer'),
  wifiLockerNetworkList('wifiLockerNetworkList'),
  notificationSettingPage('notificationSettingPage');
  ...
}
```

Third, add the navigating code into _doRouteScreen() function in MainRouter.
Please note that in the case of RoutingType.commissioning, the entire screen is rendered with Flutter. 
In this case, it is better to use the registered named navigating.

However, don't use named navigating for screens like RoutingType.notificationSettingPage that are partially rendered with Flutter.
Return the screen directly using NoAnimationMaterialPageRoute.

Because Flutter View is only partially visible on the screen of Native (Fragment or ViewController), if named navigating is used, the animation that occurs during screen transition proceeds simultaneously in Native and Flutter.
So it gets very weird. Be sure to note this.
```dart
void _doRouteScreen() {

    ...
    /// Routing Code from here.
    final nativeStorage = RepositoryProvider.of<NativeStorage>(context);
    final routingType = nativeStorage.routingType;
    switch (routingType) {
      case RoutingType.commissioning:
      case RoutingType.commissioningFromDashboard:
        Navigator.of(context).pushNamed(Routes.ADD_APPLIANCE_PAGE);
        break;
      case RoutingType.pairSensor:
        var cubit = BlocProvider.of<BleCommissioningCubit>(context);
        cubit.actionDirectBleGetInfoToPairSensor();
        break;
      case RoutingType.notificationSettingPage:
        Navigator.push(context, NoAnimationMaterialPageRoute(builder: (context) => NotificationSettingPage()));
        break;
      case RoutingType.standMixer:
        globals.subRouteName = Routes.STAND_MIXER_CONTROL_PAGE;
        Navigator.of(context, rootNavigator: true).pushNamed(Routes.STAND_MIXER_CONTROL_MAIN_NAVIGATOR);
        break;
      case RoutingType.wifiLockerNetworkList:
        globals.subRouteName = Routes.COMMON_SAVED_NETWORK_LIST;
        Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
        break;
      default:
        break;
    }
    ...      
}
```

Recently, the Channel method used for navigation in Native has been improved. 
Now, the Parameters can also be transmitted together when moving the screen.
For this, the RouingParameter class was added as below.


RoutingParameter consists of RoutingParameterKind and RoutingParameterBody.
If there is parameter to be delivered, create new RoutingParameterKind and define the corresponding RoutingParameterBodyXXXX.
RoutingParameterBodyXXXX must inherit from RoutingParameterBody.


And RoutingParameterBodyXXXX must implement toJson() and fromJson() functions corresponding to its Field value.

In addition, the fromJson() function of the RoutingParameterBodyXXXX corresponding to the kind must be called in the fromJson() function of the RoutingParameter class.

```dart
class RoutingParameter {
  RoutingParameterKind? kind;
  RoutingParameterBody? body;
  RoutingParameter({this.kind, this.body});
  
  ...
  
  RoutingParameter.fromJson(Map<String, dynamic> json) {
    final kindName = json['kind'];
    if (kindName != null) {
      kind = RoutingParameterKind.getKindFrom(name: kindName);
    } else {
      kind = RoutingParameterKind.none;
    }

    switch (kind) {
      case RoutingParameterKind.none:
        body = null;
        break;
      case RoutingParameterKind.sample:
        if (json['body'] != null) {
          Map<String, dynamic> _body = {...json['body']};
          body = RoutingParameterBodySample.fromJson(_body);
        }
        break;
        // HERE!!! Must add the code that calls RoutingParameterBodyXXXX.fromJson(_body)
    }
  }
}

---

enum RoutingParameterKind {
  none('none'),
  sample('sample');
  // HERE!!!  Please add new kind as needed.

  const RoutingParameterKind(this.name);
  final String name;

  factory RoutingParameterKind.getKindFrom({required String name}) {
    return RoutingParameterKind.values.firstWhere((value) => value.name == name,
        orElse: () => RoutingParameterKind.none);
  }
}

---

abstract class RoutingParameterBody {
  const RoutingParameterBody();
  Map<String, dynamic> toJson();
}

class RoutingParameterBodySample implements RoutingParameterBody {
  String? sample;
  RoutingParameterBodySample({this.sample});

  RoutingParameterBodySample.fromJson(Map<String, dynamic> json) {
    // HERE!!! Please implement the fromJson() function according to the field value.
    
    sample = json['sample'];
  }

  @override
  Map<String, dynamic> toJson() {
    // HERE!!! Please implement the toJson() function according to the field value.
    
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sample'] = this.sample;
    return data;
  }
}
```

In this regard, the improved channel method is as follows.

```dart

  /// Called for navigating from Flutter View to Flutter View is required.
  /// key - 'routingName'       * screen(configured with Flutter View) name to move.
  /// value - String
  /// key - 'routingParameter'  * Parameter in the form of Map<String:dynamic> to be delivered when moving the screen.
  /// value - RoutingParameter  * RoutingParameter consists of RoutingParameterKind and RoutingParameterBody.
  ///                             If there is parameter to be delivered, create new RoutingParameterKind and
  ///                             define the corresponding RoutingParameterBodyXXXX.
  ///                             RoutingParameterBodyXXXX must inherit from RoutingParameterBody.
  /// {
  ///   "routingName":"centralControllerScreen",
  ///   "routingParameter": RoutingParameter
  /// }
  static const F2N_DIRECT_MOVE_TO_FLUTTER_VIEW_SCREEN = "f2n_direct_move_to_flutter_view_screen";


  /// Called for routing the flutter screen.
  /// This function must be called before using the view controller or the fragment in the native.
  /// key - 'routingName'       * screen(configured with Flutter View) name to move.
  /// value - String
  /// key - 'routingParameter'  * Parameter in the form of Map<String:dynamic> to be delivered when moving the screen.
  /// value - RoutingParameter  * RoutingParameter consists of RoutingParameterKind and RoutingParameterBody.
  ///                             If there is parameter to be delivered, create new RoutingParameterKind and
  ///                             define the corresponding RoutingParameterBodyXXXX.
  ///                             RoutingParameterBodyXXXX must inherit from RoutingParameterBody.
  /// {
  ///   "routingName":"centralControllerScreen",
  ///   "routingParameter": RoutingParameter
  /// }
  static const N2F_DIRECT_ROUTE_TO_SCREEN = "n2f_direct_route_to_screen";
```

As shown below, if you call moveToFlutterViewScreen() of NativeRepository in Flutter, you can receive RoutingType and Parameters to move through Native.
```dart
  _nativeRepository.moveToFlutterViewScreen(
        routingType: RoutingType.notificationSettingPage,
        routingParameter: RoutingParameter(
            kind: RoutingParameterKind.sample,
            body: RoutingParameterBodySample(sample: "test")));
```

- ### Please note that the following (Native's Navigation or Flutter's Navigation)

When routing using the Navigation Bar of Native (Android or iOS), 
you must create a Native Screen (Fragment, ViewController) for each screen and use Flutter View within the Native Screen.

You should not create only one Native Screen and route it in Flutter.

The entire screen is the Flutter screen, and when routing using Flutter's Navigation Bar, 
you can route in Flutter itself.

Depending on whose Navigation Bar you're using, you'll need to configure it differently.


## How to use the WebSocket Resource
All of Appliances must use the WebSocket Connection to update their status.
For this, GEA Cloud provides the appliance status info in the following two types.

- V1 Type using the ERD value based
- V2 Type using the SmartHQ Data Model based

Basically, when you enable the "EnvFeatureType.applianceService" below and start a project, the app will automatically connect WebSocket and support both V1 and V2 types on Flutter. 

```dart
import 'package:smarthq_flutter_module/environment/build_environment.dart';

abstract class EnvDev {
  static const features = [
    EnvFeatureType.none,
    EnvFeatureType.gateway,
    EnvFeatureType.grindBrew,
    EnvFeatureType.applianceService, /// Must enabled this.
    EnvFeatureType.toasterOven
  ];
}
```


You can get the appliance status if you register an observer suitable for the type used by the appliance to be developed.
All websocket services are provided through the ApplianceServiceRepository.
Therefore, you must implement an Observer and register it in the ApplianceServiceRepository so that the appliance state is delivered to the Observer.

### V1 Type (ERD Value based)

```dart
abstract class ApplianceServiceObserver {
  void onReceivedCache(String jid, List<Map<String, String>> cache);
  void onReceivedPostErdResult(String jid, String erdNumber, String erdValue, String status);
  void onChangeStatus(ApplianceServiceStatus status);
  void onReceivedErd(String jid, String erdNumber, String erdValue);
}
```

```dart
/// Implementation
class ObserverForV1 implements ApplianceServiceObserver {
  @override
  void onChangeStatus(ApplianceServiceStatus status) {
    // TODO: implement onChangeStatus
  }

  @override
  void onReceivedCache(String jid, List<Map<String, String>> cache) {
    // TODO: implement onReceivedCache
  }

  @override
  void onReceivedErd(String jid, String erdNumber, String erdValue) {
    // TODO: implement onReceivedErd
  }

  @override
  void onReceivedPostErdResult(String jid, String erdNumber, String erdValue, String status) {
    // TODO: implement onReceivedPostErdResult
  }
}

/// Register Observer via ApplianceServiceRepository
final observer = ObserverForV1();

void register() {
  applianceServiceRepository.addObserver(observer);
}

void unregister() {
  applianceServiceRepository.removeObserver(observer);
}
```

### V2 Type (SmartHQ Data Model based)
```dart
abstract class ApplianceServiceDataModelObserver {
  void pubSubDevice(WebSocketPubSubDeviceResponse response);
  void pubSubService(WebSocketPubSubServiceResponse response);
  void pubSubPresence(WebSocketPubSubPresenceResponse response);
  void pubSubCommand();
}
```

```dart
/// Implementation
class ObserverForV2 implements ApplianceServiceDataModelObserver {
  @override
  void pubSubCommand() {
    // TODO: implement pubSubCommand
  }

  @override
  void pubSubDevice(WebSocketPubSubDeviceResponse response) {
    // TODO: implement pubSubDevice
  }

  @override
  void pubSubPresence(WebSocketPubSubPresenceResponse response) {
    // TODO: implement pubSubPresence
  }

  @override
  void pubSubService(WebSocketPubSubServiceResponse response) {
    // TODO: implement pubSubService
  }

}

/// Register Observer via ApplianceServiceRepository
final observer = ObserverForV2();

void register() {
  applianceServiceRepository.addDataModelObserver(observer);
}

void unregister() {
  applianceServiceRepository.removeDataModelObserver(observer);
}
```

Device-related information can be received as WebSocketPubSubDeviceResponse, Service-related information as WebSocketPubSubServiceResponse, and Presence-related information as WebSocketPubSubPresenceResponse model.

The above three responses have State, Services, and Config models in common.
For newly supported appliances, fields required for this State, Services, and Config model may not be included. In this case, refer to the "receivedMessage" parameter in the WebSocketProvider class as shown below, and add the necessary fields to the State, Services, and Config models.
At this time, do not modify or delete the existing Field. State, Services, and Config models are commonly used in other places, so unexpected issues may occur. Please only add the Field.
```dart
/// in web_socket_provider.dart file

void _handlePubSubService(Map<String, dynamic> receivedMessage, StreamController broadCast) {
  geaLog.debug("${tag}_handlePubSubService");
  
  /// You can find the field you need from "receivedMessage" parameter
  
  final response = WebSocketPubSubServiceResponse.fromJson(receivedMessage);
  broadCast.add(WebSocketStateItem(
      type: WebSocketStateType.webSocketReceivedPubSubService,
      dataItem: WebSocketDataPubSubItem(service: response)
  ));
}
```

```dart
/// Add required fields to State according to the appliance.
class State {
  bool? on;
  bool? disabled;
  int? secondsRemaining;
  String? upgradeStatus;
  String? versionCurrent;
  String? mode;
  double? coolCelsiusConverted;
  double? heatCelsiusConverted;
  double? celsiusConverted;
  String? fanSpeed;
  int? coolFahrenheit;
  int? heatFahrenheit;
  int? fahrenheit;
  int? value;
  ...
}

/// Add required fields to Service according to the appliance.
class Services {
  String? serviceType;
  String? lastSyncTime;
  String? domainType;
  String? serviceDeviceType;
  State? state;
  String? serviceId;
  Config? config;
  List<String>? supportedCommands;
  String? lastStateTime;
  ...
}

/// Add required fields to Config according to the appliance.
class Config {
  int? fahrenheitMinimum;
  int? fahrenheitMaximum;
  String? model;
  int? temperatureBufferFahrenheitMinimum;
  List<String>? supportedFanSpeeds;
  List<String>? supportedModes;
  String? integerUnits;
  int? maximum;
  int? minimum;
  bool? ordered;
  int? heatFahrenheitMaximum;
  int? coolFahrenheitMaximum;
  int? heatFahrenheitMinimum;
  int? coolFahrenheitMinimum;
  ...
}
```


## Run with Mock Up in Flutter
You can test in the Flutter Module itself through MockUp data without Native as shown below.
```dart
class ChannelMethodMockUp {
    ...
Future<dynamic> getMockUp(ChannelType channelType, String methodName, dynamic parameter) {
    geaLog.debug("Finding... the method in ChannelMethodMockUp");
    Future<dynamic>? mockUp;

    switch (channelType) {
      case ChannelType.NATIVE:
        if (methodName == NativeChannelProfile.F2N_DIRECT_IS_SIMULATOR) {
          mockUp = Future.value(true);
        }
        else if (methodName == NativeChannelProfile.F2N_DIRECT_GET_LANGUAGE_PREFERENCE) {
          mockUp = Future.value({'languagePreference':'en'});
        }
        else if (methodName == NativeChannelProfile.F2N_DIRECT_GET_MDT) {
          // mockUp = Future.value({'mdt':'ue1dv74dKTYymiz7vdkDcj3n5QBbd3vKotMo'});
          mockUp = Future.value({'mdt':'ue1dd6kc3R8vAKwTfQ2G3mU4gFTj1W4uI1gv'});
        }
        else if (methodName == NativeChannelProfile.F2N_DIRECT_GET_GE_TOKEN) {
          mockUp = Future.value({'geToken':'ue1cf5guavcwiedt6fi4hwsbzdwn02bb'});
        }
        // else if (methodName == NativeChannelProfile.F2N_DIRECT_GET_FEATURE_LIST) {
        //   mockUp = Future.value({'features':['websocket', 'restApi']});
        // }
        break;

      case ChannelType.BLE_COMMISSIONING:
        if (methodName == BleCommissioningChannelProfile.ACTION_DIRECT_BLE_GET_INFO_TO_PAIR_SENSOR) {
          mockUp = Future.value({'deviceId':'27f766b1b1f228be0ccb0cd9fc264494f88ae6bc7b8506d9d0005b9f0a4d9f5b',
                                'gatewayId':'280f51f3280be26f297af81465e135fa2702e54da5192a7398e0d336a3891aab'});
        }
        else if (methodName == BleCommissioningChannelProfile.ACTION_DIRECT_BLE_DEVICE_STATE) {
          mockUp = Future.value({'state':'on'});
        }
        break;

      case ChannelType.COMMISSIONING:
        if (methodName == CommissioningChannelProfile.ACTION_DIRECT_REQUEST_SELECTED_BRAND_TYPE) {
          mockUp = Future.value({'brandType':'cafe'});
        }
        if (methodName == CommissioningChannelProfile.ACTION_DIRECT_REQUEST_USER_COUNTRY_CODE) {
          mockUp = Future.value({'countryCode':'en'});
        }
        break;
    }
}
```
## Use TestManager to set the environment like as Native
You can use TestManager class in the Flutter Module itself in order to create an environment similar to Native.
```dart
void main() async {
  geaLog.debug("main() - started");
  WidgetsFlutterBinding.ensureInitialized();
  
  ...
  
  await TestManager().load();

  BlocOverrides.runZoned(
        () => runApp(MyApp()),
    blocObserver: GlobalCubitObserver(),
  );
}

class TestManager implements ApplianceServiceObserver {

  ...

  Future<void> load() async {
    /// You can check that the app is running on Simulator through "ChannelManager().isSimulator()"
    final isSimulator = await ChannelManager().isSimulator();
    if (isSimulator) {
      final applianceServiceRepository = GetIt.I.get<ApplianceServiceRepository>();
      await applianceServiceRepository.startService();
      // applianceServiceRepository.addObserver(this);
    }
  }
  ...
```

## Repositories (This is outdated information. It is being updated.)

### ApplianceServiceRepository
You can read and write the Erd value by Flutter Module itself without Native. Use this repository.
ApplianceServiceRepository can connect to Websocket to read and write ERD information when the "n2f_direct_start_service" channel method in Native Channel is called from Native to Flutter Module.

- Flutter side
```dart
abstract class NativeChannelProfile {
  ...
  static const N2F_DIRECT_START_SERVICE = "n2f_direct_start_service";
  ...
}
```

- iOS side
```swift
struct NativeChannelProfile {
    static let channelName = "com.ge.smarthq.flutter.native"
    struct Methods {
        struct Action {
            static let directStartService = "n2f_direct_start_service" // services: List<String>
        }
    }
    ...
}

@objc func startModuleService() {
    GEALog(.debug, GEA_THIS_METHOD())

    actionRequest(channelType: .native,
                  method: NativeChannelProfile.Methods.Action.directStartService,
                  arguments: ["services":["applianceService"]])
}
```

As above, if the "n2f_direct_start_service" channel function is called in Native, the startService() function of ApplianceServiceRepository is execut.


the blow is an interface of ApplianceServiceRepository.

If you implement ApplianceServiceObserver and register it through the addObserver() function, 
you can obtain the results of postErd() and requestCache(). Not only that, you can also know the status change through the onChangeStatus(). 
It can also be called directly with the getStatus() function.

The app can communicate with the server only when ApplianceServiceStatus becomes inService state after the startService() function is called. 
Note that the ApplianceServiceStatus should be checked.

All erd values are stored in memory. It can be obtained directly through the getErdValue(...) and getCache(...) functions.


```dart
abstract class ApplianceServiceRepository {
  /// add the observer to listen the information
  void addObserver(ApplianceServiceObserver observer);
  /// remove the observer
  void removeObserver(ApplianceServiceObserver observer);

  /// return the status of the appliance service repository.
  ApplianceServiceStatus getStatus();

  /// start the appliance service repository.
  /// When Status is "inService", it is possible to use.
  /// "Status" can be checked through getStatus() or onChangeStatus().
  Future<bool> startService();

  /// stop the appliance service repository.
  void stopService();

  /// request to the server to edit the erd value.
  /// Response: onReceivedPostErdResult()
  void postErd(String jid, String erdNumber, String erdValue);

  /// request to the server to get the all erd values.
  /// Response: onReceivedCache()
  void requestCache(String jid);

  /// return the erd value from memory.
  String? getErdValue(String jid, String erdNumber);

  /// return the all erd values from memory.
  List<Map<String, String>?>? getCache(String jid);
}

abstract class ApplianceServiceObserver {
  void onReceivedCache(String jid, List<Map<String, String>> cache);
  void onReceivedPostErdResult(String jid, String erdNumber, String erdValue, String status);
  void onChangeStatus(ApplianceServiceStatus status);
}
```
