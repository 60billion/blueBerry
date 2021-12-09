import 'package:blueberry/data/item_model.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class SimilarItem extends StatefulWidget {
  int? index;
  String? url;
  SimilarItem(this.index, this.url, {Key? key}) : super(key: key);

  @override
  State<SimilarItem> createState() => _SimilarItemState();
}

class _SimilarItemState extends State<SimilarItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AspectRatio(
          aspectRatio: 5 / 4,
          child: ExtendedImage.network(
            widget.url!,
            fit: BoxFit.cover,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Text(
          '인텍스 메트릭스 듀라빔 플렉스 엑스트라 베스',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Text('1${widget.index},000원')
      ],
    );
  }
}
