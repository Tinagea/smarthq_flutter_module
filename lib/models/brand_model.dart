import 'package:equatable/equatable.dart';
import 'package:smarthq_flutter_module/models/models.dart';

abstract class BrandSelectionState extends Equatable {}

class BrandSelectionInitialState extends BrandSelectionState {
  @override
  List<Object?> get props => [];
}

class BrandsLoadedState extends BrandSelectionState {
  final List<BrandModel> brands;

  BrandsLoadedState(this.brands);

  @override
  List<Object?> get props => [brands];
}

/// Model class holding brand details including [ApplianceBrandTypes], image path,
/// available categories for the brand and available appliances for the brand.
class BrandModel extends Equatable {
  final ApplianceBrandTypes brandType;
  final String imagePath;
  final Iterable<AvailableCategoryType> availableCategories;
  final Iterable<AvailableApplianceType> availableApplianceTypes;

  const BrandModel(
    this.brandType,
    this.imagePath,
    this.availableCategories,
    this.availableApplianceTypes,
  );

  /// Convenience method for checking if category is available in the brand and is
  /// available for the given country code.<br />
  /// See [AvailableCategoryType].
  bool availableCategoryTypesContains(ApplianceCategoryType categoryType,
      String userCountryCode) {
    for (var availableCategory in availableCategories) {
      if (availableCategory.categoryType == categoryType &&
          availableCategory.availableCountries.contains(userCountryCode)) {
        return true;
      }
    }
    return false;
  }

  /// Convenience method for checking if appliance type is available in the brand and
  /// is available for the given country code.<br />
  /// See [AvailableApplianceType]
  bool availableApplianceTypesContains(ApplianceType applianceType,
      String userCountryCode) {
    for (var availableApplianceType in availableApplianceTypes) {
      if (availableApplianceType.applianceType == applianceType &&
          availableApplianceType.availableCountries.contains(userCountryCode)) {
        return true;
      }
    }
    return false;
  }

  @override
  List<Object?> get props => [
        brandType,
        imagePath,
        availableCategories,
        availableApplianceTypes,
      ];
}

class AvailableCategoryType extends Equatable {
  final ApplianceCategoryType categoryType;
  final Iterable<String> availableCountries;

  const AvailableCategoryType(this.categoryType, this.availableCountries);

  @override
  String toString() {
    return "AvailableCategoryType: ${categoryType.name}";
  }

  @override
  List<Object?> get props => [categoryType];
}

class AvailableApplianceType extends Equatable {
  final ApplianceType applianceType;
  final Iterable<String> availableCountries;

  const AvailableApplianceType(this.applianceType, this.availableCountries);

  @override
  String toString() {
    return "AvailableApplianceType: ${applianceType.name}";
  }

  @override
  List<Object?> get props => [applianceType];
}

/// Base class holding selected category/appliance.<br />
/// Known subclasses: [SelectedCategoryType], [SelectedApplianceType]
abstract class SelectedType {
  final ApplianceCategoryType applianceCategoryType;
  final ApplianceCategoryModel subCategoryTypes;

  SelectedType(this.applianceCategoryType, this.subCategoryTypes);
}

/// Model class holding selected [ApplianceCategoryType] and [ApplianceCategoryModel].
class SelectedCategoryType extends SelectedType {
  SelectedCategoryType(
    ApplianceCategoryType applianceCategoryType,
    ApplianceCategoryModel subCategoryTypes,
  ) : super(applianceCategoryType, subCategoryTypes);
}

/// Model class holding selected appliance. Also holds the category this
/// appliance belongs to.
class SelectedApplianceType extends SelectedType {
  final ApplianceType applianceType;

  SelectedApplianceType(
    this.applianceType,
    ApplianceCategoryType applianceCategoryType,
    ApplianceCategoryModel subCategoryTypes,
  ) : super(applianceCategoryType, subCategoryTypes);
}
