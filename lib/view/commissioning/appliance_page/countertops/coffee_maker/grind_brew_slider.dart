import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';

class GrindBrewSlider extends StatefulWidget {
  final int index;
  const GrindBrewSlider(this.index);

  @override
  _GrindBrewSliderState createState() => _GrindBrewSliderState();
}

class _GrindBrewSliderState extends State<GrindBrewSlider> {
  @override
  Widget build(BuildContext context) {
    return Component.componentMainImage(
        context, sliderImageUrl(widget.index));
  }

  String sliderImageUrl(int index) {
    String str = "";
    switch (index) {
      case 0:
        str = ImagePath.GRIND_BREW_IMAGE1;
        break;
      case 1:
        str = ImagePath.GRIND_BREW_IMAGE2;
        break;
    }
    return str;
  }
}
