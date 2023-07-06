import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget getSimpleTitleDescription(String description) {
  return Card(
    color: Colors.transparent,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text(description,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}

Widget getSimpleSubDescription(String description) {
  return Card(
    color: Colors.transparent,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text(description,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold)),
    ),
  );
}

Widget getSimpleDescriptionWithCard(String description) {
  return Wrap(
    children: [
      Card(
          color: Colors.grey[900],
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: Text(description,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          )),
    ],
  );
}

Widget getRichTextDescriptionWithCard(RichText description) {
  return Wrap(
    children: [
      Card(
          color: Colors.grey[900],
          child: Center(
            child:
                Padding(padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w), child: description),
          )),
    ],
  );
}