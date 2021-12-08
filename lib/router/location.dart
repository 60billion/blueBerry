import 'package:beamer/beamer.dart';
import 'package:blueberry/screens/home_screen.dart';
import 'package:blueberry/screens/input/category_input_screen.dart';
import 'package:blueberry/screens/input/input_screen.dart';
import 'package:blueberry/screens/item/item_detail_screen.dart';
import 'package:blueberry/states/category_notifier.dart';
import 'package:blueberry/states/select_image_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

const LOCATION_HOME = 'home';
const LOCATION_INPUT = 'input';
const LOCATION_ITEM = 'item';
const LOCATION_ITEM_ID = 'item_id';
const LOCATION_CATEGORY_INPUT = 'category_input';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [BeamPage(child: HomeScreen(), key: ValueKey(LOCATION_HOME))];
  }

  @override
  List get pathBlueprints => ['/'];
}

class InputLocation extends BeamLocation {
  // @override
  // Widget builder(BuildContext context, Widget navigator) {
  //   return MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider<CategoryNotifier>(
  //         create: (BuildContext context) => CategoryNotifier(),
  //       ),
  //       ChangeNotifierProvider<SelectImageNotifier>(
  //         create: (BuildContext context) => SelectImageNotifier(),
  //       ),
  //     ],
  //     child: super.builder(context, navigator),
  //   );
  // }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathBlueprintSegments.contains(LOCATION_INPUT))
        BeamPage(key: ValueKey(LOCATION_INPUT), child: InputScreen()),
      if (state.pathBlueprintSegments.contains(LOCATION_CATEGORY_INPUT))
        BeamPage(
            key: ValueKey(LOCATION_CATEGORY_INPUT),
            child: CategoryInputScreen()),
    ];
  }

  @override
  List get pathBlueprints =>
      ['/$LOCATION_INPUT', '$LOCATION_INPUT/$LOCATION_CATEGORY_INPUT'];
}

class ItemLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathParameters.containsKey(LOCATION_ITEM_ID))
        BeamPage(
            key: ValueKey(LOCATION_ITEM),
            child:
                ItemDetailScreen(state.pathParameters[LOCATION_ITEM_ID] ?? ""))
    ];
  }

  @override
  List get pathBlueprints => ['/$LOCATION_ITEM/:$LOCATION_ITEM_ID'];
}
