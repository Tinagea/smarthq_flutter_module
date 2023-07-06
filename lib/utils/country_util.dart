/// Class containing all countries used in the application. Please take care to
/// add any new countries to the respective country list
/// ([CountryUtil.allGeCountries] and/or [CountryUtil.allFnpCountries]).
class CountryUtil {
  CountryUtil._();

  /// All available countries
  static const List<String> allCountries = [
    ar,
    at,
    au,
    be,
    bg,
    ca,
    ch,
    cl,
    co,
    cr,
    cy,
    de,
    do_,
    dk,
    ec,
    ee,
    es,
    eu,
    fi,
    fr,
    gb,
    gr,
    gt,
    hn,
    ie,
    il,
    it,
    lb,
    lu,
    mx,
    nh,
    ni,
    nl,
    no,
    nz,
    pa,
    pe,
    pl,
    pt,
    se,
    sg,
    sv,
    tr,
    uk,
    us
  ];

  /// All countries GE is available in
  static const List<String> allGeCountries = [
    ar,
    bg,
    ca,
    ch,
    cl,
    co,
    cr,
    cy,
    do_,
    ec,
    ee,
    gr,
    gt,
    hn,
    il,
    lb,
    mx,
    nh,
    ni,
    no,
    pa,
    pe,
    pt,
    sv,
    tr,
    us,
  ];

  /// All countries F&P is available in
  static const List<String> allFnpCountries = [
    at,
    au,
    be,
    ca,
    dk,
    de,
    es,
    eu,
    fi,
    fr,
    gb,
    ie,
    it,
    lu,
    nz,
    nl,
    pl,
    se,
    sg,
    us,
    uk,
  ];

  /// Get all countries that only have F&P products
  static List<String> fnpOnlyCountries() {
    return allFnpCountries
        .toSet()
        .difference(allGeCountries.toSet())
        .toList(growable: false);
  }

  static List<String> allExcept(List<String> countries) {
    return allCountries.toSet().difference(countries.toSet()).toList(growable: false);
  }

  // ------------- Asia -------------
  /// Singapore
  static const String sg = "SG";

  /// Israel
  static const String il = "IL";

  /// Lebanon
  static const String lb = "LB";


  // ------------- Australia -------------
  /// Australia
  static const String au = "AU";

  /// New Zealand
  static const String nz = "NZ";


  // ------------- Europe -------------
  /// Austria
  static const String at = "AT";

  /// Belgium
  static const String be = "BE";

  /// Bulgaria
  static const String bg = "BG";

  /// Switzerland
  static const String ch = "CH";

  /// Cyprus
  static const String cy = "CY";

  /// Germany
  static const String de = "DE";

  /// Denmark
  static const String dk = "DK";

  /// Estonia
  static const String ee = "EE";

  /// European Union
  static const String eu = "EU";

  /// Spain
  static const String es = "ES";

  /// Finland
  static const String fi = "FI";

  /// France
  static const String fr = "FR";

  /// United Kingdom of Great Britain
  static const String gb = "GB";

  /// Greece
  static const String gr = "GR";

  /// Ireland
  static const String ie = "IE";

  /// Italy
  static const String it = "IT";

  /// Luxembourg
  static const String lu = "LU";

  /// Netherlands
  static const String nl = "NL";

  /// Norway
  static const String no = "NO";

  /// Poland
  static const String pl = "PL";

  /// Portugal
  static const String pt = "PT";

  /// Sweden
  static const String se = "SE";

  /// Turkey
  static const String tr = "TR";

  ///United Kingdom
  static const String uk = "UK";

  // ------------- North America -------------
  /// Canada
  static const String ca = "CA";

  /// The United States of America
  static const String us = "US";

  // ------------- Latin America -------------
  /// Costa Rica
  static const String cr = "CR";

  /// Mexico
  static const String mx = "MX";

  // ------------- South America -------------
  /// Argentina
  static const String ar = "AR";

  /// Chile
  static const String cl = "CL";

  /// Colombia
  static const String co = "CO";

  /// Ecuador
  static const String ec = "EC";

  /// Peru
  static const String pe = "PE";

  // ------------- Central America -------------
  /// Guatemala
  static const String gt = "GT";

  /// Honduras
  static const String hn = "HN";

  /// Nicaragua
  static const String ni = "NI";

  /// Panama
  static const String pa = "PA";

  /// El Salvador
  static const String sv = "SV";

  // ------------- Caribbean -------------
  /// Dominican Republic
  static const String do_ = "DO";

  // ------------- Others -------------
  static const String nh = "NH";

}
