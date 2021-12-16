import 'package:beamer/beamer.dart';
import 'package:blueberry/screens/chat/chatroom_screen.dart';
import 'package:blueberry/screens/home_screen.dart';
import 'package:blueberry/screens/input/category_input_screen.dart';
import 'package:blueberry/screens/input/input_screen.dart';
import 'package:blueberry/screens/item/item_detail_screen.dart';
import 'package:blueberry/screens/search/search_screen.dart';
import 'package:blueberry/states/category_notifier.dart';
import 'package:blueberry/states/select_image_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

const LOCATION_HOME = 'home';
const LOCATION_INPUT = 'input';
const LOCATION_SEARCH = 'search';
const LOCATION_ITEM = 'item';
const LOCATION_ITEM_ID = 'item_id';
const LOCATION_CHATROOM_ID = 'chatroom_id';
const LOCATION_CATEGORY_INPUT = 'category_input';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(child: HomeScreen(), key: ValueKey(LOCATION_HOME)),
      if (state.pathBlueprintSegments.contains(LOCATION_SEARCH))
        BeamPage(key: ValueKey(LOCATION_SEARCH), child: SearchScreen())
    ];
  }

  @override
  List get pathBlueprints => ['/', '/$LOCATION_SEARCH'];
}

class InputLocation extends BeamLocation {
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
                ItemDetailScreen(state.pathParameters[LOCATION_ITEM_ID] ?? "")),
      if (state.pathParameters.containsKey(LOCATION_CHATROOM_ID))
        BeamPage(
            key: ValueKey(LOCATION_CHATROOM_ID),
            child: ChatroomScreen(
                chatroomKey: state.pathParameters[LOCATION_CHATROOM_ID] ?? ""))
      //chatroomKey:
      //'4hQtDKfuelaESxVQGnDCKCJswGG3_1639033691301346_ITEU4CI7iAdMGjQBYK5HZiUN5AQ2'))
      //채팅 테스트용 채팅방 매칭하려고
    ];
  }

  @override
  List get pathBlueprints => [
        '/$LOCATION_ITEM/:$LOCATION_ITEM_ID/:$LOCATION_CHATROOM_ID',
        '/:$LOCATION_CHATROOM_ID'
      ];
}
