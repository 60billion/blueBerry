// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:beamer/src/beamer.dart';
import 'package:blueberry/data/item_model.dart';
import 'package:blueberry/repo/item_service.dart';
import 'package:blueberry/repo/user_service.dart';
import 'package:blueberry/router/location.dart';
import 'package:blueberry/states/user_provider.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shimmer/shimmer.dart';

class ItemsPage extends StatefulWidget {
  final String userKey;
  const ItemsPage({Key? key, required this.userKey}) : super(key: key);

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final List<ItemModel> _items = [];
  bool init = false;
  @override
  void initState() {
    print("initState");
    if (init == false) {
      _onRefresh();
      init = true;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      double userWidth = MediaQuery.of(context).size.width;

      return AnimatedSwitcher(
        duration: Duration(milliseconds: 1000),
        child: (_items.isNotEmpty)
            ? _listView(userWidth)
            : _shimmerListView(userWidth),
      );
    });
  }

  Future _onRefresh() async {
    _items.clear();
    _items.addAll(await ItemService().getItems(widget.userKey));
    logger.d(widget.userKey);
    setState(() {});
  }

  RefreshIndicator _listView(double userWidth) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(userWidth * 0.04, userWidth * 0.04,
            userWidth * 0.04, userWidth * 0.04),
        separatorBuilder: (context, index) {
          return Divider(
            height: userWidth * 0.08,
            thickness: userWidth * 0.005,
            color: Colors.grey[200],
            indent: 0,
            endIndent: 0,
          );
        },
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context.beamToNamed('/$LOCATION_ITEM/${_items[index].itemKey}');
            },
            child: SizedBox(
              height: 100,
              child: Row(
                key: Key(index.toString()),
                children: [
                  ExtendedImage.network(_items[index].imageDownloadUrls[0],
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                      // 'https://picsum.photos/100/100?random={$index+1}',
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(14.0))),
                  SizedBox(
                    width: userWidth * 0.02,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _items[index].title,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          _items[index].category,
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          _items[index].price.toString() + " 원",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.chat_bubble_outline, color: Colors.grey),
                            Text(
                              "123",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Icon(
                              Icons.favorite_outline,
                              color: Colors.grey,
                            ),
                            Text("13", style: TextStyle(color: Colors.grey)),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: _items.length,
      ),
    );
  }

  Widget _shimmerListView(double userWidth) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(userWidth * 0.04, userWidth * 0.04,
            userWidth * 0.04, userWidth * 0.04),
        separatorBuilder: (context, index) {
          return Divider(
            height: userWidth * 0.08,
            thickness: userWidth * 0.005,
            color: Colors.grey[200],
            indent: 0,
            endIndent: 0,
          );
        },
        itemBuilder: (context, index) {
          return SizedBox(
            height: 100,
            child: Row(
              key: Key(index.toString()),
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.0)),
                ),
                SizedBox(
                  width: userWidth * 0.02,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 18,
                          width: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3.0))),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                          height: 12,
                          width: 180,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3.0))),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                          height: 16,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3.0))),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              height: 13,
                              width: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3.0)))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
