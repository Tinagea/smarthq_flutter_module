import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';

class ShortcutPicker extends StatelessWidget {
  final List<String>? items;
  final String? selectedItem;
  final dynamic Function(String value) onValueSelected;
  const ShortcutPicker({Key? key, required this.items, this.selectedItem, required this.onValueSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String pickerData = jsonEncode(items);
    List<int> indexes = [];
    if (selectedItem != null && (selectedItem?.length ?? 0) > 0) {
      final index = items?.indexOf(selectedItem!);
      if (index != null) {
        indexes = [index];
      }
    }

    return Picker(
        adapter: PickerDataAdapter<String>(pickerData: JsonDecoder().convert(pickerData)),
        changeToFirst: true,
        height: 130,
        itemExtent: 50,
        hideHeader: true,
        selecteds: indexes,
        textStyle: textStyle_size_16_color_white(),
        selectedTextStyle: textStyle_size_18_bold_color_white(),
        backgroundColor: colorDeepDarkCharcoal(),
        onSelect: (Picker picker, int index, List value){
          onValueSelected(picker.getSelectedValues().first);
        }
    ).makePicker();
  }
}