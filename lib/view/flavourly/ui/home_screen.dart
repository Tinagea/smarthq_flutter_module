import 'dart:async';
import 'dart:math';

import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/app_bar.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/app_drawer.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/locale_util.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/menu_utils.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/text_styles.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/utils.dart';
import 'package:smarthq_flutter_module/view/flavourly/constants/image_path.dart';
import 'package:smarthq_flutter_module/view/flavourly/podo/menu_header.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<MenuHeader> topMenuHeaders = [];
  List<MenuHeader> bottomMenuHeaders = [];

  @override
  void initState() {
    super.initState();
    List<String> topListViewTitles = ["Universal generator", "Coming soon"];
    List<String> topListViewSubTitles = ["You won't believe what recipes you'll be able to create with this generator!", "Please come back soon! We are cooking up some new generators!"];
    List<String> topListViewImages = [ImagePath.UNIVERSAL_GENERATOR_IMAGE, ImagePath.COMING_SOON_IMAGE];
    List<String> topMenuClickFunc = [Routes.FLAVOURLY_UNIVERSAL_GENERATOR];

    List<String> bottomMenuClickFunc = [Routes.FLAVOURLY_MENU_DETAILS_PAGE];

    List<String> bottomListViewItems = ["Crispy Baked Apple Chips", "Orange Honey Fizz", "Chocolat Chantilly Crepes", "Tuna Veggie Tacos", "Italian Garden Salad", "Pistachio and Orange Blossom Biscotti", "Huevos a la Basque", "Garlic Butter Potatoes", "Peppered Pork Cutlets with Radish Salad", "Seaweed-Wrapped Tuna Sushi Roll"];

    List<String> bottomListSubTitles = [
      "Crispy baked apple chips make a healthy and delicious snack or appetizer. These chips are loaded with flavor and crunch, and perfect for munching on at any time of the day.",
      "A refreshing and bubbly non-alcoholic beverage to serve at parties. Fresh squeezed orange and lime juice is combined with honey and pure water to create a natural and healthy sweetness. The addition of sparkling club soda adds a fun and fizzy element to this delicious citrus drink.",
      "These Chocolat Chantilly Crepes are a new twist to the classic French crepes. They are filled with whipped cream and drizzled in a decadent chocolate sauce. They are perfect for a special breakfast or a lovely dessert.",
      "Experience the flavors of Mexico with these tasty tuna tacos. Soft taco shells filled with peppy tuna, a rainbow of vegetables and a chipotle mayo for a smoky finish.",
      "A refreshing and satisfying salad with a mix of crisp greens, juicy cherry tomatoes, and crunchy croutons. Topped with a classic and tangy Italian dressing, this Italian Garden Salad is an easy and delicious salad that can be enjoyed as a light lunch or a hearty side dish.",
      "This recipe for Pistachio and Orange Blossom Biscotti is a perfect addition to your afternoon tea. The biscotti are crispy from outside, and a bit chewy from inside with a delicate hint of orange blossom. Crunchy pistachios give them some nutty flavor and texture.",
      "Huevos a la Basque is a Latin spin on the traditional Basque dish of Pipérade, which is a bell pepper and onion stew made with a range of spices. To make Huevos a la Basque, Pipérade is cooked and eggs are gently simmered into it. The result is a rich and flavorful breakfast dish that is sure to impress.",
      "Crispy on the outside, fluffy on the inside, these garlic butter roasted potatoes are perfectly seasoned side dish. They are easy to make and pair well with any main dish!",
      "Tender and juicy pork cutlets are seasoned with pepper and seared to perfection. Served with a refreshing salad made with thinly sliced radishes, greens and a tangy vinaigrette, this dish is perfect for any day of the week or special occasions.",
      "This sushi roll has a moist and chewy texture from the tender tuna and creamy avocado. The seaweed and sushi rice help to create the perfect balance for a heavenly flavor."
    ];

    List<String> bottomListViewImages =
       ["https://files.brillion.geappliances.com/4ba52a86-e4e2-4725-b53d-3d40759a5cd9"
      , "https://files.brillion.geappliances.com/c3867c32-6990-48ef-89f8-c5b35f38091c"
      , "https://files.brillion.geappliances.com/e6805277-9945-45b1-82ef-b884fa6952f7"
      , "https://files.brillion.geappliances.com/90cba316-b10c-452f-be5b-37dfa9c3175f"
      , "https://files.brillion.geappliances.com/a69d2211-1ec2-4631-916f-2bcc9f9d5965"
      , "https://files.brillion.geappliances.com/ca91013d-2597-4258-b7c3-3e2b93817171"
      , "https://files.brillion.geappliances.com/1188de86-cded-49e2-9778-9ca69537a77b"
      , "https://files.brillion.geappliances.com/6695db59-4b3a-45de-ab58-2e2a47a40919"
      , "https://files.brillion.geappliances.com/5547ae0f-bd1b-46bf-8a5b-1deba29d6335"
      , "https://files.brillion.geappliances.com/52c9782d-b63e-451e-a169-b2f46264c845"];

    List<double> bottomListViewRatings = [4, 4, 4.5, 5, 4.5, 5, 4.75, 4, 4.2, 4];

    List<String> bottomListViewTimeTakes = ["1h", "10m", "45m", "30m", "20m", "3h30m", "45m", "50m", "40m", "45m"];

    List<String> bottomListViewServing = ["4 Servings", "4 Servings", "4 Servings", "4 Servings", "4 Servings", "24 Servings", "4 Servings", "6 Servings", "4 Servings", "4 Servings"];

    topMenuHeaders = MenuUtils.prepareAndGetMenuHeaders(titleList: topListViewTitles, subTitleList: topListViewSubTitles, imageList: topListViewImages, menuClickFunctions: topMenuClickFunc);
    bottomMenuHeaders = MenuUtils.prepareAndGetMenuHeaders(titleList: bottomListViewItems,
        subTitleList: bottomListSubTitles,
        imageList: bottomListViewImages,
        ratingList: bottomListViewRatings,
        timeTakenList: bottomListViewTimeTakes,
        servesList: bottomListViewServing,
    menuClickFunctions: bottomMenuClickFunc);
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
          Utils.heightSpace(30.h),
          Text("What are you", style: textStyle_size_38_color_purple()),
          Text("craving?", style: textStyle_size_38_bold_color_white()),
          Utils.heightSpace(30.h),
          _getHorizontalListView(listViewHeaders: topMenuHeaders),
          Utils.heightSpace(60.h),
          Text("Popular recipes", style: textStyle_size_38_bold_color_white()),
          _getHorizontalListView(listViewHeaders: bottomMenuHeaders),
        ]),
      ),
      drawer: AppDrawer.commonAppDrawer(scaffoldKey: _scaffoldKey,context:context),
    );
  }

  bool validateListData({List<MenuHeader>? listViewHeaders, int index = -1}) {
    return listViewHeaders != null && listViewHeaders.length > index;
  }

  bool validateData({required MenuHeader menuHeader}) {
    return menuHeader.image != "";
  }

  ImageProvider getImage({List<MenuHeader>? listViewHeaders, int index = -1}) {
    if (validateListData(listViewHeaders: listViewHeaders) && listViewHeaders![index].image != "") {
      if (listViewHeaders[index].image.startsWith("https:")) {
        return NetworkImage(listViewHeaders[index].image);
      } else {
        return AssetImage(listViewHeaders[index].image);
      }
    }
    return AssetImage(ImagePath.PLACEHOLDER_IMAGE);
  }

  _getHorizontalListView({List<MenuHeader>? listViewHeaders}) {
    return Container(
      margin: EdgeInsets.all(5.0),
      height: 295.0,
      width: 333.0,
      child: ListView.builder(
        //physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: listViewHeaders?.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              listViewHeaders != null && listViewHeaders.length > index && listViewHeaders[index].menuClickFunction != "" ? Navigator.of(context).pushNamed(listViewHeaders[index].menuClickFunction) : () {};
            },
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  //image:NetworkImage(listViewHeaders[index].image),
                  image: getImage(listViewHeaders: listViewHeaders, index: index),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.srcATop),
                ),
              ),
              width: 200.w,
              height: 10,
              child: Container(
                margin: EdgeInsets.all(10),
                alignment: AlignmentDirectional.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      listViewHeaders != null ? listViewHeaders[index].title : "dummy text",
                      style: textStyle_size_custom_color_white_bold(fontSize: 25),
                    ),
                    validateListData(listViewHeaders: listViewHeaders, index: index) && listViewHeaders![index].rating > -1
                        ? Container(
                      margin: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RatingBarIndicator(
                            rating: listViewHeaders[index].rating,
                            itemBuilder: (context, index) =>
                                Icon(
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
                    )
                        : Container(),
                    Utils.heightSpace(10.h),
                    Text(
                      listViewHeaders != null && listViewHeaders[index].subTitle != "" ? listViewHeaders[index].subTitle : "",
                      style: textStyle_size_custom_color_white_bold(fontSize: 15),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    validateListData(listViewHeaders: listViewHeaders, index: index) && listViewHeaders![index].timeTaken != "" ?
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Utils.componentSmallImage(context, ImagePath.TIME_TAKES_IMAGE),
                          Text(
                            listViewHeaders[index].timeTaken,
                            style: textStyle_size_custom_color_white_bold(fontSize: 15),
                          ),
                        ],
                      ),
                    ) : Container(),
                    validateListData(listViewHeaders: listViewHeaders, index: index) && listViewHeaders![index].serves != "" ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Utils.componentSmallImage(context, ImagePath.SERVES_FOR_IMAGE),
                        Text(
                          listViewHeaders[index].serves,
                          style: textStyle_size_custom_color_white_bold(fontSize: 15),
                        ),
                      ],
                    ) : Container(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
