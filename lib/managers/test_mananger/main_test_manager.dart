
import 'package:get_it/get_it.dart';
import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/managers/managers.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/channels/routing_parameter/routing_parameter.dart';
import 'package:smarthq_flutter_module/resources/channels/routing_parameter/routing_parameter_body.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_device_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_presence_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_service_response.dart';
import 'package:smarthq_flutter_module/resources/repositories/repositories.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class MainTestManager implements TestManager, ApplianceServiceObserver, ApplianceServiceDataModelObserver {
  static const tag = "MainTestManager:";

  MainTestManager._();
  static final MainTestManager _instance = MainTestManager._();
  factory MainTestManager() {
    return _instance;
  }

  late SharedDataManager _sharedDataManager;
  late NativeRepository _nativeRepository;

  @override
  Future<void> initialize() async {
    /// Get Resources for Main Test
    final applianceServiceRepository = GetIt.I.get<ApplianceServiceRepository>();
    _nativeRepository = GetIt.I.get<NativeRepository>();
    _sharedDataManager = GetIt.I.get<SharedDataManager>();


    if (BuildEnvironment.runEnvType == RunEnvType.standAlone) {
      await _getTokens(_nativeRepository);

      await applianceServiceRepository.startService();
      applianceServiceRepository.addObserver(this);
      applianceServiceRepository.addDataModelObserver(this);
    }

    return null;
  }

  @override
  void testAction({required int actionNumber}) async {
    switch (actionNumber) {
      case 0:
        final apiServiceRepository = GetIt.I.get<ApiServiceRepository>();
        final test = await apiServiceRepository.getNotificationSettingAPIVersion('6');
        geaLog.debug(test);
        break;
      case 1:
        final applianceServiceRepository = GetIt.I.get<ApplianceServiceRepository>();
        applianceServiceRepository.postErd("d828c905b5db_voqi433k5b2tqq6", "0x4020", "03");
        // applianceServiceRepository.requestCache("d828c905b5db_voqi433k5b2tqq6");
        // applianceServiceRepository.getCache("d828c905b5db_voqi433k5b2tqq6");
        // applianceServiceRepository.getErdValue("d828c905b5db_voqi433k5b2tqq6", "0x4020");
        break;
      case 2:
        _nativeRepository.moveToFlutterViewScreen(
            routingType: RoutingType.notificationSettingPage,
            routingParameter: RoutingParameter(
                kind: RoutingParameterKind.sample,
                body: RoutingParameterBodySample(sample: "test")
            ));
        break;
      default:

        break;
    }
  }

  @override
  void onChangeStatus(ApplianceServiceStatus status) {
    geaLog.debug("$tag-onChangeStatus:$status");
  }

  @override
  void onReceivedCache(String jid, List<Map<String, String>> cache, List<Map<String, String>> timestamps) {
    geaLog.debug("$tag-onReceivedCache:$cache");
  }

  @override
  void onReceivedPostErdResult(String jid, String erdNumber, String erdValue, String status) {
    geaLog.debug("$tag-onReceivedPostErdResult:$status");
  }

  @override
  void onReceivedErd(String jid, String erdNumber, String erdValue, String timestamp) {
    geaLog.debug("$tag-onReceivedErd:$jid,$erdNumber,$erdValue");
  }

  Future<void> _getTokens(NativeRepository nativeRepository) async {
    final mdt = await nativeRepository.getMdt();
    final geToken = await nativeRepository.getGeToken();
    geaLog.debug('NativeCubit:getTokens() - mdt:$mdt, geToken:$geToken');

    await _sharedDataManager.setStringValue(SharedDataKey.mobileDeviceToken, mdt);
    await _sharedDataManager.setStringValue(SharedDataKey.geToken, geToken);
  }

  @override
  void pubSubCommand() {
    geaLog.debug("$tag-pubSubCommand");
  }

  @override
  void pubSubDevice(WebSocketPubSubDeviceResponse response) {
    geaLog.debug("$tag-pubSubDevice:$response");
  }

  @override
  void pubSubPresence(WebSocketPubSubPresenceResponse response) {
    geaLog.debug("$tag-pubSubPresence:$response");
  }

  @override
  void pubSubService(WebSocketPubSubServiceResponse response) {
    geaLog.debug("$tag-pubSubService:$response");
  }
}