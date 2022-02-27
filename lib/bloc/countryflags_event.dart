part of 'countryflags_bloc.dart';

abstract class CountryflagsEvent extends Equatable {
  const CountryflagsEvent();

  @override
  List<Object> get props => [];
}

class LoadCountryFlags extends CountryflagsEvent{
  
}