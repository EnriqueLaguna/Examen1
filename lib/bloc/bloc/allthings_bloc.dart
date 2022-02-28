import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

part 'allthings_event.dart';
part 'allthings_state.dart';

class AllthingsBloc extends Bloc<AllthingsEvent, AllthingsState> {
  AllthingsBloc() : super(AllthingsInitial()) {
    on<AllthigsEventGetData>(loadAll);
  }
  
  //url de la frase
  final String url2 = "https://zenquotes.io/api/random";
  //URL para las hora
  final String url3 = "http://worldtimeapi.org/api/timezone/";
  //Pais seleccionado
  int paisSeleccionado = 0;

  //Lista de los paises
  static final paisesNombre = [
    "Andorra",
    "Mexico",
    "Peru",
    "Argentina",
    "Canada",
  ];

  //Tiempo_paises
  static final tiempoPaises = [
    "Europe/Andorra",
    "America/Mexico_City",
    "America/Lima",
    "America/Argentina/Buenos_Aires",
    "America/Vancouver",
  ];
  

  void loadAll(AllthingsEvent event, Emitter emit) async {
    emit(AllthingLoagind());
    var imagen = await _getBackgroundimage();
    var f = await _getMotiPhrase();
    var paises = await _getCountryTime();
    //print(imagen);

    // //Elegir una imagen al azar
    // var randomImageNumber = Random().nextInt(30);
    // String urlImagenSeleccionada = imagen[randomImageNumber]["download_url"];
    //print(urlImagenSeleccionada);
    if (imagen == null || f == null || paises == null){
      emit(AllthingErrorState('No se pudo cargar todo'));
    } else {
      String tiempo2 = paises["datetime"].toString().substring(paises["datetime"].toString().indexOf('T')+1, paises["datetime"].toString().indexOf("."));
      emit(AllthingReady(imageFile: imagen, frase: f[0]['q'], autor: f[0]['a'], tiempo: tiempo2, pais: paisesNombre[paisSeleccionado]));
    }
  }

  Future _getBackgroundimage() async {
    //Request a la API de las imagenes
    final _seed = DateTime.now().millisecond;
  //"https://picsum.photos/seed/picsum/200/300"
    final Uri url = Uri(scheme: "https", host: "picsum.photos", path: "seed/${_seed}/720/640",);
    try{
      Response res = await get(url);
      if(res.statusCode == HttpStatus.ok){
        var bytes = res.bodyBytes;
        // return jsonDecode(res.body); 
        return bytes;
      }
    } catch (e){
      print(e);
    }
  }
  
  Future _getMotiPhrase() async {
    try{
      Response res = await get(Uri.parse(url2));
      if(res.statusCode == HttpStatus.ok){
        return jsonDecode(res.body); 
      }
    } catch (e){

    }
  }

  Future _getCountryTime() async {
    //Request para las horas
    String urlhora = url3+tiempoPaises[paisSeleccionado]; 
    print(urlhora);
    try{
      Response res = await get(Uri.parse(urlhora));
      if(res.statusCode == HttpStatus.ok){
        return jsonDecode(res.body); 
      }
    }catch(e){
      print(e);
    }
  }

  // void loadPhrase (MotiphraseEvent event, Emitter emit) async {
  //     var f = await _getMotiPhrase();
  //     if (f == null){
  //       emit(MotiphraseErrorState(errMsg: "No se pudo cargar la frase"));
  //     } else {
  //       emit(MotiphraseReady(frase: f[0]['q'], autor: f[0]['a']));
  //     }
  // }

  

  

  // void loadCountryTime (CountrytimeBlocEvent event, Emitter emit) async{
  //   var paises = await _getCountryTime();
  //   if (paises == null){
  //     emit(CountrytimeBlocErrorState(errMsg: "No se pudo cargar la hora"));
  //   } else {
  //     String tiempo = paises["datetime"].toString().substring(paises["datetime"].toString().indexOf('T')+1, paises["datetime"].toString().indexOf("."));

  //     //print(tiempo);
  //     emit(CountrytimeBlocReady(tiempo: tiempo, pais: paisesNombre[paisSeleccionado]));
  //   }
  // }

  
  

}
