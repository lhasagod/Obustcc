import 'package:flutter/material.dart';


class PESQUISADOONIBUS extends StatelessWidget {
  const PESQUISADOONIBUS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[ Container(

            margin: EdgeInsets.symmetric(vertical: 40.0,horizontal:10.0),// afasta o conteiner das bordas da tela
            height: 160.0,
            width: 100.0,
            color:Colors.blueGrey,
            child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: Text('A seguir tem um local de pesquisa onde é possível procurar qual ônibus deseja pegar e um pouco mais em baixo terá as respostas, basta clicar em uma para ir para próxima página')),
            ),),

            Container(margin: EdgeInsets.symmetric(vertical: 40.0,horizontal:123.0),
              color:Colors.red,
              child:Text('Local de pesquisa'),

            ),

            ElevatedButton(

              child: Text('Botão pesquisar'),
              onPressed: () {
                Navigator.pushNamed(context, '/LISTADEPONTOSPROXIMOSO');
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