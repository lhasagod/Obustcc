// Imports Flutter
import 'package:flutter/material.dart';

// Imports External
import 'package:go_router/go_router.dart';
import 'package:firebase_database/firebase_database.dart';

// Imports Project
import 'package:obus/app_route.dart';
import 'package:obus/app/funcs/notification_controller.dart';


class SearchPage extends StatefulWidget {
    const SearchPage({super.key});

    @override
    State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

    final TextEditingController _searchController = TextEditingController();
    String _listaStatus = '';
    dynamic _listaOnibus = [];
    bool _loading = false;

    void _pesquisarOnibus() async {
        _loading = true;
        setState(() {_listaStatus = 'Carregando...';});

        NotificationController.createNotification(
            title: 'Pesquisando',
            body: '.',
        );
        await Future.delayed(const Duration(seconds: 3));

        DatabaseReference listaOnibusDb = FirebaseDatabase.instance.ref('onibus');

        dynamic snapshot = await listaOnibusDb
        .orderByChild('nome')
        .startAt(_searchController.text)
        .endAt('${_searchController.text}\uf8ff')
        .limitToFirst(2)
        .get();

        if (snapshot.exists) {
            _listaOnibus = snapshot.value.values.toList();
            setState(() {
                FocusScope.of(context).unfocus();
            });

            NotificationController.createNotification(
                title: 'Pesquisa concluída',
                body: 'Confira a lista dos ônibus disponível na tela'
            );
        } else {
            _listaOnibus.clear();
            _listaStatus = 'Ônibus não encontrado';
            setState(() {});

            NotificationController.createNotification(
                title: 'Pesquisa concluída',
                body: 'Ônibus não encontrado'
            );
        }

        _loading = false;
    }

    void _selecionarOnibus(int index) {
        String param = _listaOnibus[index]['id'];
        // context.goNamed(Routes.monitor, params: {'id': param});
        GoRouter.of(context).push(Routes.monitor.replaceAll(':id', param));
    }

    @override
    void initState() {
        super.initState();
    }

    @override
    void dispose() {
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: SafeArea(
                child: Scrollbar(
                    child: SingleChildScrollView(
                        child: Column(
                            children: [

                                SingleChildScrollView(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[

                                            // Descrição
                                            Container(
                                                margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                                                width: 100.0,

                                                // Style
                                                padding: const EdgeInsets.all(25),
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(255, 207, 220, 227),
                                                    borderRadius: BorderRadius.circular(8),
                                                ),
                                                // Style

                                                child: const Center(
                                                    child: Text(
                                                        'A seguir após esse texto, temos um local de pesquisa. Por favor, após terminar de escrever o nome do ônibus '
                                                        'clique no botão Pesquisar, logo abaixo do campo de texto '
                                                            'Depois aparecerá a lista dos ônibus com o nome parecido, selecione um para continuarmos. '
                                                            'Caso não apareça nenhum Ônibus recebera a mensagem "Ônibus não encontrado" ',
                                                        style: TextStyle(fontSize: 16),
                                                    )
                                                ),
                                            ),
                                            // Descrição

                                            // Caixa de pesquisa
                                            Container(
                                                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                                                child: TextFormField(

                                                    // Input Config
                                                    controller: _searchController,
                                                    showCursor: true,
                                                    autovalidateMode: AutovalidateMode.disabled,
                                                    keyboardType: TextInputType.text,
                                                    // Input Config

                                                    // Decorations
                                                    decoration: const InputDecoration(
                                                        label: Text('Digite o nome do seu ônibus'),
                                                    ),
                                                    // Decorations

                                                ),
                                            ),
                                            // Caixa de pesquisa

                                            // Função
                                            Container(
                                                margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),

                                                child: ElevatedButton(
                                                    style: OutlinedButton.styleFrom(
                                                        textStyle: const TextStyle(fontSize: 16),
                                                        padding: const EdgeInsets.fromLTRB(16, 28, 16, 28),
                                                    ),
                                                    onPressed: _loading ? null : _pesquisarOnibus,
                                                    child: const Text('Botão pesquisar'),
                                                ),
                                            ),
                                            // Função

                                        ],
                                    ),
                                ),

                                // Lista dos ônibus
                                SizedBox(
                                    height: 200,
                                    child: _listaOnibus.isNotEmpty
                                    ? Scrollbar(
                                        child: ListView.builder(
                                            padding: const EdgeInsets.all(8),
                                            itemCount: _listaOnibus.length,
                                            itemBuilder: (BuildContext context, int index) {
                                                return ListTile(
                                                    title: Text('${_listaOnibus[index]["nome"]}'),
                                                    onTap: () => _selecionarOnibus(index),
                                                );
                                            }
                                        ),
                                    )
                                    : Center(child: Text(_listaStatus)),
                                ),
                                // Lista dos ônibus
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}
