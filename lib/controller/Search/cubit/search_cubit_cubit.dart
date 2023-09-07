// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/constants/constants.dart';
import 'package:shopapp/helper/DioHelper.dart';
import 'package:shopapp/helper/endPoints.dart';
import 'package:shopapp/model/SearchModel.dart';

part 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void SearchProduct({required String text}) {
    emit(SearchLoadingChangeState());
    DioHelper()
        .postData(url: SEARCH, data: {"text": text}, token: token)
        .then((value) {
      model = SearchModel.fromMap(value.data);
      print(value.data);
      emit(SearchSuccessChangeState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorChangeState());
    });
  }
}
