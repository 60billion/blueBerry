import 'package:algolia/algolia.dart';
import 'package:blueberry/constants/keys.dart';
import 'package:blueberry/data/item_model.dart';
import 'package:blueberry/utils/logger.dart';

const Algolia algolia = Algolia.init(
  applicationId: ALGOLIA_APPLICATIONID,
  apiKey: ALGOLIA_APIKEY,
);

class AlgoliaService {
  static final AlgoliaService _algoliaService = AlgoliaService._interal();
  factory AlgoliaService() => _algoliaService;
  AlgoliaService._interal();

  Future<List<ItemModel>> queryItems(String queryStr) async {
    AlgoliaQuery query = algolia.instance.index('items').query(queryStr);

    AlgoliaQuerySnapshot algoliaQuerySnapshot = await query.getObjects();

    List<ItemModel> items = [];

    algoliaQuerySnapshot.hits.forEach((element) {
      items.add(ItemModel.fromAlgolia(element.data, element.objectID));
    });

    return items;
  }
}
