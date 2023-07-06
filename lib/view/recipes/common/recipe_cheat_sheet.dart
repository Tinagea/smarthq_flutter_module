import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/cubits/recipe_details_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';

class RecipeCheatSheet extends StatefulWidget {
  final bool isShown;
  final List<Steps> stepsList;
  final List<IngredientObjects> ingredientsList;
  final String recipeTitle;
  final bool isAutoSense;
  RecipeCheatSheet({required this.isShown, required this.isAutoSense, required this.stepsList, required this.recipeTitle, required this.ingredientsList, Key? key}) : super(key: key);

  @override
  State<RecipeCheatSheet> createState() => _RecipeCheatSheetState();
}

class _RecipeCheatSheetState extends State<RecipeCheatSheet> {
  bool isSteps = true;
  List<IngredientObjects> ingredientsList = [];
  List<Steps> stepsList = [];

  String measurementConversion(IngredientObjects ingredient) {
    String quantityString = "";
    List<String> lteList =
    ingredient.foodMeasure!.valueRange!.lte.toString().split('.');
    late List<String> gteList;
    gteList = ingredient.foodMeasure!.valueRange!.gte.toString().split('.');

    bool isIdenticalLists = listEquals(lteList, gteList);

    if (isIdenticalLists) {
      quantityString =
      "${lteList[0] != "0" ? lteList[0] : ""}${lteList[1] == "5" ? "½" : lteList[1] == "25" ? "¼" : ""}";
    } else {
      quantityString =
      "${lteList[0] != "0" ? lteList[0] : ""}${lteList[1] == "5" ? "½" : ""}-${gteList[0]}${gteList[1] == "5" ? "½" : lteList[1] == "25" ? "¼" : ""}";
    }
    return quantityString;
  }

  String formatString(String value){
    String formattedString = "";

    if(value.toLowerCase() == "gram" ){
      formattedString = "g";
    }else{
      formattedString = value;
    }
    
    return formattedString;
  }


@override
  void initState() {
    super.initState();
    ingredientsList = widget.ingredientsList;
    stepsList = widget.stepsList;
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style:textStyle_size_16_semi_bold_color_black(),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final span = TextSpan(text: widget.isAutoSense 
              ? "${LocaleUtil.getString(context, LocaleUtil.AUTO_SENSE)}-${widget.recipeTitle}" 
              : "${LocaleUtil.getString(context, LocaleUtil.GUIDED)}-${widget.recipeTitle}",
                  style: textStyle_size_20_bold_color_black()
                );
            final painter = TextPainter(text: span)
                    ..textDirection = TextDirection.ltr
                    ..layout(maxWidth: MediaQuery.of(context).size.width);
                  final numLines = painter.computeLineMetrics().length;
            return AnimatedContainer(
              duration: Duration(milliseconds: 250),
              height: numLines > 1 
              ? (widget.isShown ? MediaQuery.of(context).size.height * 0.7 : 0) 
              : (widget.isShown ? MediaQuery.of(context).size.height * 0.6 : 0),
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.w)),
               child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 28.h),
                    child: Text(widget.recipeTitle,
                        style: textStyle_size_20_bold_color_black()),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 21.h),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSteps = true;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              children: [
                                Text(
                                  LocaleUtil.getString(context, LocaleUtil.STEPS)!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: isSteps
                                          ? colorDeepPurple()
                                          : colorSpanishGray()),
                                ),
                                Divider(
                                  thickness: 1.h,
                                  color: isSteps
                                      ? colorDeepPurple()
                                      : colorSpanishGray(),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSteps = false;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              children: [
                                Text(
                                  LocaleUtil.getString(context, LocaleUtil.INGREDIENTS)!,
                                  style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: !isSteps
                                      ? colorDeepPurple()
                                      : colorSpanishGray()),
                                ),
                                Divider(
                                  thickness: 1.h,
                                  color: !isSteps
                                      ? colorDeepPurple()
                                      : colorSpanishGray(),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 23.h, left: 20.w),
                    child: Text(
                      widget.isAutoSense 
                      ? "${LocaleUtil.getString(context, LocaleUtil.AUTO_SENSE)}-${widget.recipeTitle}" 
                      : "${LocaleUtil.getString(context, LocaleUtil.GUIDED)}-${widget.recipeTitle}",
                      style: textStyle_size_18_bold_color_black(),
                    ),
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final span = TextSpan(text: widget.isAutoSense 
                      ? "${LocaleUtil.getString(context, LocaleUtil.AUTO_SENSE)}-${widget.recipeTitle}" 
                      : "${LocaleUtil.getString(context, LocaleUtil.GUIDED)}-${widget.recipeTitle}", 
                      style: textStyle_size_20_bold_color_black());
                    final painter = TextPainter(text: span)
                    ..textDirection = TextDirection.ltr
                    ..layout(maxWidth: MediaQuery.of(context).size.width);
                    final numLines = painter.computeLineMetrics().length;

                    return SizedBox(
                    height: numLines > 1 ? MediaQuery.of(context).size.height * 0.367 : MediaQuery.of(context).size.height * 0.315,
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 8.h),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: isSteps ? stepsList.length : ingredientsList.length,
                        itemBuilder: ((context, index) {
                          return isSteps
                              ? Padding(
                                  padding: EdgeInsets.only(top: 10.h, left: 22.w, right: 22.w),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(15.w)),
                                        border: Border(
                                          top: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                          left: BorderSide(color: Colors.black),
                                          right: BorderSide(color: Colors.black),
                                        )),
                                    child: Padding(
                                        padding: EdgeInsets.all(18.w),
                                        child: Text(stepsList[index].label ?? LocaleUtil.getString(context, LocaleUtil.UNDEFINED)!.toUpperCase(),
                                        )),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(top: 10.h, left: 22.w, right: 22.w),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(15.w)),
                                        border: Border(
                                          top: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                          left: BorderSide(color: Colors.black),
                                          right: BorderSide(color: Colors.black),
                                        )),
                                    child: Padding(
                                        padding: EdgeInsets.all(4.w),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          
                                          children: [
                                            Container(
                                              height: 60.h,
                                              width: 180.w,
                                              padding: EdgeInsets.only(left:10.w),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(ingredientsList[index].name ?? "UNDEFINED"))),                                             
                                            Spacer(),
                                            Container(
                                              height: 60.h,
                                              width: 110.w,
                                              padding: EdgeInsets.only(right: 10.w),
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: ingredientsList[index].alternateMeasure != null? RichText(
                                                  textAlign: TextAlign.right,
                                                  text: TextSpan(
                                                    text: "${BlocProvider.of<RecipeDetailsCubit>(context).formatQuantityString(ingredientsList[index])}\n",
                                                    style: textStyle_size_16_semi_bold_color_black(),
                                                    children: [
                                                      TextSpan(
                                                        text: "${ingredientsList[index].alternateMeasure ?? ""}",
                                                        style: textStyle_size_12_color_grey()
                                                      )                                        
                                                  ],
                                                )
                                                ) : Text("${BlocProvider.of<RecipeDetailsCubit>(context).formatQuantityString(ingredientsList[index])}",
                                                 style: textStyle_size_16_semi_bold_color_black() ,
                                              ),
                                            )
                                           )
                                          ],
                                        )),
                                  ),
                                );
                        })),
                  );
                  },
                )
              ]),
            ),
          );}
        ),
      ),
    );
  }
}
