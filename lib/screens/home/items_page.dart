// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:blueberry/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      double userWidth = MediaQuery.of(context).size.width;
      logger.d(userWidth);

      return ListView.separated(
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
                ExtendedImage.network(
                    'https://picsum.photos/100/100?random={$index+1}',
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
                        "Number: $index",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        "Number: $index",
                        style: TextStyle(fontSize: 12.0),
                      ),
                      Text(
                        "$index ,000원",
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
          );
        },
        itemCount: 10,
      );
    });
  }
}
