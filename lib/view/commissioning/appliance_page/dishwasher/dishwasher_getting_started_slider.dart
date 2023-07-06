import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';

class DishwasherSlider extends StatefulWidget {
  final int index;
  const DishwasherSlider(this.index);

  @override
  _DishwasherSliderState createState() => _DishwasherSliderState();
}

class _DishwasherSliderState extends State<DishwasherSlider> {
  @override
  Widget build(BuildContext context) {
    return Component.componentMainImage(context, sliderImageUrl(widget.index));
  }

  String sliderImageUrl(int index) {
    String str = "";
    switch (index) {
      case 0:
        str = ImagePath.DISHWASHER_SLIDER_1;
        break;
      case 1:
        str = ImagePath.DISHWASHER_SLIDER_2;
        break;
      case 2:
        str = ImagePath.DISHWASHER_SLIDER_3;
        break;
      case 3:
        str = ImagePath.DISHWASHER_SLIDER_4;
        break;
      case 4:
        str = ImagePath.DISHWASHER_SLIDER_5;
        break;
      case 5:
        str = ImagePath.DISHWASHER_SLIDER_6;
        break;
    }
    return str;
  }
}
