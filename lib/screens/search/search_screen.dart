import 'package:blueberry/data/item_model.dart';
import 'package:blueberry/repo/algolia_service.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

final TextEditingController _textEditingController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  List<ItemModel> items = [];

  @override
  Widget build(BuildContext context) {
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
                  items = await AlgoliaService().queryItems(value);
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
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index].title),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: items.length),
    );
  }
}
