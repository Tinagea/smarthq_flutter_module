import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class CommissioningChooseHomeNetworkList extends StatefulWidget {
  @override
  _CommissioningChooseHomeNetworkList createState() => _CommissioningChooseHomeNetworkList();
}

class _CommissioningChooseHomeNetworkList extends State<CommissioningChooseHomeNetworkList> with WidgetsBindingObserver {

  late LoadingDialog _loadingDialog;

  bool _isWifiLockerSupported = false;

  @override
  Widget build(BuildContext context) {
    final storage = RepositoryProvider.of<BleCommissioningStorage>(context);

    return FocusDetector(
    onFocusGained: () {

      _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.SEARCH_FOR_AVAILABLE_WIFI_NETWORK));
      if (storage.savedStartByBleCommissioning == true) {
        BlocProvider.of<BleCommissioningCubit>(context).actionCheckShouldScan();
        BlocProvider.of<BleCommissioningCubit>(context).initBleCommissioningNetworkListState();
        BlocProvider.of<BleCommissioningCubit>(context).actionBleRequestNetworkList();
      } else {
        BlocProvider.of<CommissioningCubit>(context).initCommissioningNetworkListState();
        BlocProvider.of<CommissioningCubit>(context).actionRequestNetworkList();
      }
    },
    child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.CHOOSE_HOME_NETWORK)!.toUpperCase(),
              leftBtnFunction: () {
                if (storage.savedStartByBleCommissioning == true) {
                  BlocProvider.of<BleCommissioningCubit>(context).initBleCommissioningNetworkListState();
                  Navigator.of(context, rootNavigator: true).pop();
                } else {
                  BlocProvider.of<CommissioningCubit>(context).initCommissioningNetworkListState();
                  if (BlocProvider.of<CommissioningCubit>(context).isAutoJoin() != null && BlocProvider.of<CommissioningCubit>(context).isAutoJoin()!) {
                    BlocProvider.of<CommissioningCubit>(context).setAutoJoinToFalse();
                    Navigator.of(context, rootNavigator: true).pop();
                  } else {
                    if (globals.routeNameToBack == Routes.RANGE_REMOTE_ENABLE_DESCRIPTION ||
                        globals.routeNameToBack == Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_1 ||
                        globals.routeNameToBack == Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_ONE) {
                      Navigator.of(context, rootNavigator: true).pop();
                    } else {
                      BlocProvider.of<CommissioningCubit>(context).initCommissioningNetworkListState();
                      Navigator.popUntil(context, (route) =>
                      route.settings.name == Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE);
                    }
                  }
                }
              },
              rightImagePath: ImagePath.NAVIGATE_RELOAD_ICON,
              rightBtnFunction: () {
                geaLog.debug('CommissioningChooseHomeNetworkList.requestNetworks');
                var bleCubit = BlocProvider.of<BleCommissioningCubit>(context);
                if (storage.savedStartByBleCommissioning == true) {
                  bleCubit.initBleCommissioningNetworkListState();
                  bleCubit.actionBleRequestNetworkList();
                }
                else {
                  BlocProvider.of<CommissioningCubit>(context).initCommissioningNetworkListState();
                  BlocProvider.of<CommissioningCubit>(context).actionRequestNetworkList();
                }

                _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.SEARCH_FOR_AVAILABLE_WIFI_NETWORK));
              }
          ).setNavigationAppBar(context: context),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BaseComponent.heightSpace(13.h),
                Visibility(visible: (_isWifiLockerSupported) ? true : false,
                    child: getSavedNetworkBody(storage)),
                getBody(storage),
                BaseComponent.heightSpace(5.h),
                Padding(
                  padding: EdgeInsets.fromLTRB(19.w, 0, 19.w, 30.h),
                  child: Component.componentQuestionText(
                      context: context,
                      onTap: () {
                        DialogManager().showCouldNotFindHomeNetworkDialog(context: context);
                      },
                      text: LocaleUtil.getString(
                          context, LocaleUtil.COULD_NOT_FIND_HOME_NETWORK)!),
                ),
                BlocListener<BleCommissioningCubit, BleCommissioningState>(
                  listenWhen: (previous, current){
                    return (current.stateType == BleCommissioningStateType.WIFI_LOCKER_NETWORKS
                        && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                  },
                  listener: (context, state) {
                    if (_isWifiLockerSupported) {
                      BlocProvider.of<BleCommissioningCubit>(context).actionFetchSavedWifiNetworks();
                    }
                  },
                  child: Container(),
                )
                // BaseComponent.heightSpace(15.h)
              ],
            ),
          ),
        )
      )
    );
  }

  Widget getSavedNetworkBody(BleCommissioningStorage storage) {
    return BlocConsumer<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current){
          return (current.stateType == BleCommissioningStateType.SAVED_WIFI_LOCKER_NETWORKS
          && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
        },
        listener: (context, state){
          if ((state.savedWifiNetworks?.networks != null) &&
              (state.savedWifiNetworks?.networks?.length ?? 0) > 0 &&
              storage.isFromSavedConnection == false) {
            geaLog.debug("getSavedNetworkBody: App has saved network and can connect automatically");
            BlocProvider.of<BleCommissioningCubit>(context).actionSetFromSavedConnectionFlag(false);

            var bleCubit = BlocProvider.of<BleCommissioningCubit>(context);
            if (storage.savedStartByBleCommissioning == true) {

              final validSavedNetwork = bleCubit.getValidSavedNetwork(state.savedWifiNetworks?.networks);
              if (validSavedNetwork == null) {
                geaLog.debug("The saved network is not in range. The network might be saved from other region");
              } else {
                var ssidName = validSavedNetwork.ssid;
                var securityType = validSavedNetwork.securityType;

                bleCubit.keepSsidNSecurityType(ssidName, securityType);
                bleCubit.actionBleSaveSelectedNetworkInformation(validSavedNetwork.password ?? "");
                bleCubit.actionBleSaveSelectedNetworkIndex();
                bleCubit.actionSetSelectedSavedNetworkSsid(ssidName);
                Future.delayed(Duration.zero, () async {
                  Navigator.of(context).pushNamed(Routes.COMMON_CONNECTING_SAVED_NETWORK);
                });
              }
            } else {
              final validSavedNetwork = BlocProvider.of<CommissioningCubit>(context).getValidSavedNetwork(state.savedWifiNetworks?.networks);
              if (validSavedNetwork == null) {
                geaLog.debug("no network around device, keep staying at this screen.");
              } else {

                BlocProvider.of<CommissioningCubit>(context).actionSaveSelectedNetworkInformation(validSavedNetwork.password ?? '');
                bleCubit.actionSetSelectedSavedNetworkSsid(validSavedNetwork.ssid);
                Future.delayed(Duration.zero, () async {
                  Navigator.of(context).pushNamed(Routes.COMMON_CONNECTING_SAVED_NETWORK);
                });

                bleCubit.actionSetAutoConnectionFlag(false);
              }
            }

            bleCubit.actionSetAutoConnectionFlag(false);
            _loadingDialog.close(context);
          }
        },
        buildWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.SAVED_WIFI_LOCKER_NETWORKS);
        },
        builder: (context, state) {
          return Visibility(
            visible: (state.savedWifiNetworks?.networks == null) ? false :
            ((state.savedWifiNetworks?.networks?.length ?? 0) > 0) ? true : false,
            child: Column(
              children: [
                BaseComponent.heightSpace(5.h),
                Component.componentListSectionTitle(LocaleUtil.getString(context, LocaleUtil.SAVED_NETWORKS)),
                BaseComponent.heightSpace(2.h),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: (state.savedWifiNetworks?.networks == null) ? 0 :
                    (state.savedWifiNetworks?.networks?.length ?? 0),
                    itemBuilder: (context, index) {
                      return new GestureDetector(
                        onTap: () {
                          if (storage.savedStartByBleCommissioning == true) {
                            if (state.savedWifiNetworks?.networks != null) {
                              var ssidName = state.savedWifiNetworks?.networks?[index].ssid;
                              var securityType = state.savedWifiNetworks?.networks?[index].securityType;

                              var bleCubit = BlocProvider.of<BleCommissioningCubit>(context);
                              final isSavedNetworkInRange = bleCubit.isIndexFromSavedNetworksExisted(ssidName);
                              if(isSavedNetworkInRange) {
                                bleCubit.keepSsidNSecurityType(ssidName, securityType);
                                bleCubit.actionBleSaveSelectedNetworkInformation(state.savedWifiNetworks?.networks?[index].password ?? "");
                                bleCubit.actionBleSaveSelectedNetworkIndex();

                                Navigator.of(context).pushNamed(Routes.COMMON_COMMUNICATION_CLOUD_PAGE);
                              } else {
                                DialogManager().showNetworkIsNotInRange(context);
                              }
                            } else {
                              DialogManager().showNoBleNetworksDialog(context: context, onRetryPressed: () {
                                var bleCubit = BlocProvider.of<BleCommissioningCubit>(context);
                                bleCubit.initBleCommissioningNetworkListState();
                                bleCubit.actionBleRequestNetworkList();

                                _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.SEARCH_FOR_AVAILABLE_WIFI_NETWORK));
                              });
                            }
                          } else {
                            var ssidName = state.savedWifiNetworks?.networks?[index].ssid;

                            var cubit = BlocProvider.of<CommissioningCubit>(context);
                            final isSavedNetworkInRange = cubit.isSavedNetworksExistedInList(ssidName);
                            if (isSavedNetworkInRange) {
                              cubit.actionSaveSelectedNetworkInformation(state.savedWifiNetworks?.networks?[index].password ?? "");

                              Navigator.of(context).pushNamed(Routes.COMMON_COMMUNICATION_CLOUD_PAGE);
                            } else {
                              DialogManager().showNetworkIsNotInRange(context);
                            }
                          }
                        },
                        child: Column(
                          children: [
                            CustomRichText.customSpanListTextBoxWithDetail(context: context,
                                title: state.savedWifiNetworks?.networks?[index].ssid,
                                detail: LocaleUtil.getString(context, LocaleUtil.EDIT),
                                onTapPencil: (){
                                    BlocProvider.of<BleCommissioningCubit>(context).actionStoreNetworkForEditing(state.savedWifiNetworks?.networks?[index]);
                                    Navigator.of(context).pushNamed(Routes.COMMON_EDIT_SAVED_NETWORK_PAGE);
                                }),
                            BaseComponent.heightSpace(16.h)
                          ],
                        ),
                      );
                    }),
                BaseComponent.heightSpace(5.h),
                Component.componentListSectionTitle(LocaleUtil.getString(context, LocaleUtil.NETWORKS)),
                BaseComponent.heightSpace(2.h),
              ],
            ),
          );
        });
  }

  Widget getBody(BleCommissioningStorage storage) {
    if (storage.savedStartByBleCommissioning == true) {
      return getBleCommissioningBody(storage);
    }
    else {
      return getApCommissioningBody(storage);
    }
  }

  Widget getApCommissioningBody(BleCommissioningStorage storage) {
    return BlocConsumer<CommissioningCubit, CommissioningState> (
        listenWhen: (previous, current) {
          return (current.stateType == CommissioningStateType.NETWORK_LIST);
        },
        listener: (context, state) {
          _loadingDialog.close(context);// save module network to compare.
          BlocProvider.of<CommissioningCubit>(context).actionSetModuleNetworks(state.networkListFromWifiModule);
          if (_isWifiLockerSupported) {
            BlocProvider.of<BleCommissioningCubit>(context).actionFetchSavedWifiNetworks();
          }
        },
        buildWhen: (previous, current) {
          return (current.stateType == CommissioningStateType.NETWORK_LIST) ||
              (current.stateType == CommissioningStateType.NETWORK_LIST_INITIAL);
        },
        builder: (context, state) {
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: getItemListCount(state.networkListFromWifiModule),
              itemBuilder: (context, index) {
                return new GestureDetector(
                  onTap: () {
                    if (isOtherNetworkItem(index, getItemListCount(state.networkListFromWifiModule))) {
                      Navigator.of(context).pushNamed(Routes.COMMON_ADD_OTHER_NETWORK_PAGE);
                    }
                    else {
                      if (state.networkListFromWifiModule != null && state.networkListFromWifiModule!.length > index) {
                        var ssidName = state.networkListFromWifiModule![index]['ssid'];
                        var securityType = state.networkListFromWifiModule![index]['securityType'];

                        BlocProvider.of<CommissioningCubit>(context).keepSsidNSecurityType(ssidName, securityType);

                        if (CommissioningUtil.isNotSecurityType(securityType, false) && securityType != null && ssidName != null) {
                          showSecurityWarningPopup(context, securityType, ssidName, false);
                        }
                        else {
                          Navigator.of(context).pushNamed(Routes.COMMON_CHOOSE_HOME_NETWORK_PAGE, arguments: ssidName);
                        }
                      }
                    }
                  },
                  child: Column(
                    children: [
                      CustomRichText.customSpanListTextBox(
                        textSpanList: <TextSpan>[
                          TextSpan(
                              text: (isOtherNetworkItem(index, getItemListCount(state.networkListFromWifiModule))) ? LocaleUtil.getString(context, LocaleUtil.OTHER_NETWORK) : state.networkListFromWifiModule?[index]['ssid'],
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0.36))
                        ],
                      ),
                      BaseComponent.heightSpace(16.h)
                    ],
                  ),
                );
              });
        }
    );
  }

  Widget getBleCommissioningBody(BleCommissioningStorage storage) {
    return Column(
        children: <Widget>[
          BlocListener<BleCommissioningCubit, BleCommissioningState>(
            listenWhen: (previous, current) {
              return (current.stateType == BleCommissioningStateType.NETWORK_STATUS_DISCONNECT
                  && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
            },
            listener: (context, state) {
              _loadingDialog.close(context);
              _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.RETRYING_TO_CONNECT_YOUR_APPLIANCE));

              var bleCubit = BlocProvider.of<BleCommissioningCubit>(context);
              bleCubit.initBleCommissioningNetworkListState();
              bleCubit.actionRetryPairing();
            },
            child: Container(),
          ),
          BlocListener<BleCommissioningCubit, BleCommissioningState>(
            listenWhen: (previous, current) {
              return (current.stateType == BleCommissioningStateType.RETRY_PAIRING_RESULT
                  && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
            },
            listener: (context, state) {
              _loadingDialog.close(context);

              if (state.isSuccess == true) {
                geaLog.debug("_CommissioningChooseHomeNetworkList network request from retry pairing");
                var bleCubit = BlocProvider.of<BleCommissioningCubit>(context);
                bleCubit.initBleCommissioningNetworkListState();
                bleCubit.actionBleRequestNetworkList();
                _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.SEARCH_FOR_AVAILABLE_WIFI_NETWORK));
              }
              else {
                DialogManager().showBleDisconnectedDialog(context: context, onYesPressed: () {
                  if (storage.savedStartByBleCommissioning == true) {
                    Navigator.of(context, rootNavigator: true).pop();
                  }
                });
              }
            },
            child: Container(),
          ),
          BlocListener<BleCommissioningCubit, BleCommissioningState>(
            listenWhen: (previous, current) {
              return (current.stateType == BleCommissioningStateType.SCAN_NETWORK_LIST
                  && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
            },
            listener: (context, state) {
              _loadingDialog.close(context);
              _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.SEARCH_FOR_AVAILABLE_WIFI_NETWORK));
              var bleCubit = BlocProvider.of<BleCommissioningCubit>(context);
              bleCubit.initBleCommissioningNetworkListState();
              geaLog.debug("_CommissioningChooseHomeNetworkList network request from scan network list");
              bleCubit.actionBleRequestNetworkList();
            },
            child: Container(),
          ),
          BlocConsumer<BleCommissioningCubit, BleCommissioningState> (
              listenWhen: (previous, current) {
                return (current.stateType == BleCommissioningStateType.NETWORK_LIST);
              },
              listener: (context, state) {
                _loadingDialog.close(context);
                BlocProvider.of<BleCommissioningCubit>(context).actionSetBleModuleNetworks(state.networkListFromWifiModule);

                if(_isWifiLockerSupported) {
                  BlocProvider.of<BleCommissioningCubit>(context).actionFetchSavedWifiNetworks();
                }
              },
              buildWhen: (previous, current) {
                return (current.stateType == BleCommissioningStateType.NETWORK_LIST) ||
                    (current.stateType == BleCommissioningStateType.NETWORK_LIST_INITIAL);
              },
              builder: (context, state) {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: getItemListCount(state.networkListFromWifiModule),
                    itemBuilder: (context, index) {
                      return new GestureDetector(
                        onTap: () {

                          if (isOtherNetworkItem(index, getItemListCount(state.networkListFromWifiModule))) {
                            Navigator.of(context).pushNamed(Routes.COMMON_ADD_OTHER_NETWORK_PAGE);
                          }
                          else {
                            if (state.networkListFromWifiModule != null && state.networkListFromWifiModule!.length > index) {
                              geaLog.debug("clicked network list from BLE network list");
                              var ssidName = state.networkListFromWifiModule![index]['ssid'];
                              var securityType = state.networkListFromWifiModule![index]['securityType'];
                              var encryptType = state.networkListFromWifiModule![index]['encryptType'];

                              BlocProvider.of<BleCommissioningCubit>(context).keepSsidNSecurityTypeNEncryptType(ssidName, securityType, encryptType);

                              BlocProvider.of<BleCommissioningCubit>(context).keepSelectedIndex(index);

                              if (CommissioningUtil.isNotSecurityType(securityType, true) && securityType != null && ssidName != null) {
                                showSecurityWarningPopup(context, securityType, ssidName, true);
                              } else {
                                Navigator.of(context).pushNamed(Routes.COMMON_CHOOSE_HOME_NETWORK_PAGE, arguments: ssidName);
                              }
                            }
                          }
                        },
                        child: Column(
                          children: [
                            CustomRichText.customSpanListTextBox(
                              textSpanList: <TextSpan>[
                                TextSpan(
                                    text: (isOtherNetworkItem(index, getItemListCount(state.networkListFromWifiModule))) ? LocaleUtil.getString(context, LocaleUtil.OTHER_NETWORK) : state.networkListFromWifiModule?[index]['ssid'],
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        letterSpacing: 0.36))
                              ],
                            ),
                            BaseComponent.heightSpace(16.h)
                          ],
                        ),
                      );
                    });
              }
          ),
        ]
    );
  }

  bool isOtherNetworkItem(int index, int networkListCount) {
    return (index == networkListCount - 1); // for Other Network
  }

  int getItemListCount(List? networklist) {
    int count = 1; // for Other Network
    if (networklist != null) {
      count += networklist.length;
    }

    return count;
  }

  void showSecurityWarningPopup(BuildContext context, String securityType, String ssidName, bool isBleCommissioning) {

    final storage = RepositoryProvider.of<BleCommissioningStorage>(context);
    APSecurityType eSecurityType = CommissioningUtil.getAPSecurityType(securityType, isBleCommissioning);
    switch (eSecurityType) {

      case APSecurityType.weakSecurity: {
        DialogManager().showWeakSecurityWarningDialog(
            context: context, onYesPressed: (){
              Navigator.of(context).pushNamed(Routes.COMMON_CHOOSE_HOME_NETWORK_PAGE, arguments: ssidName);
        });
      }
        break;

      case APSecurityType.openSecurity: {
        DialogManager().showOpenSecurityWarningDialog(
          context: context, onYesPressed: (){
            if (storage.savedStartByBleCommissioning == true) {
              var bleCubit = BlocProvider.of<BleCommissioningCubit>(context);
              bleCubit.actionBleSaveSelectedNetworkInformation('');
              bleCubit.actionBleSaveSelectedNetworkIndex();
            }
            else {
              BlocProvider.of<CommissioningCubit>(context).actionSaveSelectedNetworkInformation('');
            }

            Navigator.of(context).pushNamed(Routes.COMMON_COMMUNICATION_CLOUD_PAGE);
        });
      }
        break;

      case APSecurityType.unknownSecurity: {
        DialogManager().showUnknownSecurityWarningDialog(
            context: context, onYesPressed: (){
          Navigator.of(context).pushNamed(Routes.COMMON_CHOOSE_HOME_NETWORK_PAGE, arguments: ssidName);
        });
      }
        break;

      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _loadingDialog = LoadingDialog();

    Future.delayed(Duration.zero, () async {
      _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.SEARCH_FOR_AVAILABLE_WIFI_NETWORK));

      setState(() {
        BlocProvider.of<BleCommissioningCubit>(context).actionGetIsWifiLockerAvailable().then((value) {
          _isWifiLockerSupported = value;
        });
      });

      final storage = RepositoryProvider.of<BleCommissioningStorage>(context);
      if (storage.savedStartByBleCommissioning == true) {
        geaLog.debug("_CommissioningChooseHomeNetworkList network request from init");
        BlocProvider.of<BleCommissioningCubit>(context).actionBleRequestNetworkList();
      }
      else {
        BlocProvider.of<CommissioningCubit>(context).actionRequestNetworkList();
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _loadingDialog.close(context);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    geaLog.debug('CommissioningChooseHomeNetworkList.didChangeAppLifecycleState: $state');
    super.didChangeAppLifecycleState(state);

    if (!(ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent))
      return;

    geaLog.debug('AppLifecycleState: $state}');
    if (state == AppLifecycleState.paused) {
      // went to Background
    }
    if (state == AppLifecycleState.resumed) {
    }
  }
}
