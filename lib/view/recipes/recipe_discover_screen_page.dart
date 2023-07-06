import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/cubits/stand_mixer_cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/execution_id_response.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/models/recipe.dart' as Recipe;
import 'package:smarthq_flutter_module/models/recipe_details_model.dart';
import 'package:smarthq_flutter_module/resources/erd/0x0099.dart';
import 'package:smarthq_flutter_module/resources/erd/ERD.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/models/discover_recipe_response.dart';
import 'package:smarthq_flutter_module/models/recipe_capabilities_response.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/control/common_widget/long_image_card.dart';
import 'package:smarthq_flutter_module/view/control/common_widget/overlay_screen.dart';

import 'auto_sense_info_card.dart';

// ignore: must_be_immutable
class RecipeDiscoverPage extends StatefulWidget {
  final List<String>? domains;
  final bool isArthur;
  RecipeDiscoverPage({this.domains, required this.isArthur, Key? key}) : super(key: key);

  @override
  State<RecipeDiscoverPage> createState() => _RecipeDiscoverPageState();
}

class _RecipeDiscoverPageState extends State<RecipeDiscoverPage> with WidgetsBindingObserver {
  RecipeCapabilitiesResponse? _recipeCapabilitiesResponse;
  DiscoverRecipeResponse? _recipeResponse;
  late NativeCubit nativeControlCubit;
  bool filterActive = false;
  bool beenChecked = false;
  bool switchedAppliance = false;
  bool checkedForActiveRecipe = false;
  OverlayEntry? _overlayEntry;
  Timer? _overlayTimer;
  
  bool getAuto() {
    if(widget.domains != null){
      return widget.domains!.contains("mixer.autosense");
    } else {
      return false;
    }
  }

  String searchQuery = '';
  String oldQuery = '';
  ApplianceType applianceType = ApplianceType.UNDEFINED;

  void updateSearchQuery(String? newSearch) {
    setState(() {
      oldQuery = searchQuery;
      searchQuery = newSearch ?? '';
    });
    getDiscoverRecipes(context, searchQuery);
  }
  List<LongImageCard> _cardList = [];

  Future<DiscoverRecipeResponse?> getDiscoverRecipes(BuildContext context, String search) async {
    if (_recipeResponse == null) {
      _recipeCapabilitiesResponse = (await BlocProvider.of<RecipeCubit>(context).getRecipeCapabilities(!getAuto(), context));
      _recipeResponse = (await BlocProvider.of<RecipeCubit>(context).getDiscoverRecipes(getAuto(), widget.isArthur, searchQuery, widget.domains, context));
    }
    createCardList(_recipeResponse);
    return _recipeResponse;
  }

  void createCardList(DiscoverRecipeResponse? _recipeResponse){
    setState(() {
      this._cardList = [];
      _recipeResponse?.result.forEach((result) {
        _cardList.add(LongImageCard(
          isAuto: getAuto(),
          isArthur: widget.isArthur,
          recipeId: result.recipeId,
          title: result.metaName,
          subtitle: result.shortDescription,
          userId: _recipeCapabilitiesResponse!.userId!,
          imageURI: findByHeroID(result.media, result.mediaId),
          estTime: result.instructions[0].readyInMins.gte,
          key: Key(result.recipeId),
        )
        );
      });
    });
  }

  String? findByHeroID(List<Media> allMedia, String heroMediaId){
    for (var media in allMedia) {
      if(media.id == heroMediaId){
        if(media.sizes.length > 1) {
          return media.sizes.reduce((current, next) => int.parse(current.widthPixels) > int.parse(next.widthPixels) ? current: next).mediaUrl;
        } else {
          return media.sizes.first.mediaUrl; //ensures one of the images populates
        }
      }
    }
    return null;
  }

  @override
  void dispose() {
    geaLog.debug("RecipeDiscoverPage dispose");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _openSmartSenseDialog(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      return SmartSenseInfoCard(isAuto: getAuto());
    });
  }

  Future<void> _handleBackPress() async {
    if (BlocProvider.of<ApplianceCubit>(context).getApplianceTypeForRequest() == "Stand Mixer"){
      BlocProvider.of<RecipeDetailsCubit>(context).clearState();
      BlocProvider.of<RecipeStepsCubit>(context).clearState();
      Navigator.of(context, rootNavigator: true).pushNamed(Routes.STAND_MIXER_CONTROL_MAIN_NAVIGATOR);
    } else {
      BlocProvider.of<NativeCubit>(context).clearReturnedRoute();
      BlocProvider.of<RecipeCubit>(context).clearAllRecipes();
      _recipeResponse = null;
      _recipeCapabilitiesResponse = null;
      BlocProvider.of<NativeCubit>(context).closeFlutterScreen();
    }
  }

  Future<void> _checkForActiveRecipes(BuildContext context) async {
    Map<String, String>? cache = BlocProvider.of<StandMixerControlCubit>(context).state.cache;
    await BlocProvider.of<ApplianceCubit>(context).setCurrentAppliance();
    ApplianceType _applianceType = BlocProvider.of<ApplianceCubit>(context).state.applianceType ?? ApplianceType.UNDEFINED;
    if(cache != null && checkedForActiveRecipe != true) {
      if(cache.containsKey(ERD.RECIPE_STATUS)){
        BlocProvider.of<RecipeStepsCubit>(context).checkForActiveRecipes(context, _applianceType);
        checkedForActiveRecipe = true;
      }
    }
    if (BlocProvider.of<RecipeStepsCubit>(context).state is ControlStep) {
      int? recipeStep = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).currentStep;
      Recipe.Recipe recipe = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).recipe;
      beenChecked = true;
      String recipeDomain = recipe.domains!.first.split('.')[0];
      if(_applianceType == ApplianceType.TOASTER_OVEN && recipeDomain == "speedcook"){
        List<bool> indexTracker = BlocProvider.of<RecipeStepsCubit>(context).getUpdatedIndexTracker(recipe, recipeStep - 1);
        BlocProvider.of<RecipeStepsCubit>(context).advanceToNextStepArchetype(context, recipeStep - 1, recipe, indexTracker);
      }else if(_applianceType == ApplianceType.STAND_MIXER && recipeDomain == "mixer"){
        List<bool> indexTracker = BlocProvider.of<RecipeStepsCubit>(context).getUpdatedIndexTracker(recipe, recipeStep - 1);
        BlocProvider.of<RecipeStepsCubit>(context).advanceToNextStepArchetype(context, recipeStep - 1, recipe, indexTracker);
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(Duration.zero, () {
      BlocProvider.of<StandMixerControlCubit>(context).clearRecipeStatus();
      BlocProvider.of<RecipeDetailsCubit>(context).setIsAuto(getAuto());
      if (widget.domains == RecipeDomains.SpeedcookGuided){
        BlocProvider.of<RecipeStepsCubit>(context).checkForActiveRecipes(context, ApplianceType.TOASTER_OVEN);
      }
      applianceType = BlocProvider.of<ApplianceCubit>(context).state.applianceType!;
    });
    super.initState();
    
    getDiscoverRecipes(context, searchQuery);
  }


  bool areDomainsEqual(){
    final widgetFirstDomain = widget.domains!.first.split(".")[0];

    final recipeStepsCubit = BlocProvider.of<RecipeStepsCubit>(context);
    final cubitControlStep = recipeStepsCubit.state as ControlStep;
    final cubitControlStepFirstDomain = cubitControlStep.recipe.domains!.first.split('.')[0];

    return widgetFirstDomain == cubitControlStepFirstDomain;
  }

  Future<void> readStateForStepIndex(BuildContext context) async {
    if (BlocProvider.of<RecipeStepsCubit>(context).state is ControlStep) {
      geaLog.debug("Current Step is ${(BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).currentStep}");
      int? recipeStep = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).currentStep;
      Recipe.Recipe recipe = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).recipe;
      String userId = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).userId;
      bool isAuto = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).isAuto;
      bool isArthur = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).isArthur;
      String applianceString = (BlocProvider.of<ApplianceCubit>(context).getApplianceTypeForRequest());
      beenChecked = true;
      geaLog.debug("RecipeDiscoverPage readStateForStepIndex: $recipeStep");
      await BlocProvider.of<RecipeDetailsCubit>(context).loadRecipeData(context, recipe.id!);
      RecipeDetailContentModel model = BlocProvider.of<RecipeDetailsCubit>(context).state.contentModel ?? RecipeDetailContentModel();
      BlocProvider.of<RecipeDetailsCubit>(context).pushPreferencesAndProgressToNextPage(recipe, model, context, userId, isAuto, isArthur, applianceString, setStepData, stepIndex: recipeStep);
    }
  }

  Future<void> setStepData(Recipe.Recipe recipeData, String userId, bool isAuto, bool isArthur, List<Recipe.IngredientObjects> updatedIngredients, BuildContext context, RecipeDetailContentModel model, String applianceString) async {
    ExecutionIDResponse? executionID;
    executionID = await BlocProvider.of<RecipeDetailsCubit>(context).getExecutionID(context, model, userId, recipeData.id!,  recipeData.menuTreeInstructions![0].id!, applianceString);
    final stepsCubit = BlocProvider.of<RecipeStepsCubit>(context);
    await stepsCubit.storeSteps(recipeData,executionID != null? executionID.executionId: "",userId, isAuto, isArthur, updatedIngredients, applianceType);
    BlocProvider.of<RecipeStepsCubit>(context).advanceCloudIndex(0, context, applianceString);
  }

  void _showOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(builder: (context) => OverlayScreen());
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    if(_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  void _clearOverlayTimer() {
    _overlayTimer?.cancel();
    _overlayTimer = null;
  }

  /// The function is never called
  void _handleOverlay(){
    if(_overlayEntry != null){
      _overlayTimer = Timer(const Duration(seconds: 1), () { 
        _hideOverlay();
        _clearOverlayTimer();
        });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    geaLog.debug("RecipeDiscoverPage didChangeAppLifecycleState: $state");
    super.didChangeAppLifecycleState(state);
    geaLog.debug('RecipeNavigator:didChangeAppLifecycleState:$state');
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      if (_overlayEntry == null) {
        _showOverlay(context);
      }
      _handleOverlay();
      BlocProvider.of<ApplianceCubit>(context).setCurrentAppliance();
    }
  }

  String getRecipesDescription(){
    ApplianceType _applianceType = BlocProvider.of<ApplianceCubit>(context).state.applianceType!;
    if (getAuto()){
      //AUTO SENSE LIST
      switch(_applianceType){
        case ApplianceType.STAND_MIXER : 
          if(BlocProvider.of<StandMixerControlCubit>(context).getBrandName() == BrandName.PROFILE.name)
          return LocaleUtil.getString(context, LocaleUtil.PROFILE_STAND_MIXER_AUTO_SENSE_DISCOVER_DESCRIPTION)!;
          else
          return LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_AUTO_SENSE_DISCOVER_DESCRIPTION)!;
        default:
          return LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_AUTO_SENSE_DISCOVER_DESCRIPTION)!;
      }
    } else {
      //GUIDED RECIPE LIST
      switch(_applianceType){
        case ApplianceType.TOASTER_OVEN : 
          if(BlocProvider.of<ToasterOvenControlCubit>(context).getBrandName() == BrandName.PROFILE.name)
          return LocaleUtil.getString(context, LocaleUtil.PROFILE_GUIDED_DISCOVER_DESCRIPTION_SPEEDCOOK)!;
          else 
          return LocaleUtil.getString(context, LocaleUtil.GUIDED_DISCOVER_DESCRIPTION_SPEEDCOOK)!;
        case ApplianceType.STAND_MIXER : 
          if(BlocProvider.of<StandMixerControlCubit>(context).getBrandName() == BrandName.PROFILE.name)
          return LocaleUtil.getString(context, LocaleUtil.GUIDED_DISCOVER_DESCRIPTION_PROFILE_SMART_MIXER)!;
          else 
          return LocaleUtil.getString(context, LocaleUtil.GUIDED_DISCOVER_DESCRIPTION_STAND_MIXER)!;

        default : 
          return LocaleUtil.getString(context, LocaleUtil.GUIDED_DISCOVER_DESCRIPTION)!;      
    }
    }
  }

  void clearRecipeDataIfSwitchedFromDifferentAppliance(String domainKey){
    if(BlocProvider.of<RecipeStepsCubit>(context).state is ControlStep){
      Recipe.Recipe recipe = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).recipe;
      if(recipe.domains!.first.contains(domainKey)){
        return;
      } else {
        BlocProvider.of<RecipeStepsCubit>(context).clearState();
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          centerTitle: true,
          elevation: 0.0,
          leading:  IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: _handleBackPress,
          ),
          title: Text(LocaleUtil.getString(context, LocaleUtil.DISCOVER_RECIPES)!.toUpperCase(), style: textStyle_size_18_bold_color_white_spaced()),
        ),
        backgroundColor: Colors.black,
        body: FocusDetector(
          onFocusGained: () {
            BlocProvider.of<NativeCubit>(context).showTopBar(false);
            geaLog.debug("appliance type disc : $applianceType");
            if(applianceType == ApplianceType.TOASTER_OVEN){
              clearRecipeDataIfSwitchedFromDifferentAppliance(RecipeDomains.SpeedcookKey);
              BlocProvider.of<ToasterOvenControlCubit>(context).requestCache();
            }
            Future.delayed(Duration.zero, (){
            if(BlocProvider.of<RecipeStepsCubit>(context).state is ControlStep){                                                                                               
              if ((BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).returnedRoute != null && !beenChecked) {
                readStateForStepIndex(context);
              }
              if (!beenChecked && (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).returnedRoute == null){
                _checkForActiveRecipes(context);
              }                            
            }
          });
          },
          child: BlocListener<ApplianceCubit, ApplianceState>(
            listener: (context, state) {
              geaLog.debug("Appliance Type Changed: ${state.applianceType}");
              applianceType = state.applianceType ?? applianceType;
              if(state.applianceType != null && state.applianceType != ApplianceType.UNDEFINED){
                String savedRecipeDomain = BlocProvider.of<RecipeDetailsCubit>(context).state.domains!.first.split(".")[0];
                if(savedRecipeDomain == "mixer" && state.applianceType == ApplianceType.STAND_MIXER){
                  return;
                }
                if(savedRecipeDomain == "speedcook" && state.applianceType == ApplianceType.TOASTER_OVEN){
                  return;
                }
                BlocProvider.of<RecipeDetailsCubit>(context).clearState();
                BlocProvider.of<RecipeStepsCubit>(context).clearState();
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            },
            listenWhen: (previous, current) => previous.applianceType != current.applianceType && current.applianceType != ApplianceType.UNDEFINED ,
            child: BlocBuilder<RecipeStepsCubit, RecipeStepsState>(
                        builder: (context, snapshot) {
                          return SafeArea(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  children: [
                                    widget.isArthur ? Padding(
                                      padding: EdgeInsets.only(bottom: 16.h),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 160.h,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(image: AssetImage(ImagePath.KING_ARTHUR_TILE_IMAGE), fit: BoxFit.fitWidth)),
                                        child: Container(
                                          decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.94),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.black.withAlpha(0),
                                                    Colors.black.withOpacity(0.6)
                                                  ]
                                              )
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 38.w,
                                                child: Image(
                                                  image: AssetImage(
                                                      ImagePath.KING_ARTHUR_LOGO_IMAGE
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                LocaleUtil.getString(context, LocaleUtil.KING_ARTHUR_RECIPES)!,
                                                style: textStyle_size_18_bold_color_white_spaced(),
                                              ),
                                            ],
                                          ),
                                        ), ),
                                    ) :
                                    Container(
                                      margin: EdgeInsets.all(12.w),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(getAuto()
                                                  ? "${LocaleUtil.getString(context, LocaleUtil.AUTO_SENSE)} ${LocaleUtil.getString(context, LocaleUtil.RECIPES)}"
                                                  : "${LocaleUtil.getString(context, LocaleUtil.GUIDED)} ${LocaleUtil.getString(context, LocaleUtil.RECIPES)}",
                                                  style: textStyle_size_20_bold_color_white()),
                                              getAuto() ? Padding(
                                                  padding: EdgeInsets.only(left: 2),
                                                  child: SizedBox(
                                                    width: 35.w,
                                                    height: 42.h,
                                                    child: IconButton(
                                                      onPressed: () => getAuto()? _openSmartSenseDialog(context): null,
                                                      icon: Icon(Icons.info, color: colorDarkLiver(), size: 22.sp),
                                                    ),
                                                  )
                                              ) : Container()
                                            ],
                                          ),
                                          Text(getRecipesDescription(), style: textStyle_size_14_color_white(),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 11.w),
                                        child: _cardList.length > 0 || filterActive ? Container(
                                            child: ListView(
                                              children: _cardList,
                                            )
                                        ) : Center(
                                          child: SizedBox(
                                              width: 50.w,
                                              height: 50.w,
                                              child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(colorDeepPurple()),
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          );
                        }
                    ),
          ),
        )
    );
  }
}
