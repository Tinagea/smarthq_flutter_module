import 'dart:async';

import 'package:smarthq_flutter_module/view/flavourly/common/app_bar.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/app_drawer.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/locale_util.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/menu_utils.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/text_styles.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../common/color.dart';

class UniversalGenerator extends StatefulWidget {
  @override
  _UniversalGenerator createState() => _UniversalGenerator();
}

class _UniversalGenerator extends State<UniversalGenerator> {

  late FocusNode _focusNode;
  late FocusNode _focusNode1;
  late TextEditingController _textEditingController;
  late TextEditingController _textEditingController1;
  late TextEditingController _infoTextEditingController;
  late TextEditingController _infoTextEditingController1;

  String recipeHeader="";
  String cusineHeader="";
  String ingredientsTextTitle="";
  String ingredientsTextSubTitle="";
  String ingredientsHint="";
  String dietaryHeader="";
  String otherInfoTitle="";
  String otherInfoHint="";
  List<String> receipeTypeList = [];
  List<String> cusineTypeList = [];
  List<String> dietaryTypeList = [];
  List<String> ingredientsList = [];
  int recipeSelectedIndex = -1;
  int cusineSelectedIndex = -1;
  List<int> dietarySelectedIndexes = [];

  @override
  void initState() {
    super.initState();

    _focusNode=FocusNode();
    _focusNode1=FocusNode();
    _textEditingController=TextEditingController();
    _textEditingController1=TextEditingController();
    _infoTextEditingController=TextEditingController(text: "0 Items");
    _infoTextEditingController1=TextEditingController(text: "0 Characters");

    recipeHeader="What type of recipe do you want";
    cusineHeader="What type of cuisine do you want";
    ingredientsTextTitle="What ingredients should be included?";
    ingredientsTextSubTitle="Separate each ingredient with a comma";
    ingredientsHint="Enter your ingredients here...";
    dietaryHeader="Do you have any dietary preferences?";
    otherInfoTitle="Is there anything else we should know?";
    otherInfoHint="Enter any additional request here...";

    receipeTypeList = ["Appetizer", "Baked Goods","Beverage","Breakfast","Dessert","Main Course","Pizza","Salad","Sauce","Side Dish"];
    cusineTypeList = ["American", "Asian","French","Indian","Mediterranean","Latin","Mexican"];
    dietaryTypeList = ["Dairy Free", "Egg Free","Gluten Free","Keto","Low Fat","Paleo","Peanut Free","Pescatarian","Tree Nut Free","Vegan","Vegetarian"];
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _focusNode1.dispose();
    _textEditingController.dispose();
    _infoTextEditingController.dispose();
    _textEditingController1.dispose();
    _infoTextEditingController1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black87,
      appBar: CommonAppBar(
          title: LocaleUtil.APP_BAR_HEADING,
          leftBtnFunction: () {
            _scaffoldKey.currentState!.openDrawer();
          }).setNavigationAppBar(context: context),
      body: Container(
        margin: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 10.h),
        child: Utils.componentScreenBodyWithOutButton(context, <Widget>[
          Utils.heightSpace(20.h),
          Text("Universal", style: textStyle_size_custom_color_white_bold(fontSize: 38)),
          Utils.heightSpace(30.h),
          Text("Generator?", style: textStyle_size_38_color_purple()),
          Utils.heightSpace(10.h),
          _generateListContainer(headerText: recipeHeader,listViewItems: receipeTypeList),
          _generateListContainer(headerText: cusineHeader,listViewItems: cusineTypeList),
          _generateTextAreaContainer(title: ingredientsTextTitle,subtitle: ingredientsTextSubTitle
              ,hintText: ingredientsHint,mainTextEditingController:_textEditingController,
              secondaryTextEditingController:_infoTextEditingController,focusNode:_focusNode,isCommaSeparated: true),
          _generateListContainer(headerText: dietaryHeader,listViewItems: dietaryTypeList),
          _generateTextAreaContainer(title: otherInfoTitle
              ,hintText: otherInfoHint,mainTextEditingController:_textEditingController1,
              secondaryTextEditingController:_infoTextEditingController1,focusNode:_focusNode1),
          Utils.heightSpace(30.h),
          Utils.componentButton(title: "Generate Recipe",isEnabled: true,toggleEnabled: false),
          Utils.heightSpace(60.h),
        ],),
      ),
      drawer: AppDrawer.commonAppDrawer(scaffoldKey: _scaffoldKey, context: context),
    );
  }

  _generateTextAreaContainer({required String title,String subtitle="",String hintText=""
    ,required TextEditingController mainTextEditingController,required TextEditingController secondaryTextEditingController
    ,required FocusNode focusNode,bool isCommaSeparated=false}){
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white12),
      child: Padding(
        padding:  EdgeInsets.fromLTRB(25.w,8.0.h,25.w,8.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: textStyle_size_custom_color_white(fontSize: 20),
            ),
            Text(
              subtitle,
              style: textStyle_size_custom_color_white(fontSize: 15),
            ),
            Utils.heightSpace(5.h),
            Container(color: Colors.grey,height: 1.h,),
            Utils.heightSpace(10.h),
            TextField(
              focusNode: focusNode,
            controller: mainTextEditingController,
            autofocus: false,
            maxLines: 5,
            cursorColor: Colors.white,
            style: textStyle_size_18_bold_color_white(),
            decoration: InputDecoration(
              filled: true,
                fillColor: Colors.white12
                ,hintText: hintText
                ,hintStyle: textStyle_size_custom_color_white(fontSize: 15)
                ,focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorDeepPurple())
            )),
            onChanged: (text){
              if (isCommaSeparated) {
                secondaryTextEditingController.text = processAndGetItemCount(text: text);
              }else{
                secondaryTextEditingController.text=processAndGetCharacterCount(text: text);
              }
            },
            ),
            Utils.heightSpace(10.h),
            Container(color: Colors.grey,height: 1.h,),
            Utils.heightSpace(10.h),
            TextField(controller: secondaryTextEditingController, style:textStyle_size_custom_color_white(fontSize: 10),enabled: false),
          ],
        ),
      ),
    );
  }

  _generateListContainer({String headerText="",List<String>? listViewItems,bool isMultiselect=false}){
   return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
          Utils.heightSpace(10.h),
          Text(
            headerText,
            style: textStyle_size_custom_color_white(fontSize: 20),
          ),
          Utils.heightSpace(5.h),
          Container(color: Colors.grey,height: 1.h,),
          _generatePreferenceList(listViewHeaders: listViewItems),
        ]),
      ),
    );
  }

  _generatePreferenceList({List<String>? listViewHeaders,bool isMultiselect=false}) {
    return Container(
        margin: EdgeInsets.all(5.0),
        width: 333.0,
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: listViewHeaders?.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                    child: Utils.componentButton(title: listViewHeaders![index],onTapButton: (){

                    })),
              );
            }
            )
    );
  }

  String processAndGetCharacterCount({required String text}) {
    if (text.isNotEmpty) {
      return "${text.length} Characters";
    }
    return "0 Characters";
  }

  String processAndGetItemCount({required String text}) {
    if (text.isNotEmpty) {
      if (text.contains(",")) {
        List<String> items = text.split(",");
        for (var element in items) {
          _addIngredientsToList(item: element);
        }
        int len = items.length;
        String lastItem = items[len - 1];
        if (lastItem.isNotEmpty) {
          return "$len Items";
        } else {
          return "${len - 1} Items";
        }
      } else {
        _addIngredientsToList(item: text);
        return "1 Items";
      }
    } else {
      return "0 Items";
    }
  }

  _addIngredientsToList({required String item}){
    if(item.isNotEmpty){
      if(!ingredientsList.contains(item)){
        ingredientsList.add(item);
      }
    }
  }
}
