

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


List<TextSpan> getTextSpanList(String str, String splitChar, TextStyle style){
    // create a list of strings of the text before and after the ⅓
    List<String> splitString = str.split("⅓");
    // create a list of widgets TextSpan
    List<TextSpan> textSpanList = [];
    // add the text before the ⅓ to the list
    textSpanList.add(TextSpan(text: splitString[0], style: style));
    // add the ⅓ to the list
    textSpanList.add(TextSpan(text: "⅓", style: style.copyWith(fontFamily: 'Roboto')));
    // add the text after the ⅓ to the list
    textSpanList.add(TextSpan(text: splitString[1], style: style));
  
    return textSpanList;
}

Widget unsupportedCharacterHandler(String str, {required TextStyle style}) {
  if(str.contains("⅓")){   
    return RichText(
      text: TextSpan(
        children: getTextSpanList(str, "⅓", style),
      ),
      textAlign: TextAlign.left,
    );
  }
  return Text(str, style: style, textAlign: TextAlign.left);
}

Widget unsupportedCharacterHandlerAutoSized(String str, {required TextStyle style, required int maxLines}) {
  if(str.contains("⅓")){
    return AutoSizeText.rich(
      TextSpan(
        children: getTextSpanList(str, "⅓", style),      
      ),  
      maxLines: maxLines,    
      textAlign: TextAlign.left,
    );
  }
  return AutoSizeText(str, style: style, textAlign: TextAlign.left, maxLines: maxLines);
}
