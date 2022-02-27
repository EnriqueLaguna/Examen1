import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

part 'countryflags_event.dart';
part 'countryflags_state.dart';

class CountryflagsBloc extends Bloc<CountryflagsEvent, CountryflagsState> {
  CountryflagsBloc() : super(CountryflagsInitial()) {
    on<CountryflagsEvent>(loadCountryFlags);
  }

  static final countryNames = [
    "ad.png", "mx.png", "pe.png", "ca.png", "ar.png"
  ];

  final String url = "https://flagcdn.com/16x12/";

  void loadCountryFlags (CountryflagsEvent event, Emitter emit) async {
      var cf = await _getCountryFlags();
      print(cf);
      if (cf == null){
        emit(CountryflagsErrorState(errMsg: "No funciono F"));
      } else {
        emit(CountryflagsReady(urlImagenes: cf));
      }
  }

  Future _getCountryFlags() async {
    var urlResponse = [];
    countryNames.forEach((pais) async {
      try{ 
      Response res = await get(Uri.parse(url+pais));
        if(res.statusCode == HttpStatus.ok){
          urlResponse.add(jsonDecode(res.body)); 
          print(urlResponse);
        }
      }catch(e){
      print(e);
      }
    });
    return urlResponse; 
  }
}
