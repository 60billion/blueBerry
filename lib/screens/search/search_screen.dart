import 'package:beamer/src/beamer.dart';
import 'package:blueberry/data/item_model.dart';
import 'package:blueberry/repo/algolia_service.dart';
import 'package:blueberry/router/location.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

final TextEditingController _textEditingController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  List<ItemModel> items = [];
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    double userWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Container(
            child: Center(
              child: TextFormField(
                controller: _textEditingController,
                onFieldSubmitted: (value) async {
                  logger.d(value);
                  isProcessing = true;
                  setState(() {});
                  List<ItemModel> newitems =
                      await AlgoliaService().queryItems(value);
                  if (newitems.isNotEmpty) {
                    items.clear();
                    items.addAll(newitems);
                  }
                  isProcessing = false;
                  setState(() {});
                },
                decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    hintText: '아이템 검색',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.purple))),
              ),
            ),
          ),
        ),
      ),
      body: (isProcessing == true)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              ),
            )
          : ListView.separated(
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
                    context.beamToNamed(
                        '/$LOCATION_SEARCH/${items[index].itemKey}');
                  },
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      key: Key(index.toString()),
                      children: [
                        ExtendedImage.network(items[index].imageDownloadUrls[0],
                            height: 100.0,
                            width: 100.0,
                            fit: BoxFit.cover,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0))),
                        SizedBox(
                          width: userWidth * 0.02,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items[index].title,
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Text(
                                items[index].category,
                                style: TextStyle(fontSize: 12.0),
                              ),
                              Text(
                                items[index].price.toString() + " 원",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.chat_bubble_outline,
                                      color: Colors.grey),
                                  Text(
                                    "123",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Icon(
                                    Icons.favorite_outline,
                                    color: Colors.grey,
                                  ),
                                  Text("13",
                                      style: TextStyle(color: Colors.grey)),
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
              itemCount: items.length,
            ),
    );
  }
}
