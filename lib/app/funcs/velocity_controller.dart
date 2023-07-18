// Imports External
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';


class VelocityController {

    Future<dynamic> getPessoaLocation(String idOnibus) async {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        return {
            'lat': position.latitude,
            'long': position.longitude,
        };
    }

    Future<dynamic> getOnibusLocation(String idOnibus) async {
        DatabaseReference onibusDb = FirebaseDatabase.instance.ref('onibus/$idOnibus');
        dynamic snapshot = await onibusDb.get();

        if (snapshot.exists) {
            return {
                'lat': snapshot.value['lat'].toDouble(),
                'long': snapshot.value['long'].toDouble()
            };
        }
    }

    Future<int> getAverageVelocity({required String idOnibus, double timeInSeconds = 2}) async {
        final position1 = await getOnibusLocation(idOnibus);
        await Future.delayed(const Duration(seconds: 2));
        final position2 = await getOnibusLocation(idOnibus);

        double distanceInMeters = Geolocator.distanceBetween(
            position1['lat'],
            position1['long'],
            position2['lat'],
            position2['long'],
        );

        return ((distanceInMeters / timeInSeconds) * 3.6).round();
    }

}
