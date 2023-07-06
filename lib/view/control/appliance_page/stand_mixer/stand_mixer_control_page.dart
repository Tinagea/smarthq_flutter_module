import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/appliance_cubit.dart';
import 'package:smarthq_flutter_module/cubits/stand_mixer_cubits.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/control/stand_mixer_control_model.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/resources/erd/0x0099.dart';
import 'package:smarthq_flutter_module/resources/erd/erd.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';
import 'package:smarthq_flutter_module/services/erd_model.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/view/control//common_widget/custom_alert_popup.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/common_widget/reusable_collapsible_card.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/stand_mixer_expanded_content.dart';
import 'package:smarthq_flutter_module/view/recipes/image_card.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/view/recipes/navigator/recipe_navigator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StandMixerControlPage extends StatefulWidget {
  StandMixerControlPage({Key? key}) : super(key: key);
  @override
  State<StandMixerControlPage> createState() => _StandMixerControlPage();
}

class _StandMixerControlPage extends State<StandMixerControlPage> with WidgetsBindingObserver {
  static const String tag = "StandMixerControlPage";
  bool checkedForActiveRecipe = false;
  bool checked0x5300ForActiveRecipe = false;
  bool checkedCubitForActiveRecipe = false;
  LoadingDialog _loadingDialog = LoadingDialog();
  int activeRecipeFailedCount = 0;
  
  static String _youtubeURL = "https://www.youtube.com/playlist?list=PLX8_V2wHGuhk23H2t7D-yuf6I0PvDMOvL";
  
  Future<void> _checkForActiveRecipes(BuildContext context) async {
    if(BlocProvider.of<RecipeStepsCubit>(context).state is ControlStep == false && checked0x5300ForActiveRecipe != true){
      try {
        await BlocProvider.of<RecipeStepsCubit>(context).checkForActiveRecipes(context, ApplianceType.STAND_MIXER);
        checkedCubitForActiveRecipe = true;
        if(BlocProvider.of<RecipeStepsCubit>(context).state is ControlStep){
          bool isArthur = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).isArthur;
          Recipe recipe = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).recipe;
          geaLog.debug("Routing To Recipe using 0x5300 Data");
          Future.delayed(Duration.zero,() {
            globals.subRouteName = Routes.RECIPE_DICOVER_PAGE;
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.RECIPE_MAIN_NAVIGATOR, arguments:RecipeFilterArguments(domains: recipe.domains, isArthur: isArthur));
          });
        }
        checked0x5300ForActiveRecipe = true;
      } catch (e) {
        geaLog.error("Error in 0x5300: $e Trying again");
        Future.delayed(Duration(milliseconds: 750), () async {
          if(activeRecipeFailedCount < 3){
            _checkForActiveRecipes(context);
          } else {
            activeRecipeFailedCount = 0;
          }
          activeRecipeFailedCount++;
          return;
        });
      }
    } else {
      if(checkedCubitForActiveRecipe != true && BlocProvider.of<RecipeStepsCubit>(context).state is ControlStep){
        geaLog.debug("Routing To Recipe using Cubit Data");
        bool isArthur = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).isArthur;
        Recipe recipe = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).recipe;
        BlocProvider.of<RecipeStepsCubit>(context).setReturnedRouteFromState();
        checkedCubitForActiveRecipe = true;
        Future.delayed(Duration.zero,() {
          globals.subRouteName = Routes.RECIPE_DICOVER_PAGE;
          Navigator.of(context, rootNavigator: true).pushNamed(Routes.RECIPE_MAIN_NAVIGATOR, arguments:RecipeFilterArguments(domains: recipe.domains, isArthur: isArthur));
        });
      }
    }
  }


  void clearRecipeDataIfSwitchedFromAppliance(){
    if(BlocProvider.of<RecipeStepsCubit>(context).state is ControlStep){
      Recipe recipe = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).recipe;
      if(recipe.domains!.first.contains(RecipeDomains.StandMixerKey)){
        return;
      } else {
        BlocProvider.of<RecipeStepsCubit>(context).clearState();
      }
    }
  }

  Future<void> _getAppliancePresence() async {
    DevicePresence presence = await BlocProvider.of<ApplianceCubit>(context).getDevicePresence();
    BlocProvider.of<StandMixerControlCubit>(context).setPresence(presence);
  }

  @override
  Widget build(BuildContext context) {
    geaLog.debug('$tag.build');
    ContextUtil.instance.setRoutingContext = context;

    return FocusDetector(
        onFocusGained: () {
          geaLog.debug('$tag.onFocusGained');
          Future.delayed(Duration.zero,() {
            clearRecipeDataIfSwitchedFromAppliance();
            BlocProvider.of<StandMixerControlCubit>(context).requestCache();
            BlocProvider.of<NativeCubit>(context).showBottomBar(true);
            BlocProvider.of<NativeCubit>(context).showTopBar(true);
            if(BlocProvider.of<StandMixerControlCubit>(context).state.erdState != StandMixerErdState.loaded){
              _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.RETRIEVING_DATA));
            }
          });
        },
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                  children: [
                    SafeArea(
                        child: SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height,
                            child: BlocConsumer<StandMixerControlCubit, StandMixerControlState>(
                                listener: (context, state) {

                                },
                                builder: (context, state) {
                                  return SingleChildScrollView(
                                      physics: getScrollability(state.contentModel),
                                      child: Column(
                                          children: [
                                            SizedBox(height: 20.h),
                                            _recipeCardRow(),
                                                BlocConsumer<StandMixerControlCubit, StandMixerControlState>(
                                                  listener:(context, state) {
                                                    if(state.presence == null) {
                                                      _getAppliancePresence();
                                                    }
                                                    if (state.state == StandMixerState.modelNumberResponse) {
                                                      geaLog.debug('$tag modelNumberResponse');
                                                      BlocProvider.of<StandMixerControlCubit>(context).requestModelValidation(state.cache![ERD.APPLIANCE_MODEL_NUMBER]!);
                                                    }
                                                    if (state.state == StandMixerState.reset) {
                                                      geaLog.debug('$tag reset');
                                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                                          Routes.STAND_MIXER_CONTROL_PAGE, (route) => false);
                                                       BlocProvider.of<StandMixerControlCubit>(context).requestCache();
                                                    }                              
                                                    if(state.erdState == StandMixerErdState.loaded){
                                                      _checkForActiveRecipes(context); 
                                                      _loadingDialog.close(context);
                                                    }                     
                                                  },
                                                  builder: (context, state) {
                                                    if (state.erdState == StandMixerErdState.loading ||
                                                        state.erdState == StandMixerErdState.cleared) {
                                                      geaLog.debug('$tag loading or cleared');
                                                      return _defaultExpandableCard(context);
                                                    } else if (state.erdState == StandMixerErdState.loaded) {
                                                      geaLog.debug('$tag loaded');
                                                      if (state.state == StandMixerState.cacheResponse) {
                                                        geaLog.debug('$tag cacheResponse');
                                                        return _updateExpandableCard(context, state.cache, state.contentModel, state.presence);
                                                      } else if (state.state == StandMixerState.contentResponse) {
                                                        geaLog.debug('$tag contentResponse');
                                                        return _updateExpandableCard(context, state.cache, state.contentModel, state.presence);
                                                      }
                                                    }
                                                  return _defaultExpandableCard(context);
                                                }),
                                            SizedBox(
                                              height: 10.w,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    gradient: gradientDarkGreyCharcoalGrey(),
                                                    borderRadius: BorderRadius.circular(15)),
                                                height: 70.w,
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    _launchURL(_youtubeURL);
                                                    },
                                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Spacer(flex: 8),
                                                      SvgPicture.asset(
                                                          ImagePath.HOW_TO_VIDEO_ICON,
                                                          width: 22.w
                                                      ),
                                                      Spacer(flex: 1),
                                                      Text(LocaleUtil.getString(context, LocaleUtil.HOW_TO_VIDEOS)!.toUpperCase(), 
                                                        style: textStyle_size_14_bold_color_white(),
                                                      ),
                                                      Spacer(flex: 8),
                                                    ]
                                                  ),
                                                  
                                                ),
                                              ),
                                            )
                                          ])
                                  );
                                }
                            )
                        )
                    )
                  ]
              )
          ),
        )
    );
  }
  @override
  void initState() {
    super.initState();
    geaLog.debug('$tag.initState');
    WidgetsBinding.instance.addObserver(this);

    Future.delayed(Duration.zero,() {
      BlocProvider.of<StandMixerControlCubit>(context).showTopBar(true);
      BlocProvider.of<StandMixerControlCubit>(context).showBottomBar(true);
      BlocProvider.of<StandMixerControlCubit>(context).requestCache();
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    geaLog.debug('$tag.deactivate');
  }

  @override
  void dispose() {
    geaLog.debug('$tag.dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant StandMixerControlPage oldWidget) {
    geaLog.debug('$tag.didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      Future.delayed(Duration.zero,() {
        BlocProvider.of<StandMixerControlCubit>(context).requestCache();
      });
    }
  }

  void showSwitchModeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_SET_TO_REMOTE_ENABLED_POPUP)!,
          bodyText: '',
          imageSize: Size(220.w, 220.h),
          buttonActions: [AlertPopupAction(title: LocaleUtil.OK, action: () {})],
          imageUri: ImagePath.STAND_MIXER_REMOTE_ENABLE,
        );
      },
    );
  }

  Widget _recipeCardRow() {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                globals.subRouteName = Routes.RECIPE_DICOVER_PAGE;
                Navigator.of(context, rootNavigator: true).pushNamed( Routes.RECIPE_MAIN_NAVIGATOR, arguments: RecipeFilterArguments(domains: RecipeDomains.StandMixerAutoSense, isArthur: false));
              },
              child: ImageCard(
                imageURI: ImagePath.AUTO_SENSE_CONTROL,
                title: "${LocaleUtil.getString(context, LocaleUtil.AUTO_SENSE)}\n${LocaleUtil.getString(context, LocaleUtil.RECIPES)}",
              ),
            ),
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: () {
                globals.subRouteName = Routes.RECIPE_DICOVER_PAGE;
                Navigator.of(context, rootNavigator: true).pushNamed(Routes.RECIPE_MAIN_NAVIGATOR, arguments: RecipeFilterArguments(domains: RecipeDomains.StandMixerGuided, isArthur: false));
              },
              child: ImageCard(
                imageURI: ImagePath.GUIDED_CONTROL,
                title: "${LocaleUtil.getString(context, LocaleUtil.GUIDED)} ${LocaleUtil.getString(context, LocaleUtil.RECIPES)}",
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            globals.subRouteName = Routes.RECIPE_DICOVER_PAGE;
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.RECIPE_MAIN_NAVIGATOR, arguments: RecipeFilterArguments(domains: RecipeDomains.StandMixerGuided, isArthur: true));
          },
          child: Padding(
            padding: EdgeInsets.only(left: 6.w, right: 6.w, bottom: 20.h),
            child: AspectRatio(
              aspectRatio: 34 / 10,
              child: Container(
                width: MediaQuery.of(context).size.width - 12,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.h),
                    image: DecorationImage(image: AssetImage(ImagePath.KING_ARTHUR_TILE_IMAGE), fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.3),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.75)
                          ],
                          stops: [0.7, 1.0]
                      )
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox( width: 38.w,child: Image(image: AssetImage(ImagePath.KING_ARTHUR_LOGO_IMAGE),)),
                        Text(
                          LocaleUtil.getString(context, LocaleUtil.KING_ARTHUR_RECIPES)!,
                          style: textStyle_size_20_bold_color_white(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getMixerBrandName() {
    String name = "...";
    String brandName = BlocProvider.of<StandMixerControlCubit>(context).getBrandName();
    if(brandName == BrandName.PROFILE.name){
      return LocaleUtil.getString(context, LocaleUtil.PROFILE_SMART_MIXER)!;
    }
    return name;
  }
  
  ScrollPhysics getScrollability(StandMixerContentModel? model) {
    if (model == null || model.shouldScroll == null){
      return AlwaysScrollableScrollPhysics();
    } else {
        if (model.shouldScroll != true){
          return NeverScrollableScrollPhysics();
        } else {
          return AlwaysScrollableScrollPhysics();
        }
      }
  }
  
  Widget _defaultExpandableCard(BuildContext context) {
    return ReusableCollapsibleCard(
        isExpandableCard: false,
        cardTopLeftText: "...",
        cardTopRightText: LocaleUtil.getString(context, LocaleUtil.OFF)!,
        popUpCallback: showSwitchModeDialog,
        childWidget: null,
        isRemoteEnabled: false
    );
  }

  Widget _updateExpandableCard(BuildContext context,
      Map<String, String>? cache,
      StandMixerContentModel? contentModel, DevicePresence? devicePresence) {
    if (contentModel?.mixerMode == null ||
        cache == null) {
      return _defaultExpandableCard(context);
    }

    return ReusableCollapsibleCard(
      isExpandableCard: devicePresence == DevicePresence.online,
      cardTopLeftText: getMixerBrandName().toUpperCase(),
      cardTopRightText: devicePresence == DevicePresence.offline? LocaleUtil.getString(context, LocaleUtil.OFFLINE)!.toUpperCase() : LocaleUtil.getString(context, (contentModel?.mixerMode)!)!,
      popUpCallback: devicePresence == DevicePresence.offline? moveToOfflineScreen : showSwitchModeDialog,
      childWidget: StandMixerExpandedContent(
        contentModel: contentModel,
      ),
      isRemoteEnabled: contentModel?.mixerMode == LocaleUtil.REMOTE_ENABLED && devicePresence == DevicePresence.online,
    );
  }

  void moveToOfflineScreen() {
    BlocProvider.of<NativeCubit>(context).moveToOfflineScreen();
  }

  
  _launchURL(String link) async {
    if(await canLaunchUrlString(link)){
      await launchUrlString(link, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch link";
    }
  }
}
