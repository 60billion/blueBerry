import 'package:beamer/beamer.dart';
import 'package:blueberry/screens/home_screen.dart';
import 'package:blueberry/screens/input/input_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [BeamPage(child: HomeScreen(), key: ValueKey('home'))];
  }

  @override
  List get pathBlueprints => ['/'];
}

class InputLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathBlueprintSegments.contains('input'))
        BeamPage(key: ValueKey('input'), child: InputScreen())
    ];
  }

  @override
  List get pathBlueprints => ['/input'];
}
