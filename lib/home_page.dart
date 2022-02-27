import 'dart:ui';

import 'package:examen_uno_app/bloc/backgroundimage_bloc.dart';
import 'package:examen_uno_app/bloc/countrytime_bloc_bloc.dart';
import 'package:examen_uno_app/bloc/motiphrase_bloc.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("La frase diaria"),
          actions: <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            )
          ],
        ),
        backLayer: Container(
          child: Text("Back Layer"),
        ),
        frontLayer: Column(
          children: <Widget>[
            BlocConsumer<BackgroundimageBloc, BackgroundimageState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is BackgroundimageReady) {
                  return Stack(children: <Widget>[
                    Container(
                      child: Image.network(state.imageUrl,
                          height: MediaQuery.of(context).size.height - 80,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.50),
                      height: MediaQuery.of(context).size.height - 80,
                      width: MediaQuery.of(context).size.width,
                    ),
                    BlocConsumer<CountrytimeBlocBloc, CountrytimeBlocState>(
                      listener: (context, stateC) {
                        // TODO: implement listener
                      },
                      builder: (context, stateC) {
                        if (stateC is CountrytimeBlocErrorState) {
                          return Center(
                            child: Text("No se pudo cargar la hora"),
                          );
                        } else if (stateC is CountrytimeBlocReady) {
                          return Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "${stateC.pais}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Text(
                                      "${stateC.tiempo}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 45),
                                    ),
                                  ],
                                ),
                              ));
                        } else {
                          return Text("Algo se murio xd");
                        }
                      },
                    ),
                    BlocConsumer<MotiphraseBloc, MotiphraseState>(
                      listener: (context, stateF) {
                        // TODO: implement listener
                      },
                      builder: (context, stateF) {
                        if(stateF is MotiphraseErrorState){
                          return Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 2),
                              child: Center(child: Text("No se pudo cargar la frase")),
                          );
                        }
                        else if (stateF is MotiphraseReady){
                          return Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 2,
                              left: 10,
                              right: 10,
                              ),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Text("${stateF.frase}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),),
                                      Text("- ${stateF.autor}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),),
                                  ],
                                ),
                              )
                          );
                        } else {
                          return Text("Algo se murio x2 xd");
                        }
                      },
                    )
                  ]);
                } else if (state is BackgroundimageErrorState) {
                  return Text("Imagen no pudo ser cargada");
                } else {
                  return Text("Algo paso xd");
                }
              },
            )
          ],
        ));
  }
}
