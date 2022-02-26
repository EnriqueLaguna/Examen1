part of 'backgroundimage_bloc.dart';

abstract class BackgroundimageState extends Equatable {
  const BackgroundimageState();

  @override
  List<Object> get props => [];
}
class BackgroundimageInitial extends BackgroundimageState {}

//Estado de error de la imagen
class BackgroundimageErrorState extends BackgroundimageState {
  final String errMsg;

  BackgroundimageErrorState({required this.errMsg});

  @override
  List<Object> get props => [errMsg];
}

//Imagen lista
class BackgroundimageReady extends BackgroundimageState{
  final String imageUrl;

  BackgroundimageReady({required this.imageUrl});

  @override
  List<Object> get props => [];
}