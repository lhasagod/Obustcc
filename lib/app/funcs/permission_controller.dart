// Imports External
import 'package:geolocator/geolocator.dart';

Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
            // Permissão de localização negada permanentemente, vá para as configurações do aplicativo
            // do usuário e solicite permissão manualmente.
            return false;
        }
    }
    if (permission == LocationPermission.deniedForever) {
        // Permissão de localização negada permanentemente, vá para as configurações do aplicativo
        // do usuário e solicite permissão manualmente.
        return false;
    }

    // Permissão de localização concedida, pode continuar com as operações que requerem localização.
    return true;
}
