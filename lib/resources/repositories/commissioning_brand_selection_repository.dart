import 'package:smarthq_flutter_module/models/brand_model.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/utils/country_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';

/// Brand selection repository for commissioning.
abstract class CommissioningBrandSelectionRepository {
  /// Creates a new instance of [CommissioningBrandSelectionRepository]. Please consider using
  /// the instance created in AppDi instead of this.
  static CommissioningBrandSelectionRepository newInstance() {
    return _CommissioningBrandSelectionRepositoryImpl();
  }

  /// Retrieve brands based on user location and selected appliance/category.
  List<BrandModel> retrieveBrands(String userCountryCode, SelectedType selectedType);
}

/// Implementation of [CommissioningBrandSelectionRepository].
class _CommissioningBrandSelectionRepositoryImpl extends CommissioningBrandSelectionRepository {
  // Categories available for GEA
  static final _geaApplianceCategories = List<AvailableCategoryType>.unmodifiable(
    [
      AvailableCategoryType(
        ApplianceCategoryType.AIR_CONDITIONER,
        CountryUtil.allGeCountries,
      ),
      AvailableCategoryType(
        ApplianceCategoryType.COOKING,
        CountryUtil.allGeCountries,
      ),
      AvailableCategoryType(
        ApplianceCategoryType.DISHWASHER,
        CountryUtil.allGeCountries,
      ),
      AvailableCategoryType(
        ApplianceCategoryType.REFRIGERATION,
        CountryUtil.allGeCountries,
      ),
      AvailableCategoryType(
        ApplianceCategoryType.WATER_PRODUCTS,
        CountryUtil.allGeCountries,
      ),
      AvailableCategoryType(
        ApplianceCategoryType.COUNTERTOP_APPLIANCES,
        CountryUtil.allGeCountries,
      ),
      AvailableCategoryType(
        ApplianceCategoryType.LAUNDRY,
        CountryUtil.allGeCountries,
      ),
      AvailableCategoryType(
        ApplianceCategoryType.GATEWAY,
        CountryUtil.allGeCountries,
      ),
    ],
  );

  // Appliances available for GEA
  static final _geaApplianceTypes = List<AvailableApplianceType>.unmodifiable(
    [
      AvailableApplianceType(
        ApplianceType.WATER_HEATER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.LAUNDRY_DRYER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.LAUNDRY_WASHER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.REFRIGERATOR,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.MICROWAVE,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.ADVANTIUM,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.DISHWASHER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.OVEN,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.ELECTRIC_RANGE,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.GAS_RANGE,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.AIR_CONDITIONER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.ELECTRIC_COOKTOP,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.PIZZA_OVEN,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.GAS_COOKTOP,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.SPLIT_AIR_CONDITIONER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.HOOD,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.POE_WATER_FILTER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.COOKTOP_STANDALONE,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.DELIVERY_BOX,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.ZONELINE,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.WATER_SOFTENER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.PORTABLE_AIR_CONDITIONER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.COMBINATION_WASHER_DRYER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.DUAL_ZONE_WINE_CHILLER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.BEVERAGE_CENTER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.COFFEE_BREWER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.OPAL_ICE_MAKER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.IN_HOME_GROWER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.DEHUMIDIFIER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.UNDER_COUNTER_ICE_MAKER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.TOASTER_OVEN,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.BUILT_IN_AC,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.ESPRESSO_COFFEE_MAKER,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.GATEWAY,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.UNDEFINED,
        CountryUtil.allGeCountries,
      ),
      AvailableApplianceType(
        ApplianceType.APPL,
        CountryUtil.allGeCountries,
      ),
    ],
  );

  // Categories available for F&P
  static final _fnpCategoriesTypes = List<AvailableCategoryType>.unmodifiable(
    [
      AvailableCategoryType(
        ApplianceCategoryType.REFRIGERATION,
        CountryUtil.allFnpCountries,
      ),
      AvailableCategoryType(
        ApplianceCategoryType.DISHWASHER,
        CountryUtil.allFnpCountries,
      ),
      AvailableCategoryType(
        ApplianceCategoryType.LAUNDRY,
        [
          CountryUtil.au,
          CountryUtil.nz,
          CountryUtil.sg,
          CountryUtil.gb,
          CountryUtil.ie,
          CountryUtil.uk,
        ],
      ),
      AvailableCategoryType(
        ApplianceCategoryType.COOKING,
        CountryUtil.allFnpCountries,
      ),
    ],
  );

  // Appliances available for F&P
  static final _fnpApplianceTypes = List<AvailableApplianceType>.unmodifiable(
    [
      AvailableApplianceType(
        ApplianceType.REFRIGERATOR,
        CountryUtil.allFnpCountries,
      ),
      AvailableApplianceType(
        ApplianceType.DISHWASHER,
        CountryUtil.allFnpCountries,
      ),
      AvailableApplianceType(
        ApplianceType.DISH_DRAWER,
        CountryUtil.allFnpCountries,
      ),
      AvailableApplianceType(
        ApplianceType.LAUNDRY_WASHER,
        [
          CountryUtil.au,
          CountryUtil.nz,
          CountryUtil.sg,
          CountryUtil.gb,
          CountryUtil.ie,
          CountryUtil.uk,
        ],
      ),
      AvailableApplianceType(
        ApplianceType.LAUNDRY_DRYER,
        [
          CountryUtil.au,
          CountryUtil.nz,
          CountryUtil.sg,
          CountryUtil.gb,
          CountryUtil.ie,
          CountryUtil.uk,
        ],
      ),
      AvailableApplianceType(
        ApplianceType.OVEN,
        CountryUtil.allFnpCountries,
      ),
      AvailableApplianceType(
        ApplianceType.HOOD,
        CountryUtil.allFnpCountries,
      ),
      AvailableApplianceType(
        ApplianceType.ELECTRIC_RANGE,
        CountryUtil.allFnpCountries,
      ),
    ],
  );

  // Appliances available for Haier
  static final _fpaHaierCategoriesTypes = List<AvailableCategoryType>.unmodifiable(
    [
      AvailableCategoryType(
        ApplianceCategoryType.AIR_CONDITIONER,
        [CountryUtil.au, CountryUtil.nz],
      ),
      AvailableCategoryType(
        ApplianceCategoryType.REFRIGERATION,
        [CountryUtil.au, CountryUtil.nz],
      ),
      AvailableCategoryType(
        ApplianceCategoryType.DISHWASHER,
        [CountryUtil.au, CountryUtil.nz],
      ),
      AvailableCategoryType(
        ApplianceCategoryType.LAUNDRY,
        [CountryUtil.au, CountryUtil.nz],
      ),
      AvailableCategoryType(
        ApplianceCategoryType.COOKING,
        [CountryUtil.au, CountryUtil.nz],
      ),
      AvailableCategoryType(
        ApplianceCategoryType.WATER_PRODUCTS,
        [CountryUtil.au, CountryUtil.nz],
      ),
    ],
  );

  // Appliances available for Haier
  static final _fpaHaierApplianceTypes = List<AvailableApplianceType>.unmodifiable(
    [
      AvailableApplianceType(
        ApplianceType.SPLIT_AIR_CONDITIONER,
        [CountryUtil.au, CountryUtil.nz],
      ),
      AvailableApplianceType(
        ApplianceType.BUILT_IN_AC,
        [CountryUtil.au, CountryUtil.nz],
      ),
      AvailableApplianceType(
        ApplianceType.REFRIGERATOR,
        [CountryUtil.au, CountryUtil.nz],
      ),
      AvailableApplianceType(
        ApplianceType.DISHWASHER,
        [CountryUtil.au, CountryUtil.nz],
      ),
      AvailableApplianceType(
        ApplianceType.LAUNDRY_WASHER,
        [CountryUtil.au, CountryUtil.nz],
      ),
      AvailableApplianceType(
        ApplianceType.LAUNDRY_DRYER,
        [CountryUtil.au, CountryUtil.nz],
      ),
      AvailableApplianceType(
        ApplianceType.OVEN,
        [CountryUtil.au, CountryUtil.nz],
      ),
      AvailableApplianceType(
        ApplianceType.WATER_HEATER,
        [CountryUtil.au, CountryUtil.nz],
      ),
    ],
  );

  // All brands
  static final _allBrands = List<BrandModel>.unmodifiable(
    [
      BrandModel(
        ApplianceBrandTypes.brandTypeMonogram,
        ImagePath.BRAND_MONOGRAM,
        _geaApplianceCategories,
        _geaApplianceTypes,
      ),
      BrandModel(
        ApplianceBrandTypes.brandTypeCafe,
        ImagePath.BRAND_CAFE,
        _geaApplianceCategories,
        _geaApplianceTypes,
      ),
      BrandModel(
        ApplianceBrandTypes.brandTypeProfile,
        ImagePath.BRAND_PROFILE,
        _geaApplianceCategories,
        _geaApplianceTypes,
      ),
      BrandModel(
        ApplianceBrandTypes.brandTypeGea,
        ImagePath.BRAND_GE_APPLIANCES,
        _geaApplianceCategories,
        _geaApplianceTypes,
      ),
      BrandModel(
        ApplianceBrandTypes.brandTypeHaier,
        ImagePath.BRAND_HAIER,
        _geaApplianceCategories,
        _geaApplianceTypes,
      ),
      BrandModel(
        ApplianceBrandTypes.brandTypeFisherAndPaykel,
        ImagePath.BRAND_FISHER_AND_PAYKEL,
        _fnpCategoriesTypes,
        _fnpApplianceTypes,
      ),
      BrandModel(
        ApplianceBrandTypes.brandTypeFpaHaier,
        ImagePath.BRAND_HAIER,
        _fpaHaierCategoriesTypes,
        _fpaHaierApplianceTypes,
      ),
    ],
  );

  @override
  List<BrandModel> retrieveBrands(String userCountryCode, SelectedType selectedType) {
    if (!CountryUtil.allCountries.contains(userCountryCode)) {
      // Default to all brands in case a new country is added.
      return List.unmodifiable(_allBrands);
    }

    List<BrandModel> filteredBrands = List.empty(growable: true);
    for (var brand in _allBrands) {
      if ((selectedType is SelectedApplianceType && brand.availableApplianceTypesContains(selectedType.applianceType, userCountryCode)) || (selectedType is SelectedCategoryType && brand.availableCategoryTypesContains(selectedType.applianceCategoryType, userCountryCode))) {
        filteredBrands.add(brand);
      }
    }

    return List.unmodifiable(filteredBrands);
  }
}
