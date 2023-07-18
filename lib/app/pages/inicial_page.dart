// Imports Flutter
import 'package:flutter/material.dart';

// Imports External
import 'package:go_router/go_router.dart';

// Imports Project
import 'package:obus/app_route.dart';
import 'package:obus/app/funcs/permission_controller.dart';
import 'package:obus/app/funcs/notification_controller.dart';


class InicialPage extends StatefulWidget {
    const InicialPage({super.key});

    @override
    State<InicialPage> createState() => _InicialPageState();
}

class _InicialPageState extends State<InicialPage> {

    @override
    void initState() {
        super.initState();

        () async {
            await checkPermission();
        }();

        NotificationController.createNotification(
            title: 'Bem vindo!',
            body: 'Obrigado por fazer parte da nossa família'
        );
    }

    @override
    void dispose() {
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[

                            // Descrição
                            Container(
                                margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal:10.0),
                                width: 100.0,

                                // Style
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 207, 220, 227),
                                    borderRadius: BorderRadius.circular(8),
                                ),
                                // Style

                                child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                            'Bem Vindo! Para o funcionamento do aplicativo peço para que permita acessar sua localização.'
                                                'Venho informar que todas a próximas telas tem um descrição do que fazer e de quantos botões ou ações tem na tela'
                                                ' Nessa página inicial temos um Botão, "Qual ônibus gostaria de pegar? "'
                                                'Ele levara para próxima página onde será possível escolher qual ônibus deseja pegar.',
                                            style: TextStyle(fontSize: 16),
                                        )
                                    ),
                                ),
                            ),
                            // Descrição

                            // Função
                            Container(
                                margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),

                                child: ElevatedButton(
                                    style: OutlinedButton.styleFrom(
                                        textStyle: const TextStyle(fontSize: 16),
                                        padding: const EdgeInsets.fromLTRB(16, 28, 16, 28),
                                    ),
                                    child: const Text('Qual ônibus gostaria de pegar?'),
                                    onPressed: () => GoRouter.of(context).push(Routes.search), // context.goNamed(Routes.search),
                                ),
                            ),
                            // Função

                        ],
                    ),
                ),
            ),
        );
    }
}
