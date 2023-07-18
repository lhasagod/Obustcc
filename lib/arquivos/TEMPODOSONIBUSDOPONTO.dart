import 'package:flutter/material.dart';

class TEMPODOSONIBUSDOPONTO extends StatelessWidget {
  const TEMPODOSONIBUSDOPONTO({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[ Container(margin: EdgeInsets.symmetric(vertical: 40.0,horizontal:10.0),// afasta o conteiner das bordas da tela
            height: 100.0,
            width: 100.0,
            color:Colors.blueGrey,
            child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: Text('A seguir escolha seu ônibus, eles estão numa lista por ordem de chegada no ponto')),
            ),),

            ElevatedButton(

              child: Text('Próxima página'),
              onPressed: () {
                Navigator.pushNamed(context, '/TELAFINAL');
              },
            ),

            Container(margin: EdgeInsets.symmetric(vertical: 40.0,horizontal:123.0),
              color:Colors.red,
              child:Text('Visor'),

            ),

          ],
        ),
      ),
    );
  }
}