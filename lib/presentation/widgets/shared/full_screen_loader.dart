import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  

  Stream<String> getLoadingMessages (){

    final messages = [
      'Cargando Peliculas',
      'Cargando Proximos Lanzamientos',
      'Cargando Las mas populares',
      'Cargando Las mejor Puntuadas',
      'Casi esta todo listo',
      'Casi esta todo listo',
      'Casi esta todo listo',
      'Casi esta todo listo',
      'Porque tarda tanto',
      'Error 404',
      'Error 404',
      'Error 404',
      'Error 404',
      'Error 404',
      'Error 777 Guapisimos',
      'Caiste..',
      'Creo que ya me estoy pasando',
      'Iniciando :)',
    ];

    return Stream.periodic(const  Duration(milliseconds: 1200), (step){
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere Por favor'),
          const SizedBox(height: 10,),
          const CircularProgressIndicator(strokeWidth: 2,),
          const SizedBox(height: 10,),

          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('Cargando...');
              }

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}