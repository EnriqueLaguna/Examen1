part of 'allthings_bloc.dart';

abstract class AllthingsState extends Equatable {
  const AllthingsState();
  
  @override
  List<Object> get props => [];
}

class AllthingsInitial extends AllthingsState {}

class AllthingReady extends AllthingsState {
  final Uint8List imageFile;

  final String tiempo;
  final String pais;

  final String frase;
  final String autor;

  AllthingReady({required this.imageFile, required this.tiempo,required this.pais, required this.frase, required this.autor});

  @override
  List<Object> get props => [frase, autor, imageFile, tiempo, pais];
}

class AllthingErrorState extends AllthingsState {
  final String errMsg;

  AllthingErrorState(this.errMsg);

  @override
  List<Object> get props => [errMsg];
}

class AllthingLoagind extends AllthingsState {
}
