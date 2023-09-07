part of 'hom_layout_cubit.dart';

abstract class HomLayoutState {}

class HomLayoutInitial extends HomLayoutState {}

class BottomNaviState extends HomLayoutState {}

class ShopLoadingHomeDataState extends HomLayoutState {}

class ShopSuccessHomeDataState extends HomLayoutState {}

class ShopErrorHomeDataState extends HomLayoutState {}

class ShopCategoriesSuccessHomeDataState extends HomLayoutState {}

class ShopCategoriesErrorHomeDataState extends HomLayoutState {}

class ShopChangeFavouritesSuccessState extends HomLayoutState {
  final ChangeFavourites? changeFavouritesModel;

  ShopChangeFavouritesSuccessState(this.changeFavouritesModel);
}

class ShopChangeFavouritesErrorState extends HomLayoutState {}

class ShopFavouritesSuccessState extends HomLayoutState {}

class ShopFavouritesErrorState extends HomLayoutState {}

class ShopGetFavouritesSuccessState extends HomLayoutState {}

class ShopGetFavouritesErrorState extends HomLayoutState {}

class ShopLoadingFavouritesState extends HomLayoutState {}

class ShopGetUpdateSuccessState extends HomLayoutState {}

class ShopGetUpdateErrorState extends HomLayoutState {}

class ShopLoadingUpdateState extends HomLayoutState {}

class ShopGetSettingsSuccessState extends HomLayoutState {
  final Loginmodel settingsModel;

  ShopGetSettingsSuccessState({required this.settingsModel});
}

class ShopGetSettingsErrorState extends HomLayoutState {}

class ShopLoadingSettingsState extends HomLayoutState {}
