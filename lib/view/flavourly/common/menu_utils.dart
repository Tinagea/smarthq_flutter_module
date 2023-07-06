import 'package:smarthq_flutter_module/view/flavourly/podo/menu_header.dart';
import 'dart:ui';

class MenuUtils {
  static MenuHeader _getMenuHeader({String title = "", String subTitle = "", String image = "", String menuClickFunction=""
    ,double rating=-1,String timeTaken="",String serves=""}) {
    return MenuHeader(title, subTitle ?? "", image ?? "",menuClickFunction??"",rating,timeTaken,serves);
  }

  static List<MenuHeader> prepareAndGetMenuHeaders({required List<String> titleList, List<String>? subTitleList, List<String>? imageList
    , List<String>? menuClickFunctions, List<double>? ratingList, List<String>? timeTakenList, List<String>? servesList}) {
    List<MenuHeader> menuHeaders = [];
    for (String title in titleList) {
      int index = titleList.indexOf(title);
      menuHeaders.add(_getMenuHeader(title: title
          , subTitle: subTitleList != null && subTitleList.length > index ? subTitleList[index] : ""
          , image: imageList != null && imageList.length > index ? imageList[index] : ""
          , menuClickFunction: menuClickFunctions != null && menuClickFunctions.length > index ? menuClickFunctions[index] : ""
          , rating: ratingList != null && ratingList.length > index ? ratingList[index] : -1
          , timeTaken: timeTakenList != null && timeTakenList.length > index ? timeTakenList[index] : ""
          , serves: servesList != null && servesList.length > index ? servesList[index] : ""));
    }

    return menuHeaders;
  }
}
