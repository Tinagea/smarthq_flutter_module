import 'package:smarthq_flutter_module/environment/build_environment.dart';

abstract class EnvField {
  static const features = [
    EnvFeatureType.none,
    EnvFeatureType.gateway,
    EnvFeatureType.autofill,
  ];
}
