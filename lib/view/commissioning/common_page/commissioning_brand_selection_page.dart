/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_brand_selection_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/brand_model.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/utils/routing_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';

class CommissioningBrandSelectionPage extends StatelessWidget {
  final String userCountryCode;
  final SelectedType selectedType;

  const CommissioningBrandSelectionPage({
    required this.userCountryCode,
    required this.selectedType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GetIt.I.get<CommissioningBrandSelectionCubit>()
          ..retrieveBrands(userCountryCode, selectedType);
      },
      child: WillPopScope(
        // Block back button
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
            title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
            subTitle: LocaleUtil.getString(context, LocaleUtil.SELECT_THE_BRAND_OF_YOUR_APPLIANCE),
            leftBtnFunction: () {
              Navigator.pop(context);
            },
          ).setNavigationAppBar(context: context),
          backgroundColor: Colors.black,
          body: SafeArea(
            child: _BrandSelectionInheritedWidget(
              userCountryCode,
              selectedType,
              child: _BrandSelectionGrid(),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandSelectionInheritedWidget extends InheritedWidget {
  final String userCountryCode;
  final SelectedType selectedType;

  const _BrandSelectionInheritedWidget(this.userCountryCode, this.selectedType, {required super.child});

  static _BrandSelectionInheritedWidget of(BuildContext context) {
    final _BrandSelectionInheritedWidget? result = context.dependOnInheritedWidgetOfExactType<_BrandSelectionInheritedWidget>();
    assert(result != null, 'No _SelectedTypeInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return this != oldWidget;
  }
}

class _BrandSelectionGrid extends StatelessWidget {
  const _BrandSelectionGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommissioningBrandSelectionCubit, BrandSelectionState>(
      listenWhen: (previous, current) => true,
      listener: (context, state) {
        if (state is BrandsLoadedState) {
          // Check if all returned brands are GE related brands.
          bool hasFnpOrHaier = false;
          for (var brand in state.brands) {
            if ([
              ApplianceBrandTypes.brandTypeFisherAndPaykel,
              ApplianceBrandTypes.brandTypeHaier
            ].contains(brand)) {
              hasFnpOrHaier = true;
              break;
            }
          }
          if (state.brands.length == 1 || hasFnpOrHaier) {
            // If only one brand is available default to it without user interaction
            RoutingUtil.handleBrandRouting(
              context: context,
              brandType: state.brands.first.brandType,
              selectedType: _BrandSelectionInheritedWidget.of(context).selectedType,
              userCountryCode: _BrandSelectionInheritedWidget.of(context).userCountryCode,
              replace: true,
            );
          }
        }
      },
      builder: (context, state) {
        if (state is BrandsLoadedState) {
          if (state.brands.length == 1) {
            // Do not show any brand selection as redirection is happening.
            return SizedBox();
          } else {
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24.r,
                mainAxisSpacing: 24.r,
              ),
              itemCount: state.brands.length,
              itemBuilder: (BuildContext context, int index) => _BrandSelectionGridTile(state.brands[index]),
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class _BrandSelectionGridTile extends StatelessWidget {
  final BrandModel _brandModel;

  const _BrandSelectionGridTile(
    this._brandModel, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: AssetImage(_brandModel.imagePath),
      child: InkWell(
        onTap: () {
          RoutingUtil.handleBrandRouting(
            context: context,
            brandType: _brandModel.brandType,
            selectedType: _BrandSelectionInheritedWidget.of(context).selectedType,
            userCountryCode: _BrandSelectionInheritedWidget.of(context).userCountryCode,
          );
        },
      ),
    );
  }
}

class BrandSelectionArgs {
  final String userCountryCode;
  final SelectedType selectedType;

  factory BrandSelectionArgs.withCategory({
    required String userCountryCode,
    required ApplianceCategoryType applianceCategoryType,
    required ApplianceCategoryModel applianceTypes,
  }) {
    return BrandSelectionArgs(
        userCountryCode,
        SelectedCategoryType(
          applianceCategoryType,
          applianceTypes,
        ));
  }

  factory BrandSelectionArgs.withAppliance({
    required String userCountryCode,
    required ApplianceType applianceType,
    required ApplianceCategoryType applianceCategoryType,
    required ApplianceCategoryModel subCategoryTypes,
  }) {
    return BrandSelectionArgs(
        userCountryCode,
        SelectedApplianceType(
          applianceType,
          applianceCategoryType,
          subCategoryTypes,
        ));
  }

  BrandSelectionArgs(this.userCountryCode, this.selectedType);
}
