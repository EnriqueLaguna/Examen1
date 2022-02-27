import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

part 'motiphrase_event.dart';
part 'motiphrase_state.dart';

class MotiphraseBloc extends Bloc<MotiphraseEvent, MotiphraseState> {
  MotiphraseBloc() : super(MotiphraseInitial()) {
    on<MotiphraseEvent>(loadPhrase);
  }

  //url de la frase
  final String url = "https://zenquotes.io/api/random";

  void loadPhrase (MotiphraseEvent event, Emitter emit) async {
      var f = await _getMotiPhrase();
      if (f == null){
        emit(MotiphraseErrorState(errMsg: "No se pudo cargar la frase"));
      } else {
        emit(MotiphraseReady(frase: f[0]['q'], autor: f[0]['a']));
      }
  }

  Future _getMotiPhrase() async {
    try{
      Response res = await get(Uri.parse(url));
      if(res.statusCode == HttpStatus.ok){
        return jsonDecode(res.body); 
      }
    } catch (e){

    }

  }

}
