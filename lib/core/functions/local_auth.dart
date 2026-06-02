import 'package:local_auth/local_auth.dart';

Future<bool> authenticateUser(String reason) async {
  final LocalAuthentication auth = LocalAuthentication();

  try {
    print('⏳ Checking device support...');
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    bool isDeviceSupported = await auth.isDeviceSupported();
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    print('✅ canCheckBiometrics: $canCheckBiometrics');
    print('✅ isDeviceSupported: $isDeviceSupported');
    print('✅ availableBiometrics: $availableBiometrics');

    if (canCheckBiometrics &&
        isDeviceSupported &&
        availableBiometrics.isNotEmpty) {
      bool didAuthenticate = await auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      print('🔐 didAuthenticate: $didAuthenticate');
      return didAuthenticate;
    } else {
      print('❌ Device not supported or no biometrics available');
      return false;
    }
  } catch (e) {
    print('❌ Error during authentication: $e');
    return false;
  }
}
