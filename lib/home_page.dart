import 'dart:ui';

import 'package:examen_uno_app/bloc/backgroundimage_bloc.dart';
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
        backLayer: Center(
          child: Container(
            child: Text('Back layer'),
          ),
        ),
        frontLayer: Column(
          children: <Widget>[
            BlocConsumer<BackgroundimageBloc, BackgroundimageState>(
              listener: (context, state){
              },
              builder: (context, state) {
                if(state is BackgroundimageReady) {
                  return Stack(
                    children: <Widget>[
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
                      Center(child: Text("Texto sobre la imagen"),
                      )
                    ]
                  );
                } else if (state is BackgroundimageErrorState){
                  return Text("Imagen no pudo ser cargada");
                } else {
                  return Text("Algo paso xd");
                }
              },
            )
          ],
        )
      );
  }
}