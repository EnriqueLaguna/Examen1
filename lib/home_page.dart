import 'dart:ui';

import 'package:examen_uno_app/bloc/backgroundimage_bloc.dart';
import 'package:examen_uno_app/bloc/bloc/allthings_bloc.dart';
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

  final nombresPaises = [
    "Andorra",
    "Mexico",
    "Peru",
    "Argentina",
    "Canada"
  ];

  static final countryNames = [
    "ad.png", "mx.png", "pe.png", "ar.png", "ca.png",
  ];

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
        headerHeight: MediaQuery.of(context).size.height * .5,
        backLayer: Container(
          height: MediaQuery.of(context).size.height * .5 * 0.75,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: countryNames.length,
            itemBuilder: (BuildContext context, int index) {
              final flagAPI = "https://flagcdn.com/16x12/";
              return ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network('${flagAPI}${countryNames[index]}'),
                ),
                title: Text(nombresPaises[index], style: TextStyle(color: Colors.white),),
                onTap: () {
                    // BlocProvider.of<BackgroundimageBloc>(context).add( LoadBackgroundimage());
                    // BlocProvider.of<CountrytimeBlocBloc>(context).paisSeleccionado = index;
                    // BlocProvider.of<CountrytimeBlocBloc>(context).add( LoadCountrytimeBloc());
                    // BlocProvider.of<MotiphraseBloc>(context).add( LoadMotiPhrase());
                  BlocProvider.of<AllthingsBloc>(context).paisSeleccionado = index;
                  BlocProvider.of<AllthingsBloc>(context).add(AllthigsEventGetData());
                },
              );
            },
          ),
        ),
        frontLayer: Column(
          children: <Widget>[
            BlocConsumer<AllthingsBloc, AllthingsState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if(state is AllthingLoagind){
                  return  Padding(
                    padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2,
                          left: 10,
                          right: 10,
                          ),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is AllthingErrorState){
                  return Text("No se pudo cargar");
                } else if (state is AllthingReady){
                  return Stack(
                    children: <Widget>[
                      Container(
                      child: Image.memory(state.imageFile,
                          height: MediaQuery.of(context).size.height - 80,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                      )
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.50),
                      height: MediaQuery.of(context).size.height - 80,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "${state.pais}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              "${state.tiempo}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 45),
                            ),
                          ],
                        ),
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2,
                          left: 10,
                          right: 10,
                          ),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text("${state.frase}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),),
                                  Text("- ${state.autor}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),),
                              ],
                            ),
                          )
                      )
                    ],
                  );
                } else {
                  return Center(child: Text("Cargando datos"));
                }
              },
            )
          //   BlocConsumer<BackgroundimageBloc, BackgroundimageState>(
          //     listener: (context, state) {
          //     },
          //     builder: (context, state) {
          //       if (state is BackgroundimageReady) {
          //         return Stack(children: <Widget>[
          //           Container(
          //             child: Image.network(state.imageUrl,
          //                 height: MediaQuery.of(context).size.height - 80,
          //                 width: MediaQuery.of(context).size.width,
          //                 fit: BoxFit.fill,
          //                 loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          //                   if (loadingProgress == null){
          //                     return child;
          //                   }
          //                   return Center(
          //                     child: CircularProgressIndicator(),
          //                   );
          //                 },
          //             )
          //           ),
          //           Container(
          //             color: Colors.black.withOpacity(0.50),
          //             height: MediaQuery.of(context).size.height - 80,
          //             width: MediaQuery.of(context).size.width,
          //           ),
          //           BlocConsumer<CountrytimeBlocBloc, CountrytimeBlocState>(
          //             listener: (context, stateC) {
          //               // TODO: implement listener
          //             },
          //             builder: (context, stateC) {
          //               if (stateC is CountrytimeBlocErrorState) {
          //                 return Center(
          //                   child: Text("No se pudo cargar la hora"),
          //                 );
          //               } else if (stateC is CountrytimeBlocReady) {
          //                 return Padding(
          //                     padding: EdgeInsets.all(10),
          //                     child: Center(
          //                       child: Column(
          //                         children: [
          //                           Text(
          //                             "${stateC.pais}",
          //                             style: TextStyle(
          //                                 color: Colors.white, fontSize: 20),
          //                           ),
          //                           Text(
          //                             "${stateC.tiempo}",
          //                             style: TextStyle(
          //                                 color: Colors.white, fontSize: 45),
          //                           ),
          //                         ],
          //                       ),
          //                     ));
          //               } else {
          //                 return Text("");
          //               }
          //             },
          //           ),
          //           BlocConsumer<MotiphraseBloc, MotiphraseState>(
          //             listener: (context, stateF) {
          //               // TODO: implement listener
          //             },
          //             buildWhen: (context, stateF) {
          //               return state is BackgroundimageReady;
          //             },
          //             builder: (context, stateF) {
          //               if(stateF is MotiphraseErrorState){
          //                 return Padding(
          //                 padding: EdgeInsets.only(
          //                     top: MediaQuery.of(context).size.height / 2),
          //                     child: Center(child: Text("No se pudo cargar la frase")),
          //                 );
          //               }
          //               else if (stateF is MotiphraseReady){
          //                 return Padding(
          //                 padding: EdgeInsets.only(
          //                     top: MediaQuery.of(context).size.height / 2,
          //                     left: 10,
          //                     right: 10,
          //                     ),
          //                     child: Center(
          //                       child: Column(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                             Text("${stateF.frase}",
          //                             style: TextStyle(
          //                                 color: Colors.white, fontSize: 20),),
          //                             Text("- ${stateF.autor}",
          //                             style: TextStyle(
          //                                 color: Colors.white, fontSize: 20),),
          //                         ],
          //                       ),
          //                     )
          //                 );
          //               } else {
          //                 return Text("");
          //               }
          //             },
          //           )
          //         ]);
          //       } else if (state is BackgroundimageErrorState) {
          //         return Text("Imagen no pudo ser cargada");
          //       } else if (state is BackgroundimageLoading) {
          //         return Padding(
          //           padding:EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
          //           child: Center(child: CircularProgressIndicator()),
          //         );
          //       } else {
          //         return Padding(
          //           padding:EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
          //           child: Center(child: CircularProgressIndicator()),
          //         );
          //       }
          //     },
          //   )
          ],
        ));
  }
}
