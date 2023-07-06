///### BRAND_ID
///-  Name: **A unique identifier used to specify the Brand of the appliance.**
///-  Data Length: **1 byte**
///-  ----------------------
class ERD0x0099 {
  String address = "0x0099";
  final String rawValue;
  var brandID;
  var brandName;
  ERD0x0099(this.rawValue) {
    if (this.rawValue.length < 1) {
      throw new ArgumentError('There is no data recieved from 0x0099');
    }
    splitBytes();
  }

  getRawValue() {
    return int.parse(this.rawValue, radix: 16);
  }

  splitBytes() {
    var bytes = this.rawValue;
    brandID = int.parse(bytes.substring(0, 2), radix: 16);
    brandName = getBrandName(brandID).name;
  }

  //to string
  @override
  String toString() {
    return 'ERD0x099{brandID: $brandID, brandName: $brandName}';
  }

  static BrandName getBrandName(int brandID) {
    switch (brandID) {
      case 0:
        return BrandName.Unknown;
      case 1:
        return BrandName.GEA;
      case 2:
        return BrandName.HAIER;
      case 3:
        return BrandName.MABE;
      case 4:
        return BrandName.FISHER_PAYKEL;
      case 5:
        return BrandName.GE;
      case 6:
        return BrandName.PROFILE;
      case 7:
        return BrandName.CAFE;
      case 8:
        return BrandName.MONOGRAM;
      case 9:
        return BrandName.HOTPOINT;
      case 10:
        return BrandName.HAIER_FPA;
      case 11:
        return BrandName.ADORA;
      default:
        return BrandName.Unknown;
    }
  }
}

enum BrandName {
  Unknown,
  GEA,
  HAIER,
  MABE,
  FISHER_PAYKEL,
  GE,
  PROFILE,
  CAFE,
  MONOGRAM,
  HOTPOINT,
  HAIER_FPA,
  ADORA
}
// convert int value to enum
