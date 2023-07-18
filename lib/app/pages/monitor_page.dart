// Imports Dart
import 'dart:async';

// Imports Flutter
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

// Imports External
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_database/firebase_database.dart';

// Imports Project
import 'package:obus/app_route.dart';
import 'package:obus/app/funcs/permission_controller.dart';
import 'package:obus/app/funcs/notification_controller.dart';
import 'package:obus/app/funcs/velocity_controller.dart';


class MonitorPage extends StatefulWidget {
    final GoRouterState? goRouterState;
    const MonitorPage({super.key, this.goRouterState});

    @override
    State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {

    final VelocityController _velocityController = VelocityController();

    // Dispose
    String _loadingStatus = '';
    Timer? _timer;
    Timer? _timerRedirect;
    late StreamSubscription<dynamic> _subOnibusDb;
    // Dispose

    // Controle
    bool _notification200 = false;
    bool _notification50 = false;
    int _distancia = 0;
    int _tempo = 0;
    // Controle

    // Pessoa
    double _pessoaLat = 0.0;
    double _pessoaLong = 0.0;
    // Pessoa

    // Ônibus
    String? _idOnibus;
    String _onibusNome = '';
    double _onibusLat = 0.0;
    double _onibusLong = 0.0;
    int _onibusVelocidade = 0;
    // Ônibus

    Future<void> _getPessoaLocation() async {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        _pessoaLat = position.latitude;
        _pessoaLong = position.longitude;
        await _calc();
    }

    Future<void> _getOnibusLocation() async {
        DatabaseReference onibusDb = FirebaseDatabase.instance.ref('onibus/$_idOnibus');

        dynamic snapshot = await onibusDb.get();

        if (snapshot.exists) {
            _onibusNome = snapshot.value['nome'];
            _onibusLat = snapshot.value['lat'].toDouble();
            _onibusLong = snapshot.value['long'].toDouble();
            _loadingStatus = '';

            await _calc();
        } else {
            _onibusNome = '';
            _onibusLat = 0.0;
            _onibusLong = 0.0;
            _loadingStatus = 'Ônibus não encontrado.';

            setState(() {});
        }
    }

    Future<void> _getAverageVelocity() async {
        _onibusVelocidade = await _velocityController.getAverageVelocity(idOnibus: _idOnibus!);

        if (_distancia > 0 && _onibusVelocidade > 0) {
            int tempo = _distancia ~/ ((_onibusVelocidade / 3600) * 1000);
            tempo = (tempo / 60).round();

            _tempo = tempo > 0 ? tempo : 1;
        }
        if (mounted) { setState(() {}); }
    }

    Future<void> _getOnibusLocationlisten() async {
        DatabaseReference onibusDb = FirebaseDatabase.instance.ref('onibus/$_idOnibus');

        _subOnibusDb = onibusDb.onValue.listen((DatabaseEvent event) {
            dynamic value = event.snapshot.value;

            if (value == null) { return; }

            _onibusNome = value['nome'];
            _onibusLat = value['lat'].toDouble();
            _onibusLong = value['long'].toDouble();
            () async { await _calc(); }();
        });
    }

    Future<void> _calc() async {
        if (_pessoaLat == 0.0 || _pessoaLong == 0.0 || _onibusLat == 0.0 || _onibusLong == 0.0) { return; }
        double distanceInMeters = Geolocator.distanceBetween(_pessoaLat, _pessoaLong, _onibusLat, _onibusLong);
        _distancia = distanceInMeters.round();

        if (_distancia <= 200 && _distancia >= 50 && !_notification200) {
            await NotificationController.createNotification(
                title: 'Seu ônibus está chegando!',
                body: 'Fique preparado'
            );
            _notification200 = true;
        }

        else if (_distancia <= 50 && !_notification50) {
            await NotificationController.createNotification(
                title: 'Seu ônibus chegou!',
                body: 'Obrigado, você será redirecionado a página inicial.'
            );
            _notification50 = true;

            _timerRedirect = Timer(const Duration(seconds: 7), () {
                if (mounted) { context.goNamed(Routes.home); }
            });
        }

        else if (_distancia >= 200) {
            _notification200 = false;
            _notification50 = false;
        }

        if (mounted) { setState(() {}); }
    }

    @override
    void initState() {
        super.initState();

        _notification200 = false;
        _notification50 = false;

        () async {
            await checkPermission().then((value) => {
                value ? null : context.goNamed(Routes.home),
                _idOnibus = widget.goRouterState?.params['id'].toString(),
            });
            await _getPessoaLocation();
            await _getOnibusLocation();
            await _getOnibusLocationlisten();
            await _getAverageVelocity();

            _timer = Timer.periodic(const Duration(seconds: 1), (timer) async => {
                await _getPessoaLocation(),
                await _getAverageVelocity(),
            });
        }();
    }

    @override
    void dispose() {
        if (_timer != null && _timer!.isActive) { _timer?.cancel(); }
        if (_timerRedirect != null && _timerRedirect!.isActive) { _timerRedirect?.cancel(); }
        if (!_subOnibusDb.isPaused) { _subOnibusDb.cancel(); }
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

                            // Ônibus
                            _loadingStatus.isEmpty
                            ? Container(
                                margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                                width: 100.0,

                                // Style
                                padding: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(8),
                                ),
                                // Style

                                child: Semantics(
                                    explicitChildNodes: true,

                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                            // Descrição
                                            Semantics(
                                                sortKey: const OrdinalSortKey(1.0),
                                                child: Container(
                                                    margin: const EdgeInsets.only(bottom: 20),

                                                    // Style
                                                    padding: const EdgeInsets.all(25),
                                                    decoration: BoxDecoration(
                                                        color: const Color.fromARGB(255, 207, 220, 227),
                                                        borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    // Style

                                                    child: const Center(
                                                        child: Text(
                                                            'A seguir após esse texto, teremos toda as informações do ônibus.'
                                                                ' Quando o onibus estiver proximo avisaremos você por uma notificação '
                                                                'Para voltar para o início temos um botão "Voltar ao início" após as informações do ônibus',
                                                            style: TextStyle(fontSize: 16),
                                                        )
                                                    ),
                                                ),
                                            ),
                                            // Descrição

                                            // Informações do ônibus
                                            Semantics(
                                                sortKey: const OrdinalSortKey(2.0),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                        const Text('Ônibus: ', style: TextStyle(fontSize: 16),),
                                                        Text(_onibusNome, style: const TextStyle(fontSize: 16),),
                                                    ],
                                                ),
                                            ),
                                            Semantics(
                                                sortKey: const OrdinalSortKey(3.0),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                        const Text('Distância: ', style: TextStyle(fontSize: 16),),
                                                        Text('$_distancia metros', style: const TextStyle(fontSize: 16),),
                                                    ],
                                                ),
                                            ),
                                            Semantics(
                                                sortKey: const OrdinalSortKey(4.0),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                        const Text('Tempo: ', style: TextStyle(fontSize: 16),),
                                                        Text('$_tempo min até a chegada', style: const TextStyle(fontSize: 16),),
                                                    ],
                                                ),
                                            ),
                                            // Informações do ônibus
                                        ],
                                    ),
                                ),
                            )
                            : Center(child: Text(_loadingStatus)),
                            // Ônibus

                            // Função
                            Container(
                                margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),

                                child: ElevatedButton(
                                    style: OutlinedButton.styleFrom(
                                        textStyle: const TextStyle(fontSize: 16),
                                        padding: const EdgeInsets.fromLTRB(16, 28, 16, 28),
                                    ),
                                    child: const Text('Voltar ao inicio'),
                                    onPressed: () => context.goNamed(Routes.home),
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
