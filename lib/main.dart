import 'package:beamer/beamer.dart';
import 'package:blueberry/router/location.dart';
import 'package:blueberry/screens/start_screen.dart';
import 'package:blueberry/screens/splash_screen.dart';
import 'package:blueberry/states/category_notifier.dart';
import 'package:blueberry/states/select_image_notifier.dart';
import 'package:blueberry/states/user_provider.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final _routerDelegate = BeamerDelegate(
    guards: [
      BeamGuard(
          pathBlueprints: ['/'],
          check: (context, location) {
            return context.watch<UserProvider>().user != null;
          },
          showPage: BeamPage(child: StartScreen()))
    ],
    locationBuilder: BeamerLocationBuilder(
        beamLocations: [HomeLocation(), InputLocation()]));

void main() {
  logger.d("My first log by logger pkg!!");
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
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
    } else if (snapshot.connectionState == ConnectionState.done) {
      logger.d("success the initializedApp firebase!!");
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (BuildContext context) => UserProvider(),
          ),
          ChangeNotifierProvider<CategoryNotifier>(
            create: (BuildContext context) => CategoryNotifier(),
          ),
          ChangeNotifierProvider<SelectImageNotifier>(
            create: (BuildContext context) => SelectImageNotifier(),
          ),
        ],
        child: MaterialApp.router(
            theme: ThemeData(
              primarySwatch: Colors.purple,
              textTheme: GoogleFonts.notoSansTextTheme(),
            ),
            routeInformationParser: BeamerParser(),
            routerDelegate: _routerDelegate));
  }
}
