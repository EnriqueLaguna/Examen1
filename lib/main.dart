import 'package:examen_uno_app/bloc/backgroundimage_bloc.dart';
import 'package:examen_uno_app/bloc/countrytime_bloc_bloc.dart';
import 'package:examen_uno_app/bloc/motiphrase_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(primarySwatch: Colors.purple),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => BackgroundimageBloc()..add(LoadBackgroundimage())
            ),
            BlocProvider(
              create: (context) => CountrytimeBlocBloc()..add(LoadCountrytimeBloc()),
            ),
            BlocProvider(
              create: (context) => MotiphraseBloc()..add(LoadMotiPhrase()),
            ),
          ],
          child: HomePage(),
        ));
  }
}
