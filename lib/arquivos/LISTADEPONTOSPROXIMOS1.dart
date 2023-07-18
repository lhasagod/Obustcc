import 'package:flutter/material.dart';


class LISTADEPONTOSPROXIMOS extends StatelessWidget {
  const LISTADEPONTOSPROXIMOS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[ Container(margin: EdgeInsets.symmetric(vertical: 40.0,horizontal:10.0),// afasta o conteiner das bordas da tela
            height: 160.0,
            width: 100.0,
            color:Colors.blueGrey,
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('A seguir temos os pontos próximos de você. Escute o nome e se for um ponto desejado clique no botão “Próxima página”. Se não, clique em “Outro ponto" para fazer uma nova pesquisa com outros pontos')),
            ),),

            ElevatedButton(

              child: Text('Próxima página'),
              onPressed: () {
                Navigator.pushNamed(context, '/TEMPODOSONIBUSDOPONTO');
              },
            ),
            ElevatedButton(

              child: Text('Outro ponto'),
              onPressed: () {
                Navigator.pushNamed(context, '/');
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
