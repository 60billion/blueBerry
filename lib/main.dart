import 'package:beamer/beamer.dart';
import 'package:blueberry/router/location.dart';
import 'package:blueberry/screens/auth_screen.dart';
import 'package:blueberry/screens/splash_screen.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:flutter/material.dart';

final _routerDelegate = BeamerDelegate(guards: [
  BeamGuard(
      pathBlueprints: ['/'],
      check: (context, location) {
        return false;
      },
      showPage: BeamPage(child: AuthScreen()))
], locationBuilder: BeamerLocationBuilder(beamLocations: [HomeLocation()]));

void main() {
  logger.d("My first log by logger pkg!!");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3), () => 100),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              child: splashLoaing(snapshot));
        });
  }

  StatelessWidget splashLoaing(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      print("error occur while loading.");
      return const Text("Error occur");
    } else if (snapshot.hasData) {
      print(snapshot);
      return BlueBerry();
    } else {
      return SplashScreen();
    }
  }
}

class BlueBerry extends StatelessWidget {
  const BlueBerry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate);
  }
}
