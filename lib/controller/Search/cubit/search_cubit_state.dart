part of 'search_cubit_cubit.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchSuccessChangeState extends SearchState {}

class SearchErrorChangeState extends SearchState {}

class SearchLoadingChangeState extends SearchState {}
