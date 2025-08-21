import '/bootstrap/app_helper.dart';
import '/routes/router.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteProvider implements NyProvider {
  @override
  boot(Nylo nylo) async {
    nylo.addRouter(appRouter());

    return nylo;
  }

  @override
  afterBoot(Nylo nylo) async {
    if (AppHelper.instance.appConfig?.appStatus == null) {
      nylo.initRoutes(initialRoute: '/no-connection');
      return;
    }
    final sp = await SharedPreferences.getInstance();
    final String? model = sp.getString('FIRST_RUN_DEVICE_MODEL');
    if (model == null) {
      nylo.initRoutes(initialRoute: '/onboarding-device');
      return;
    }
    nylo.initRoutes();
  }
}
