import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/models/brand_model.dart';
import 'package:smarthq_flutter_module/resources/repositories/commissioning_brand_selection_repository.dart';

class CommissioningBrandSelectionCubit extends Cubit<BrandSelectionState> {
  final CommissioningBrandSelectionRepository repository;

  CommissioningBrandSelectionCubit(this.repository)
      : super(BrandSelectionInitialState());

  /// Retrieve brands based on user's country and selected appliance/category.
  void retrieveBrands(String userCountryCode, SelectedType selectedType) async {
    // Delay until listener initializes
    await Future.delayed(Duration.zero);

    emit(BrandsLoadedState(repository.retrieveBrands(userCountryCode, selectedType)));
  }
}
