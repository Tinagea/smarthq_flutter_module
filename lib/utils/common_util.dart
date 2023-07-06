

abstract class CommonUtil {

  static bool isEmptyString(String? param) {
    return param == null || param.isEmpty;
  }

  static bool isEmptyList(List<dynamic>? param) {
    return param == null || param.isEmpty;
  }
}
