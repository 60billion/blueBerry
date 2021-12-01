import 'package:flutter/material.dart';

class MultiImageSelect extends StatelessWidget {
  const MultiImageSelect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      double width = MediaQuery.of(context).size.width;
      return SizedBox(
        height: width / 3,
        width: width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.grey,
                    ),
                    Text(
                      "0/10",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                width: width / 3 - 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
              ),
            ),
            Container(
              width: 100,
              color: Colors.green,
            ),
            Container(
              width: 100,
              color: Colors.yellow,
            ),
            Container(
              width: 100,
              color: Colors.pink,
            ),
            Container(
              width: 100,
              color: Colors.green,
            )
          ],
        ),
      );
    });
  }
}
