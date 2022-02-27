import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

part 'backgroundimage_event.dart';
part 'backgroundimage_state.dart';

class BackgroundimageBloc extends Bloc<BackgroundimageEvent, BackgroundimageState> {
  BackgroundimageBloc() : super(BackgroundimageInitial()) {
    on<BackgroundimageEvent>(loadBackgroundimage);
  }

  //Url para la imagen
  final String url = "https://picsum.photos/v2/list";

  
  void loadBackgroundimage(BackgroundimageEvent Levent, Emitter emit) async {
    var imagen = await _getBackgroundimage();
    //print(imagen);

    //Elegir una imagen al azar
    var randomImageNumber = Random().nextInt(30);
    String urlImagenSeleccionada = imagen[randomImageNumber]["download_url"];
    //print(urlImagenSeleccionada);
    if (imagen == null){
      emit(BackgroundimageErrorState(errMsg: 'No se pudo cargar la imagen'));
    } else {
      emit(BackgroundimageReady(imageUrl: urlImagenSeleccionada));
    }
  }

  Future _getBackgroundimage() async {
    //Request a la API de las imagenes
    try{
      Response res = await get(Uri.parse(url));
      if(res.statusCode == HttpStatus.ok){
        return jsonDecode(res.body); 
      }
    } catch (e){
      print(e);
    }


  }
}
