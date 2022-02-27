part of 'countryflags_bloc.dart';

abstract class CountryflagsState extends Equatable {
  const CountryflagsState();
  
  @override
  List<Object> get props => [];
}

class CountryflagsInitial extends CountryflagsState {}

class CountryflagsErrorState extends CountryflagsState{
  final String errMsg;

  CountryflagsErrorState({required this.errMsg});

  @override
  List<Object> get props => [errMsg];
}

class CountryflagsReady extends CountryflagsState{
  final List<dynamic> urlImagenes;
  final nombresPaises = [
    "Andorra",
    "Mexico",
    "Peru",
    "Argentina",
    "Canada"
  ];

  CountryflagsReady({required this.urlImagenes});

  @override
  List<Object> get props => [urlImagenes];
}