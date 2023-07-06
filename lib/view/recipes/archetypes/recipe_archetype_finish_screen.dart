import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/cubits/stand_mixer_cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/recipes/common/full_width_button.dart';
import 'package:smarthq_flutter_module/view/recipes/navigator/recipe_navigator.dart';

/// TODO: Interapt - the class should not be immutable if it's using in the way
/// This class (or a class that this class inherits from) is marked as '@immutable',
/// but one or more of its instance fields aren't final
// ignore: must_be_immutable
class RecipeFinishScreen extends StatefulWidget {
  Recipe recipe;
  int stepIndex;
  List<bool> indexTracker;
  
  RecipeFinishScreen({required this.recipe, required this.stepIndex, required this.indexTracker});

  @override
  State<RecipeFinishScreen> createState() => _RecipeFinishScreenState();
}

class _RecipeFinishScreenState extends State<RecipeFinishScreen> with WidgetsBindingObserver {
  late RecipeStepsCubit recipeStepsCubit;

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (BlocProvider.of<RecipeCubit>(context).state is RecipeCleared){
            BlocProvider.of<RecipeCubit>(context).resetState();
            Future.delayed(Duration.zero, () {
              Navigator.popUntil(context, (route) => route.isFirst);
            });
        }  
    }
  }

  void exitToDetailsPage(BuildContext context, String applianceTypeForRequest){
    String userId = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).userId;
    bool isAuto = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).isAuto;
    bool isArthur = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).isArthur;
    BlocProvider.of<RecipeStepsCubit>(context).advanceCloudIndex(widget.stepIndex, context, applianceTypeForRequest, isFinishedOrQuit: true);
    BlocProvider.of<StandMixerControlCubit>(context).clearRecipeStatus();
    BlocProvider.of<RecipeStepsCubit>(context).clearRecipeExecutionId();
    Navigator.of(context).pushReplacementNamed(Routes.RECIPE_DETAILS_PAGE, arguments: RecipeArguments(widget.recipe.id!, userId, isAuto, isArthur));
  }

  finishRecipe(String applianceString){
    bool isArthur = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).isArthur;
    BlocProvider.of<RecipeStepsCubit>(context).advanceCloudIndex(widget.stepIndex, context, isFinishedOrQuit: true, applianceString);
    BlocProvider.of<RecipeStepsCubit>(context).clearRecipeExecutionId();
    Navigator.pushReplacementNamed(context, Routes.RECIPE_DICOVER_PAGE, arguments: RecipeFilterArguments(domains: widget.recipe.domains, isArthur: isArthur));
  }

  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;
    String applianceString = BlocProvider.of<ApplianceCubit>(context).getApplianceTypeForRequest();
    var mediaId = widget.recipe.media!.where((element) => element.id == widget.recipe.mediaId);
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleUtil.getString(context, LocaleUtil.RECIPE_COMPLETE)?.toUpperCase() ?? "", style: textStyle_size_16_bold_color_white_wide(),),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.white,),
              onPressed: () {
                exitToDetailsPage(context, applianceString);
              },
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<RecipeStepsCubit, RecipeStepsState>(
          builder: (context, state) {
            if(state is ControlStep){
              return FocusDetector(
                onFocusGained: () {
                  BlocProvider.of<NativeCubit>(context).showTopBar(false);
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 245.h,
                          width: MediaQuery.of(context).size.width,
                          child: mediaId.isNotEmpty? Image(
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return Image(image: AssetImage(ImagePath.PLACEHOLDER), fit: BoxFit.cover,);
                              },
                              image: NetworkImage(mediaId.first.sizes![0].mediaUrl!),
                              fit: BoxFit.cover): Image(image: AssetImage(ImagePath.PLACEHOLDER), fit: BoxFit.cover,),
                        ),
                        Container(
                          height: 250.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.5),
                                  Colors.black,
                                ],
                                stops: [
                                  0.5,
                                  1.0
                                ],
                              )
                          ),),
                      ],
                    ),
                    Text("${widget.recipe.label}", style: textStyle_size_20_bold_color_white(), textAlign: TextAlign.center,),
                    SizedBox(height: 150.h,),
                    Text(LocaleUtil.getString(context, LocaleUtil.WELL_DONE_CHEF)!, style: textStyle_bold_size_32_color_white(),),
                    Text(LocaleUtil.getString(context, LocaleUtil.ENJOY_YOUR_WORK)!, style: textStyle_size_14_color_white(),),
                    Spacer(),
                    FullWidthButton(text: LocaleUtil.getString(context, LocaleUtil.FINISH)!.toUpperCase(), callback: () {finishRecipe(applianceString);})
                  ],
                ),
              );
            }
            return Container();
          },
        )
    );
  }
}
