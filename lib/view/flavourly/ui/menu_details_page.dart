import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/app_bar.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/app_drawer.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/color.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/locale_util.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/text_styles.dart';
import 'package:smarthq_flutter_module/view/flavourly/constants/image_path.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuDetailsPage extends StatefulWidget {
  @override
  _MenuDetailsPageState createState() => _MenuDetailsPageState();
}

class _MenuDetailsPageState extends State<MenuDetailsPage> {
  Map<String, dynamic> menuJsonData = {};
  Future<String> jsonStr = Future.value("");

  @override
  void initState() {
    super.initState();
    loadAndPrint();
  }

  loadAndPrint() async {
    jsonStr = DefaultAssetBundle.of(context).loadString("assets/flavourly/menu_1.json");
    //print(await DefaultAssetBundle.of(context).loadString("assets/menu_1.json"));
    menuJsonData = jsonDecode(await jsonStr);
    print(menuJsonData);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
          title: LocaleUtil.APP_BAR_HEADING,
          leftBtnFunction: () {
            _scaffoldKey.currentState!.openDrawer();
          }).setNavigationAppBar(context: context),
      body: Container(
        width: 500,
        // height: 600,


        child: FutureBuilder(
          future: jsonStr,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            print("FP==>1");
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                print("FP==>2");
                if (menuJsonData.isNotEmpty) {
                  print("FP==>3");
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          // image: NetworkImage("https://files.brillion.geappliances.com/4ba52a86-e4e2-4725-b53d-3d40759a5cd9")
                            image: NetworkImage(menuJsonData['recipe']['media'][0]['sizes'][0]['mediaUrl']),
                            fit: BoxFit.none,
                            alignment: Alignment.topCenter,
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.srcATop))),
                    child: Container(
                      color: Colors.black,
                      margin: EdgeInsets.all(30),
                      child: Utils.componentScreenBodyWithOutButton(context, <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 400,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        // image: NetworkImage("https://files.brillion.geappliances.com/4ba52a86-e4e2-4725-b53d-3d40759a5cd9")
                                        image: NetworkImage(menuJsonData['recipe']['media'][0]['sizes'][0]['mediaUrl']),
                                        fit: BoxFit.fill,
                                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.srcATop)))),
                            Utils.heightSpace(10.h),
                            Container(
                              color: Colors.white12,
                              padding: EdgeInsets.all(15),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  Text(
                                    (menuJsonData['recipe']['label']),
                                    style: textStyle_size_38_bold_color_white(),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      RatingBarIndicator(
                                        rating: 3,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                      Text(
                                        "${Random().nextInt(9999)}",
                                        style: textStyle_size_custom_color_white(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    menuJsonData['recipe']['notes'],
                                    style: textStyle_size_16_bold_color_white(),
                                  ),
                                  Utils.heightSpace(10.h),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Flexible(
                                            child: Container(
                                                margin: EdgeInsets.symmetric(horizontal: 5.w),
                                                padding: EdgeInsets.all(7.h),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: colorDeepPurple(),
                                                ),
                                                child: Utils.componentSmallImage(context, ImagePath.PRINT_ICON))),
                                        Flexible(
                                            child: Container(
                                                margin: EdgeInsets.symmetric(horizontal: 5.w),
                                                padding: EdgeInsets.all(7.h),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: colorDeepPurple(),
                                                ),
                                                child: Utils.componentSmallImage(context, ImagePath.TWEETER_ICON))),
                                        Flexible(
                                            child: Container(
                                                margin: EdgeInsets.symmetric(horizontal: 5.w),
                                                padding: EdgeInsets.all(7.h),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: colorDeepPurple(),
                                                ),
                                                child: Utils.componentSmallImage(context, ImagePath.FB_ICON))),
                                        Flexible(
                                            child: Container(
                                                margin: EdgeInsets.symmetric(horizontal: 5.w),
                                                padding: EdgeInsets.all(7.h),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: colorDeepPurple(),
                                                ),
                                                child: Utils.componentSmallImage(context, ImagePath.MAIL_ICON))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Utils.heightSpace(10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150.w,
                                  padding: EdgeInsets.all(15),
                                  color: Colors.white12,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(child: Utils.componentSmallImage(context, ImagePath.STEPS_LOGO)),
                                        Text(
                                          "${(menuJsonData['recipe']['menuTreeInstructions'][0]['optionTree'][0]['config']['steps']).length} Steps",
                                          style: textStyle_size_18_bold_color_white(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 150.w,
                                  padding: EdgeInsets.all(15),
                                  color: Colors.white12,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(child: Utils.componentSmallImage(context, ImagePath.SERVES_FOR_IMAGE)),
                                        Text(
                                          menuJsonData['recipe']['menuTreeInstructions'][0]['optionTree'][0]['optionValue']['description'],
                                          style: textStyle_size_18_bold_color_white(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Utils.heightSpace(10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150.w,
                                  padding: EdgeInsets.all(15),
                                  color: Colors.white12,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(child: Utils.componentSmallImage(context, ImagePath.INGREDIENTS_LOGO)),
                                        Text(
                                          "${(menuJsonData['recipe']['menuTreeInstructions'][0]['optionTree'][0]['config']['ingredients']).length} Ingredients",
                                          style: textStyle_size_18_bold_color_white(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 150.w,
                                  padding: EdgeInsets.all(15),
                                  color: Colors.white12,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(child: Utils.componentSmallImage(context, ImagePath.TIME_TAKES_IMAGE)),
                                        Text(
                                          "${Utils.durationToString(int.parse(menuJsonData['recipe']['menuTreeInstructions'][0]['optionTree'][0]['config']['readyInMins']))}h",
                                          style: textStyle_size_18_bold_color_white(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Utils.heightSpace(10.h),
                            Container(
                              color: Colors.white12,
                              padding: EdgeInsets.all(15),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  Text(
                                    "Ingredients",
                                    style: textStyle_size_38_bold_color_white(),
                                  ),
                                  Utils.heightSpace(10.h),
                                  Container(
                                    color: Colors.grey,
                                    height: 1.h,
                                  ),
                                  Utils.heightSpace(10.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          menuJsonData['recipe']['ingredientObjects'][0]['name'],
                                          style: textStyle_size_18_bold_color_white(),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${menuJsonData['recipe']['ingredientObjects'][0]['foodMeasure']['valueRange']['gte'].toString().replaceAll(".0", "")} "
                                          "${(menuJsonData['recipe']['ingredientObjects'][0]['foodMeasure']['unitDescription']) == null ? "" : menuJsonData['recipe']['ingredientObjects'][0]['foodMeasure']['unitDescription']}",
                                          style: textStyle_size_18_bold_color_white(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Utils.heightSpace(10.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          menuJsonData['recipe']['ingredientObjects'][1]['name'],
                                          style: textStyle_size_18_bold_color_white(),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${menuJsonData['recipe']['ingredientObjects'][1]['foodMeasure']['valueRange']['gte'].toString().replaceAll(".0", "")} "
                                          "${(menuJsonData['recipe']['ingredientObjects'][1]['foodMeasure']['unitDescription']) == null ? "" : menuJsonData['recipe']['ingredientObjects'][1]['foodMeasure']['unitDescription']}",
                                          style: textStyle_size_18_bold_color_white(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Utils.heightSpace(10.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          menuJsonData['recipe']['ingredientObjects'][2]['name'],
                                          style: textStyle_size_18_bold_color_white(),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${menuJsonData['recipe']['ingredientObjects'][2]['foodMeasure']['valueRange']['gte'].toString().replaceAll(".0", "")} "
                                          "${(menuJsonData['recipe']['ingredientObjects'][2]['foodMeasure']['unitDescription']) == null ? "" : menuJsonData['recipe']['ingredientObjects'][2]['foodMeasure']['unitDescription']}",
                                          style: textStyle_size_18_bold_color_white(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Utils.heightSpace(10.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          menuJsonData['recipe']['ingredientObjects'][3]['name'],
                                          style: textStyle_size_18_bold_color_white(),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${menuJsonData['recipe']['ingredientObjects'][3]['foodMeasure']['valueRange']['gte'].toString()} "
                                          "${(menuJsonData['recipe']['ingredientObjects'][3]['foodMeasure']['unitDescription']) == null ? "" : menuJsonData['recipe']['ingredientObjects'][3]['foodMeasure']['unitDescription']}",
                                          style: textStyle_size_18_bold_color_white(),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Utils.heightSpace(10.h),
                            Container(
                                color: Colors.black,
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.white12,
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Steps",
                                            style: textStyle_size_38_bold_color_white(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Utils.heightSpace(10.h),
                                    Container(
                                      color: Colors.white12,
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "1",
                                            style: textStyle_size_custom_color_purple_bold(fontSize: 38),
                                          ),
                                          Utils.widthSpace(20.w),
                                          Flexible(
                                            child: Text(
                                              menuJsonData['recipe']['steps'][0]['directions'],
                                              style: textStyle_size_18_bold_color_white(),
                                              maxLines: 50,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Utils.heightSpace(10.h),
                                    Container(
                                      color: Colors.white12,
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "2",
                                            style: textStyle_size_38_color_purple(),
                                          ),
                                          Utils.widthSpace(20.w),
                                          Flexible(
                                            child: Text(
                                              menuJsonData['recipe']['steps'][1]['directions'],
                                              style: textStyle_size_18_bold_color_white(),
                                              maxLines: 50,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Utils.heightSpace(10.h),
                                    Container(
                                      color: Colors.white12,
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "3",
                                            style: textStyle_size_38_color_purple(),
                                          ),
                                          Utils.widthSpace(20.w),
                                          Flexible(
                                            child: Text(
                                              menuJsonData['recipe']['steps'][2]['directions'],
                                              style: textStyle_size_18_bold_color_white(),
                                              maxLines: 50,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Utils.heightSpace(10.h),
                                    Container(
                                      color: Colors.white12,
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "4",
                                            style: textStyle_size_38_color_purple(),
                                          ),
                                          Utils.widthSpace(20.w),
                                          Flexible(
                                            child: Text(
                                              menuJsonData['recipe']['steps'][3]['directions'],
                                              style: textStyle_size_18_bold_color_white(),
                                              maxLines: 50,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Utils.heightSpace(10.h),
                                    Container(
                                      color: Colors.white12,
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "5",
                                            style: textStyle_size_38_color_purple(),
                                          ),
                                          Utils.widthSpace(20.w),
                                          Flexible(
                                            child: Text(
                                              menuJsonData['recipe']['steps'][4]['directions'],
                                              style: textStyle_size_18_bold_color_white(),
                                              maxLines: 50,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Utils.heightSpace(10.h),
                                    Container(
                                      color: Colors.white12,
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "6",
                                            style: textStyle_size_38_color_purple(),
                                          ),
                                          Utils.widthSpace(20.w),
                                          Flexible(
                                            child: Text(
                                              menuJsonData['recipe']['steps'][5]['directions'],
                                              style: textStyle_size_18_bold_color_white(),
                                              maxLines: 50,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Utils.heightSpace(10.h),
                            Container(
                              color: Colors.white12,
                              padding: EdgeInsets.all(15),
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  Text(
                                    "Did you enjoy this recipe?",
                                    style: textStyle_size_38_bold_color_white(),
                                  ),
                                  Utils.heightSpace(10.h),
                                  Container(
                                    color: Colors.grey,
                                    height: 2.h,
                                  ),
                                  Utils.heightSpace(15.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Rate the \nrecipe:",
                                        style: textStyle_size_custom_color_purple_bold(fontSize: 25),
                                      ),
                                      RatingBar(
                                        initialRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 25,
                                        ratingWidget: RatingWidget(
                                          full: Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          half: Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          empty: Icon(
                                            Icons.star_outline,
                                            color: Colors.amber,
                                          ),
                                        ),
                                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        },
                                      ),
                                    ],
                                  ),
                                  Utils.heightSpace(15.h),
                                  Utils.componentButton(title: "Write a review", isEnabled: true, toggleEnabled: false),
                                ],
                              ),
                            ),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                          ],
                        ),
                      ]),
                    ),
                  );
                }
              } else {
                print("FP==>4");
              }
            }
            print("FP==>5");
            return Container();
          },
        ),
      ),
      drawer: AppDrawer.commonAppDrawer(scaffoldKey: _scaffoldKey, context: context),
    );
  }

  static var snackBar = SnackBar(
    content: Row(
      children: <Widget>[
        Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        Utils.widthSpace(5.w),
        Text('Rating submitted!', style: textStyle_size_custom_color_white_bold(fontSize: 18)),
      ],
    ),
    backgroundColor: Colors.white12,
  );
}
