class RecipeMeasurementConversions {
  //VOLUME
  static const teaSpoon = "TEASPOON";
  static const tableSpoon = "TABLESPOON";
  static const cup = "US_FLUID_CUP";
  static const liter = "LITER";
  static const milliliter = "MILLILITER";
  static const ukGallon = "UK_GALLON";
  static const ukOunce = "UK_OUNCE";
  static const usFluidGallon = "US_FLUID_GALLON";
  static const usFluidOunce = "US_FLUID_OUNCE";
  static const usDryGallon = "US_DRY_GALLON";
  static const usDryOunce = "US_DRY_OUNCE";
  static const stick = "STICK";
  static const dallop = "DALLOP";
  static const usPint = "US_PINT";
  static const usQuart = "US_QUART";
  static const bushel = "BUSHEL";
  static const peck = "PECK";
  static const gill = "GILL";
  //WEIGHT
  static const kilogram = "KILOGRAM";
  static const gram = "GRAM";
  static const pound = "POUND";
  static const ounce = "OUNCE";
  //FOOD COUNT
  static const extraExtraLarge = "EXTRA_EXTRA_LARGE";
  static const extraJumbo = "EXTRA_JUMBO";
  static const jumbo = "JUMBO";
  static const extraLarge = "EXTRA_LARGE";
  static const large = "LARGE";
  static const medium = "MEDIUM";
  static const small = "SMALL";
  static const extraSmall = "EXTRA_SMALL";
  static const extraExtraSmall = "EXTRA_EXTRA_SMALL";
  static const sizeA = "SIZE_A";
  static const sizeB = "SIZE_B";
  static const pinch = "PINCH";
  static const dash = "DASH";
  //FOOD DIAMETER & THICKNESS
  static const inch = "INCH";
  static const centimeter = "CENTIMETER";

  getFormattedMeasurement(String measurement) {
    switch (measurement) {
      case teaSpoon:
        return "tsp";
      case tableSpoon:
        return "tbsp";
      case cup:
        return "cup";
      case liter:
        return "liter";
      case extraExtraLarge:
        return "colossal";
      case extraJumbo:
        return "extra jumbo";
      case jumbo:
        return "jumbo";
      case extraLarge:
        return "extra large";
      case large:
        return "large";
      case medium:
        return "medium";
      case small:
        return "small";
      case extraSmall:
        return "tiny";
      case extraExtraSmall: 
        return "extra extra small";
      case sizeA:
        return "size a";
      case sizeB:
        return "size b";
      case pinch:
        return "pinch";
      case dash:
        return "dash";
      case inch:
        return "inch";
      case centimeter:
        return "cm";
      case ukGallon:
      case usFluidGallon:
      case usDryGallon:
        return "gallon";
      case ukOunce:
      case usFluidOunce:
      case usDryOunce:
      case ounce:
        return "oz";
      case stick:
        return "stick";
      case dallop:
        return "dallop";
      case usPint:
        return "pint";
      case usQuart: 
        return "quart";
      case bushel: 
        return "bushel";
      case peck:
        return "peck";
      case gill:
        return "gill";
      case kilogram:
        return "kg";
      case gram:
        return "g";
      case pound:
        return "lb";
      default:
        return "";
    }
  }
}