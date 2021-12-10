import 'package:beamer/src/beamer.dart';
import 'package:blueberry/data/item_model.dart';
import 'package:blueberry/router/location.dart';
import 'package:blueberry/screens/item/item_detail_screen.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class SimilarItem extends StatelessWidget {
  final ItemModel _itemModel;

  const SimilarItem(this._itemModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ItemDetailScreen(_itemModel.itemKey);
        }));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AspectRatio(
            aspectRatio: 5 / 4,
            child: ExtendedImage.network(
              _itemModel.imageDownloadUrls[0],
              fit: BoxFit.cover,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Text(
            _itemModel.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text('${_itemModel.price}원')
        ],
      ),
    );
  }
}
