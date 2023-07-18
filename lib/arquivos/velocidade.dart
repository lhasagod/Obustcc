
import 'dart:math' show sin, cos, sqrt, atan2, pi;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'dart:async';




Future<Position> getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  return position;
}

double degreesToRadians(double degrees) {
  return degrees * pi / 180.0;
}

double distanceBetweenCoords(double lat1, double lon1, double lat2, double lon2) {
  const earthRadiusKm = 6371;
  final dLat = degreesToRadians(lat2 - lat1);
  final dLon = degreesToRadians(lon2 - lon1);

  final lat1Radians = degreesToRadians(lat1);
  final lat2Radians = degreesToRadians(lat2);

  final a = sin(dLat / 2) * sin(dLat / 2) +
      sin(dLon / 2) * sin(dLon / 2) * cos(lat1Radians) * cos(lat2Radians);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return earthRadiusKm * c * 1000;
}

Future<double> getAverageVelocity(double timeInSeconds) async {
  final position1 = await getLocation();
  await Future.delayed(Duration(seconds: 2));
  final position2 = await getLocation();

  final distanceInMeters1 = distanceBetweenCoords(
    position1.latitude,
    position1.longitude,
    position2.latitude,
    position2.longitude + 5,
  );
  const timeInSeconds = 120;
  final velocity = distanceInMeters1 / timeInSeconds;
  return velocity;
}

dynamic Distanciamedia() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  late final DatabaseReference _latituderef;
  late final DatabaseReference _longituderef;
  late final Timer _timer;
  late StreamSubscription<DatabaseEvent> _lonSubscription;
  late StreamSubscription<DatabaseEvent> _latSubscription;

  _latituderef = FirebaseDatabase.instance.ref('onibus/ibira/lat');
  _longituderef = FirebaseDatabase.instance.ref('onibus/ibira/long');
  // @override
  // void initState() {
  //   super.initState();



  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _timer.cancel();
  // }

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  final lat1 = position.latitude;
  final lon1 = position.longitude;

  double lat2 = 0;
  final lat2Snapshot = await _latituderef.get();
  lat2 = lat2Snapshot.value as double;

  double lon2 = 0;
  final lot2Snapshot = await _longituderef.get();
  lon2 = lot2Snapshot.value as double;

  _lonSubscription = _longituderef.onValue.listen((DatabaseEvent event) {
    lon2 = (event.snapshot.value) as double;
  });

  _latSubscription = _latituderef.onValue.listen((DatabaseEvent event) {
    lat2 = (event.snapshot.value) as double;
  });

  double distanceInMeters = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  double _distanceInMeters = distanceInMeters;
  print('casa: $_distanceInMeters ');
  // _timer = Timer.periodic(Duration(seconds: 10), (timer) => Distanciamedia());
}

Future<double> tempoDeChegada() async {
  final distanciaMedia = await Distanciamedia();
  final velocidadeMedia = await getAverageVelocity(2); // substitua 10 pelo tempo desejado em segundos

  final tempoEmSegundos = distanciaMedia / velocidadeMedia;
  print(tempoEmSegundos);
  return tempoEmSegundos;

}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  final double timeInSeconds = 120;
  final velocity = await getAverageVelocity(timeInSeconds);
  final distance2 = await Distanciamedia();


}
