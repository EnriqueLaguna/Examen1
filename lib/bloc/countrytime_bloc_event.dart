part of 'countrytime_bloc_bloc.dart';

abstract class CountrytimeBlocEvent extends Equatable {
  const CountrytimeBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadCountrytimeBloc extends CountrytimeBlocEvent{
  
}