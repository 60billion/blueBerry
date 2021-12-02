import 'package:beamer/beamer.dart';
import 'package:blueberry/states/category_notifier.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class CategoryInputScreen extends StatelessWidget {
  const CategoryInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("카테고리"),
          centerTitle: true,
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                context.read<CategoryNotifier>().setNewCategoryWithKor(
                    categoriesMapEngToKor.values.elementAt(index));
                logger.d(categoriesMapEngToKor.values.elementAt(index));
                Beamer.of(context).beamBack();
              },
              title: Text(
                categoriesMapEngToKor.values.elementAt(index),
                style: TextStyle(
                    color:
                        context.read<CategoryNotifier>().currentCategoryInKor ==
                                categoriesMapEngToKor.values.elementAt(index)
                            ? Colors.purple
                            : Colors.black87),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            );
          },
          itemCount: categoriesMapEngToKor.length,
        ));
  }
}

const List<String> categoriesKor = [
  '선택',
  '가구',
  '전자기기',
  '유아동',
  '스포츠',
  '여성',
  '남성',
  '메이크업'
];
