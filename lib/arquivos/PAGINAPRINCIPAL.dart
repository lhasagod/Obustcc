import 'package:flutter/material.dart';

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({super.key});

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
              child: Center(child: Text('Nessa tela temos 2 botões “Qual ônibus gostaria de pegar?”, que te levara para próxima página para fazer uma pesquisa de um ônibus e o botão “Pontos próximos”, para localizar o ponto mais próximo de você.')),
            ),),

            ElevatedButton(

              child: Text('Pontos Próximos'),
              onPressed: () {
                Navigator.pushNamed(context, '/LISTADEPONTOSPROXIMOS');
              },
            ),
            ElevatedButton(

              child: Text('Qual ônibus gostaria de pegar?'),
              onPressed: () {
                Navigator.pushNamed(context, '/PESQUISADOONIBUS');
              },
            ),
          ],
        ),
      ),
    );
  }
}