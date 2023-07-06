/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/stand_mixer_cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/execution_id_response.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/models/recipe_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/recipes/common/unsupported_character_handler.dart';
import 'package:smarthq_flutter_module/view/recipes/fading_slider_app_bar_page.dart';
import 'package:smarthq_flutter_module/view/recipes/common/recipe_cheat_sheet.dart';
import 'package:smarthq_flutter_module/view/recipes/navigator/recipe_navigator.dart';

// ignore: must_be_immutable
class RecipeDetailScreen extends StatefulWidget {
  final String recipeId;
  final String? mediaId;
  final String userId;
  final bool isAuto;
  final bool isArthur;

  RecipeDetailScreen(
      {required this.recipeId,
        required this.userId,
        this.mediaId,
        required this.isAuto,
        required this.isArthur
      });

  @override
  State<RecipeDetailScreen> createState() =>
      _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  RecipeDetailContentModel? _contentModel;
  bool showCheatSheet = false;

  ScrollController controller = new ScrollController();
 
  @override
  void initState() {
    controller.addListener(_scrollListener);
    Future.delayed(Duration.zero, () {
      BlocProvider.of<RecipeDetailsCubit>(context).loadRecipeData(context, widget.recipeId);
    });
    super.initState();
  }

    Future<String> getUserId() async {
      return RepositoryProvider.of<NativeStorage>(context).userId ?? "";
    }

  @override
  void didUpdateWidget (covariant RecipeDetailScreen oldWidget) {
    BlocProvider.of<RecipeCubit>(context).closePageIfApplianceWasSwitched(context, "Recipe Detail Screen");
    super.didUpdateWidget(oldWidget);
  }

  _scrollListener() {
    if (controller.offset <= controller.position.minScrollExtent && !controller.position.outOfRange) {
      setState(() {});
    }
  }



  void updatePreferenceSelection(Recipe recipe, int indexSelected) {
    setState(() {
      if (recipe.menuTreeInstructions![0].selectableOptions != null) {
      _contentModel =  BlocProvider.of<RecipeDetailsCubit>(context).setStateContentModel(model: _contentModel,
            userPreferenceSelection: recipe.menuTreeInstructions![0].selectableOptions![1].selectableValues![indexSelected],
            userPreferenceId: recipe.menuTreeInstructions![0].selectableOptions![1].selectableValues![indexSelected].consistency!.toLowerCase());
      }
    });
  }

 void createUpdatedIngredientsList(Recipe recipe, String servingSizeId, RecipeDetailContentModel? model) {
    List<IngredientObjects> updatedList = [];
    recipe.ingredientObjects!.forEach((element) {
      bool hasUserPrefId = model!.userPreferenceId != null;
      if (element.id!.contains(servingSizeId) || (hasUserPrefId && element.id!.contains(model.userPreferenceId!)) || !element.id!.contains("serving")) {
        updatedList.add(new IngredientObjects(
            id: element.id,
            mediaId: element.mediaId,
            alternateMeasure: element.alternateMeasure,
            foodMeasure: element.foodMeasure,
            name: element.name));
      }
    });
    if (updatedList.length == 0) {
      updatedList = recipe.ingredientObjects!;
    }
    setState(() {
      _contentModel = BlocProvider.of<RecipeDetailsCubit>(context).setStateContentModel(model: _contentModel, updatedIngredientList: updatedList);
    });
  }
  

  void updateServingSizeId(int index) {
    geaLog.debug("updateServingSizeId: " + index.toString());
    switch (index) {
      case 0:
        _contentModel =  BlocProvider.of<RecipeDetailsCubit>(context).setStateContentModel(model: _contentModel,
          userServingSizeId: "one-serving",
          optionConfigQuantity: "cups-1");
        break;
      case 1:
       _contentModel =  BlocProvider.of<RecipeDetailsCubit>(context).setStateContentModel(model: _contentModel,
          userServingSizeId: "two-serving",
          optionConfigQuantity: "cups-2");
        break;
      case 2:
        _contentModel =  BlocProvider.of<RecipeDetailsCubit>(context).setStateContentModel(model: _contentModel,
          userServingSizeId: "three-serving",
          optionConfigQuantity: "cups-3");
        break;
      case 3:
        _contentModel =  BlocProvider.of<RecipeDetailsCubit>(context).setStateContentModel(model: _contentModel,
          userServingSizeId: "four-serving",
          optionConfigQuantity: "cups-4");
        break;
      case 4:
        _contentModel =  BlocProvider.of<RecipeDetailsCubit>(context).setStateContentModel(model: _contentModel,
          userServingSizeId: "five-serving",
          optionConfigQuantity: "cups-5");
        break;
      case 5:
        _contentModel = BlocProvider.of<RecipeDetailsCubit>(context).setStateContentModel(model: _contentModel,
          userServingSizeId: "six-serving",
          optionConfigQuantity: "cups-6");
        break;
    }
    setState(() {

    });
  }

   void updateServingSizeSelection(Recipe recipe, bool isIncrease) {
    final options = recipe.menuTreeInstructions![0].selectableOptions![0].selectableValues!;
    var currentIndex = options.indexWhere((element) => element.description! == _contentModel!.userServingSizeSelection?.description);
    if (isIncrease) {
      if (currentIndex + 1 != options.length) {
          currentIndex += 1;
          _contentModel =  BlocProvider.of<RecipeDetailsCubit>(context).setStateContentModel(model: _contentModel,
            userServingSizeSelection: options[currentIndex],
            decreaseButtonColor: _contentModel!.activeButtonColor!);
          updateServingSizeId(currentIndex);

          createUpdatedIngredientsList(recipe, _contentModel!.userServingSizeId!, _contentModel);


        if (currentIndex + 1 == options.length) {
          _contentModel =  BlocProvider.of<RecipeDetailsCubit>(context).setStateContentModel(model: _contentModel, increaseButtonColor: _contentModel!.inactiveButtonColor!);
        }
      }
    } else {
      if (currentIndex - 1 != -1) {
          currentIndex -= 1;

          _contentModel =  BlocProvider.of<RecipeDetailsCubit>(context).setStateContentModel(model: _contentModel,
            userServingSizeSelection: options[currentIndex],
            increaseButtonColor: _contentModel!.activeButtonColor!);
          updateServingSizeId(currentIndex);
          createUpdatedIngredientsList(recipe, _contentModel!.userServingSizeId!, _contentModel);

        if (currentIndex - 1 == -1) {
          _contentModel =  BlocProvider.of<RecipeDetailsCubit>(context).setStateContentModel(model: _contentModel, decreaseButtonColor: _contentModel!.inactiveButtonColor!);
        }
      }
    }
    setState(() {});
  }

  void updateIngredientsList(Recipe recipe, RecipeDetailContentModel? model) {
    int? optionValue = recipe.menuTreeInstructions![0].selectableOptions![0].selectableValues![0].valueRange?.gte?.toInt();
    if(optionValue == null) {
      optionValue = 1;
    }
    updateServingSizeId(int.parse(optionValue.toString()));
    createUpdatedIngredientsList(recipe, model!.userServingSizeId!, model);
  }

  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;
    bool isSmallScreen = MediaQuery.of(context).size.width < 392;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _contentModel == null? AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
                BlocProvider.of<RecipeDetailsCubit>(context).clearStateButKeepDiscoveryData();    
                BlocProvider.of<RecipeStepsCubit>(context).clearState();                          
                Navigator.pushReplacementNamed(context, Routes.STAND_MIXER_CONTROL_PAGE);                              
            },
          ),
        ): null,
      body: FocusDetector(
        onFocusGained: () {
          BlocProvider.of<NativeCubit>(context).showTopBar(false);
        },
        child: SafeArea(
          child: BlocConsumer<RecipeDetailsCubit,RecipeDetailsState> (
            listener: ((context, state) {
              if(state.state == RecipeDetailState.loaded){
                geaLog.debug("RecipeDetailState.loaded");
                setState(() {
                  _contentModel = state.contentModel;
                  updateIngredientsList(state.recipe!, _contentModel);
                });
              }
              
            }),
              builder: (context, state) {
              if(_contentModel == null){
                return Container(
                  color: Colors.black,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colorDeepPurple(),
                    ),
                  ),
                );
              } else if (state.state == RecipeDetailState.loaded) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showCheatSheet = false;
                            BlocProvider.of<NativeCubit>(context).showBottomBar(true);
                          });
                        },
                        child: Opacity(
                          opacity: (showCheatSheet == true) ? 0.5 : 1.0,
                          child: FadingSliverAppBarPage(
                            imageUrl: (state.recipe!.mediaId != null && state.recipe!.mediaId!.length > 0) 
                            ? state.recipe!.media!.where((element) => element.id == state.recipe!.mediaId).first.sizes![0].mediaUrl! 
                            : null,
                            backgroundColor: Colors.black,
                            leading: IconButton(
                              onPressed: () {
                                BlocProvider.of<RecipeStepsCubit>(context).clearState();
                                Navigator.pushReplacementNamed(context, Routes.RECIPE_DICOVER_PAGE, arguments: RecipeFilterArguments(domains: state.domains, isArthur: widget.isArthur));
                                BlocProvider.of<RecipeDetailsCubit>(context).clearStateButKeepDiscoveryData();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            title: _contentModel!.placeholderTitle!.toUpperCase(),
                            titleStyle: textStyle_size_18_bold_color_white_spaced(),
                            animationSpeedInMilliseconds: 200,
                            children: [
                  Stack(
                    children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.w, right: 12.w),
                        child: SingleChildScrollView(
                          child: Column(children: [
                           _recipeDetailsTopCardDescriptionAndViewSteps(state.recipe!),
                            _contentModel!.hasPreferences! ?
                            Padding(
                              padding:  EdgeInsets.only(top: 20.0.h),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          colorEerieBlack(),
                                          colorDarkCharcoal()
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter),
                                    borderRadius:
                                    BorderRadius.circular(10.w)),
                                child: _recipePreferencesCard(state.recipe!, isSmallScreen)
                              ),
                            ) : SizedBox(height: 0),
                           state.recipe != null ?  _recipeIngredientsCard(state.recipe!) : SizedBox(height: 0),
                            state.recipe != null ? _recipeEquipmentCard(state.recipe!): SizedBox(height: 0),
                            SizedBox(height: 180.h)
                          ]),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
          _startButton(state.recipe!),
          RecipeCheatSheet(
              ingredientsList: _contentModel!.updatedIngredientList!,
              isAutoSense: widget.isAuto,
              recipeTitle: state.recipe!.label!,
              isShown: showCheatSheet,
              stepsList: BlocProvider.of<RecipeDetailsCubit>(context).getStepsList(state.recipe!, _contentModel!.userPreferenceId ?? "", _contentModel!.userServingSizeId!, _contentModel!)),
            ],
          );
        }
           return Center(
            child: SizedBox(
            width: 50.w,
            height: 50.w,
            child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(colorDeepPurple()),   
          )),
          );
          }),
        ),
      ),
 );
}


Future<void> _startPressed(Recipe recipeData) async {
  BlocProvider.of<RecipeDetailsCubit>(context).pushPreferencesAndProgressToNextPage(
      recipeData,
      _contentModel!,
      context,
      await getUserId(),
      widget.isAuto,
      widget.isArthur,
      BlocProvider.of<ApplianceCubit>(context).getApplianceTypeForRequest(),
      setStepData
    );
}
  Future<void> setStepData(Recipe recipeData, String userId, bool isAuto, bool isArthur, List<IngredientObjects> updatedIngredients, BuildContext context, RecipeDetailContentModel model, String applianceString) async {
    ExecutionIDResponse? executionID = ExecutionIDResponse.toEmpty();
    if(BlocProvider.of<ApplianceCubit>(context).state.appliancePresence != DevicePresence.offline){
      executionID = await BlocProvider.of<RecipeDetailsCubit>(context).getExecutionID(context, model, userId, recipeData.id!,  recipeData.menuTreeInstructions![0].id!, applianceString);
    }
    final stepsCubit = BlocProvider.of<RecipeStepsCubit>(context);
    ApplianceType applianceType = BlocProvider.of<ApplianceCubit>(context).state.applianceType ?? ApplianceType.UNDEFINED;
    await stepsCubit.storeSteps(recipeData,executionID != ExecutionIDResponse.toEmpty()? executionID?.executionId: "",userId, isAuto, isArthur, updatedIngredients, applianceType);
    if(executionID != ExecutionIDResponse.toEmpty()){
      BlocProvider.of<RecipeStepsCubit>(context).advanceCloudIndex(0, context, applianceString);
    }
  }


Widget _recipeDetailsTopCardAboutAndServingSizeRow(Recipe recipeData) {
  return Padding(
        padding: EdgeInsets.only(left: 12.w, top: 12.h, right: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width:MediaQuery.of(context).size.width * 0.345,
                  height: 85.h,
                  decoration: BoxDecoration(
                    color: colorRaisinBlack(),
                    borderRadius:BorderRadius.circular(10.w)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset(
                            ImagePath.TIME_ICON,
                            width: 35.w,
                            height: 37.h,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(flex: 1),
                          Text(
                            LocaleUtil.getString(context, LocaleUtil.ABOUT)!,
                            textAlign: TextAlign.left,
                            style: textStyle_size_14_color_grey_spaced(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.w),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text( "${recipeData.menuTreeInstructions![0].readyInMinsRange!.lte} ${LocaleUtil.getString(context, LocaleUtil.MIN)!.toUpperCase()}",
                                  style: textStyle_size_14_color_white_spaced()),
                            ),
                          ),
                          Spacer(flex: 2)
                        ],
                      ),
                    )
                  ])),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Container(
                  width:MediaQuery.of(context).size.width * 0.47,
                  height: 85.h,
                  decoration: BoxDecoration(
                    color: colorRaisinBlack(),
                    borderRadius: BorderRadius.circular(10.w)),
                  child: Padding(
                    padding: EdgeInsets.only(top: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment:Alignment.center,
                          child: Text(
                            LocaleUtil.getString(context, LocaleUtil.SERVING_SIZE)!,
                            style: textStyle_size_14_color_grey_spaced(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Align(
                            alignment:
                            Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible: recipeData.menuTreeInstructions![0].selectableOptions![0].selectableValues!.length > 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child:
                                    GestureDetector(
                                      onTap:() => {
                                        updateServingSizeSelection(recipeData,false)
                                      },
                                      child: Container(
                                        height: 28.h,
                                        width: 28.w,
                                        decoration: BoxDecoration(color: _contentModel?.decreaseButtonColor, borderRadius: BorderRadius.circular(14.w)),
                                        child: Center(
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                     _contentModel?.userServingSizeSelection?.description ?? "",
                                      textAlign: TextAlign.center,
                                      style: textStyle_size_14_color_white_spaced()),
                                ),
                                Visibility(
                                  visible: recipeData.menuTreeInstructions![0].selectableOptions![0].selectableValues!.length > 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 12.w),
                                    child: GestureDetector(
                                      onTap:
                                          () => {
                                        updateServingSizeSelection(recipeData,true)
                                      },
                                      child:
                                      Container(
                                        height: 28.h,
                                        width: 28.w,
                                        decoration: BoxDecoration(color: _contentModel?.increaseButtonColor, borderRadius: BorderRadius.circular(14.w)),
                                        child:
                                        Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

Widget _recipeDetailsTopCardDescriptionAndViewSteps(Recipe recipeData) {
   return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                colorDarkCharcoal(),
                colorDarkCharcoal().withOpacity(0.7),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
          borderRadius: BorderRadius.circular(10.w)),
      child: Column(
        children: [
        _recipeDetailsTopCardAboutAndServingSizeRow(recipeData),
        Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h, bottom: 20.h),
          child: Column(
            children: [
              Text(recipeData.notes ?? "",
                style: textStyle_size_14_light_color_white(),
              ),
              SizedBox(height: 25.h),
              InkWell(
                onTap: () {
                  setState(() {
                    BlocProvider.of<NativeCubit>(context).showBottomBar(false);
                    showCheatSheet = true;
                  });
                },
                child: Row(
                  children: [
                    Text(LocaleUtil.getString(context, LocaleUtil.VIEW_STEPS)!,
                        style: textStyle_size_14_color_white_underlined()),
                    SizedBox(
                      width: 5.w,
                    ),
                    SvgPicture.asset(
                      ImagePath.STEPS_ICON,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    ),
  );
 }

Widget _recipePreferencesCard(Recipe recipeData, bool isSmallScreen){
  double getPreferenceCardHeight(){
    double height = 120.h;
    if ((recipeData.menuTreeInstructions![0].selectableOptions!.firstWhere((element) => element.type == "Preferences").selectableValues!.length <= 3 && !isSmallScreen) 
    || (isSmallScreen && recipeData.menuTreeInstructions![0].selectableOptions!.firstWhere((element) => element.type == "Preferences").selectableValues!.length < 3)) {
      height = 60.h;
      }
      return height;
  }

  return Column(
            children: [
            Padding(
              padding: EdgeInsets.only(left: 13.w, top: 13.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(LocaleUtil.getString(context, LocaleUtil.PREFERENCES)!,
                    style: textStyle_size_14_bold_color_white_spaced()),
              ),
            ),
            SizedBox(
              height: getPreferenceCardHeight(),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recipeData.menuTreeInstructions![0].selectableOptions![1].selectableValues!.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w, top: 10.h),
                      child: GestureDetector(
                          onTap: () => {
                          updatePreferenceSelection(recipeData,index)
                          },
                          child: Visibility(
                            visible:  _contentModel!.userPreferenceSelection!.description != null,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.w),
                                  color: BlocProvider.of<RecipeDetailsCubit>(context).checkCurrentPreferenceSelection(recipeData,index, _contentModel)
                                      ? colorDeepPurple()
                                      : colorDarkLiver()
                              ),
                              child: FittedBox(
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal:8.0.w),
                                  child: Center(
                                    child: Text(
                                      recipeData.menuTreeInstructions![0].selectableOptions![1].selectableValues![index].description!.toUpperCase(),
                                      style: textStyle_size_14_color_white_spaced(),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    );
                  }), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isSmallScreen ? 2 : 3,
                    childAspectRatio: isSmallScreen ? 4 : 2.5),),
              ),
            )
          ]);
}

Widget _recipeIngredientsCard(Recipe recipeData){
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Container(
        width: MediaQuery.of(context).size.width - 24,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  colorRaisinBlack(),
                  colorDeepDarkCharcoal(),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
            borderRadius:
            BorderRadius.circular(10.w)),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(left: 13.w, top: 13.h),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Text(LocaleUtil.getString(context, LocaleUtil.INGREDIENTS)!,
                    style: textStyle_size_14_bold_color_white_spaced()),
                Spacer(flex: 2),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h, left: 13.w, right: 13.w),
            child: Divider(
              height: 1.h,
              color: Colors.white.withOpacity(.4),
            ),
          ),
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:  _contentModel?.updatedIngredientList!.length,
              itemBuilder: ((context, index) {
                return Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 14.w, top: 20.h),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 25.w),
                                child: Image(
                                    width: 40.w,
                                    height: 40.h,
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                      return SvgPicture.asset(
                                        ImagePath.TIME_ICON,
                                        width: 40.w,
                                        height: 40.h,
                                      );
                                    },
                                    image: NetworkImage(
                                    recipeData.media != null 
                                    && recipeData.media!.length > 0 
                                    && (_contentModel?.updatedIngredientList![index].mediaId) != null
                                    && (_contentModel?.updatedIngredientList![index].mediaId!)!.isNotEmpty ?
                                     recipeData.media!.firstWhere((element) => element.id ==  _contentModel?.updatedIngredientList![index].mediaId).sizes!.
                                     firstWhere((element) => element.id == "96x96", orElse: () {
                                        return recipeData.media!.firstWhere((element) => element.id == _contentModel?.updatedIngredientList![index].mediaId).sizes!.first;
                                     },).mediaUrl ?? "" : "",)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  child: Text(_contentModel!.updatedIngredientList![index].name ?? "",
                                    style: textStyle_size_14_bold_color_white(),
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 16.w),
                                child: Align(
                                  alignment:Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.end,
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                      unsupportedCharacterHandler(BlocProvider.of<RecipeDetailsCubit>(context).formatQuantityString(_contentModel!.updatedIngredientList![index]),
                                          style: textStyle_size_14_bold_color_white()),
                                      Padding(
                                        padding: const EdgeInsets.only(),
                                        child: Visibility(
                                          visible: ( _contentModel?.updatedIngredientList![index].alternateMeasure != null),
                                          child: unsupportedCharacterHandler(
                                          _contentModel?.updatedIngredientList![index].alternateMeasure ?? "",
                                          style: textStyle_size_14_color_white()),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 13.w, top: 10.h),
                            child: Divider(
                              color: Colors.white.withOpacity(_contentModel!.updatedIngredientList!.length > index + 1 
                                ? 0.4.h
                                : 0.h
                            ),),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })),
          // SizedBox(height: 20)
        ]),
      ),
    );
}

Widget _recipeEquipmentCard(Recipe recipeData){
  return Padding(
    padding: EdgeInsets.only(top: 20.h),
    child: Container(
      width: MediaQuery.of(context).size.width - 12.w,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                colorRaisinBlack(),
                colorDeepDarkCharcoal(),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
          borderRadius: BorderRadius.circular(10.w)),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 13.w, top: 13.h),
              child: Text(LocaleUtil.getString(context, LocaleUtil.EQUIPMENT)!,
                  style: textStyle_size_14_color_white_spaced()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h, left: 13.w, right: 13.w),
            child: Divider(
              height: 1.h,
              color:
              Colors.white.withOpacity(.4),
            ),
          ),
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recipeData.equipment!.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 27.w, top: 20.h),
                  child: Row(children: [
                    Image(
                        width: 32.w,
                        errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Container(
                         width: 35.w,
                         height: 35.h,
                         child: SvgPicture.asset(ImagePath.TIME_ICON),
                        );
                        },
                        image: NetworkImage(recipeData.media != null 
                        && recipeData.media!.length > 0  
                        && recipeData.equipment![index].mediaId != null 
                        && recipeData.equipment![index].mediaId!.isNotEmpty
                        ? recipeData.media!.firstWhere((element) => element.id == recipeData.equipment![index].mediaId).sizes!
                        .firstWhere((element) => element.id == "96x96", orElse: () {
                          return recipeData.media!.firstWhere((element) => element.id == recipeData.equipment![index].mediaId).sizes!.first;
                        },).mediaUrl ?? "" 
                        : ""
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 52.h,
                        width: 250.w,
                        child: Text(recipeData.equipment![index].name!,
                          style: textStyle_size_14_bold_color_white(),
                          maxLines: 2,
                          ),
                      ),
                    )
                  ]),
                );
              })),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    ),
  );
}

Widget _startButton(Recipe recipeData){
    return Positioned(
    bottom: 0,
    child: InkWell(
      onTap: () {
        _startPressed(recipeData);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 70.h,
        decoration: BoxDecoration(
        color: colorDeepPurple(),
        ),
        child: Align(
        alignment: Alignment.center,
        child: Text(LocaleUtil.getString(context, LocaleUtil.START)!.toUpperCase(),
            style: textStyle_size_20_bold_color_white()),
        ),
      ),
    ),
  );
}

}
