import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

part 'countrytime_bloc_event.dart';
part 'countrytime_bloc_state.dart';

class CountrytimeBlocBloc extends Bloc<CountrytimeBlocEvent, CountrytimeBlocState> {
  CountrytimeBlocBloc() : super(CountrytimeBlocInitial()) {
    on<CountrytimeBlocEvent>(loadCountryTime);
  }

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
  //URL para las frases
  final String url = "http://worldtimeapi.org/api/timezone/";

  void loadCountryTime (CountrytimeBlocEvent event, Emitter emit) async{
    var paises = await _getCountryTime();
    if (paises == null){
      emit(CountrytimeBlocErrorState(errMsg: "No se pudo cargar la hora"));
    } else {
      String tiempo = paises["datetime"].toString().substring(paises["datetime"].toString().indexOf('T')+1, paises["datetime"].toString().indexOf("."));

      //print(tiempo);
      emit(CountrytimeBlocReady(tiempo: tiempo, pais: paisesNombre[paisSeleccionado]));
    }
  }

  Future _getCountryTime() async {
    //Request para las horas
    String url2 = url+tiempoPaises[paisSeleccionado]; 
    print(url2);
    try{
      Response res = await get(Uri.parse(url2));
      if(res.statusCode == HttpStatus.ok){
        return jsonDecode(res.body); 
      }
    }catch(e){
      print(e);
    }
    return null;
  }
}
