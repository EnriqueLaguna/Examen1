part of 'countrytime_bloc_bloc.dart';

abstract class CountrytimeBlocState extends Equatable {
  const CountrytimeBlocState();
  
  @override
  List<Object> get props => [];
}

class CountrytimeBlocInitial extends CountrytimeBlocState {}

class CountrytimeBlocErrorState extends CountrytimeBlocState{
  final String errMsg;

  CountrytimeBlocErrorState({required this.errMsg});

  @override
  List<Object> get props => [errMsg];
}

class CountrytimeBlocReady extends CountrytimeBlocState{
  final String tiempo;
  final String pais;

  CountrytimeBlocReady({required this.tiempo, required this.pais});

  @override
  List<Object> get props => [tiempo, pais];
}