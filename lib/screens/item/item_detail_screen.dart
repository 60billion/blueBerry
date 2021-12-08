import 'package:blueberry/data/item_model.dart';
import 'package:blueberry/repo/item_service.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemDetailScreen extends StatefulWidget {
  final String itemKey;
  const ItemDetailScreen(this.itemKey, {Key? key}) : super(key: key);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  PageController _controller = PageController();
  bool _isLikeClicked = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ItemModel>(
        future: ItemService().getItem(widget.itemKey),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ItemModel itemModel = snapshot.data!;
            return LayoutBuilder(builder: (context, constraints) {
              Size _size = MediaQuery.of(context).size;
              return SafeArea(
                child: Scaffold(
                  bottomNavigationBar: SafeArea(
                    top: false,
                    bottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey[300]!))),
                      height: _size.width / 6,
                      child: Padding(
                        padding: EdgeInsets.all(_size.width / 36),
                        child: Row(
                          children: [
                            //icon
                            IconButton(
                              icon: _isLikeClicked
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.purple,
                                    )
                                  : Icon(Icons.favorite_outline),
                              color: Colors.grey,
                              iconSize: _size.width / 12,
                              onPressed: () {
                                _isLikeClicked = !_isLikeClicked;
                                setState(() {});
                              },
                            ),
                            VerticalDivider(
                              width: _size.width / 18,
                              thickness: 1.0,
                              color: Colors.grey,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itemModel.price.toString() + ' 원',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: _size.width / 24),
                                ),
                                Text(
                                  itemModel.negotiable ? "가격제안가능" : "가격제안불가",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            Expanded(child: Container()),
                            ElevatedButton(
                                onPressed: () {}, child: Text("채팅으로 거래하기"))
                            //expanded_container
                            //button
                          ],
                        ),
                      ),
                    ),
                  ),
                  body: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        title: Text(itemModel.title),
                        expandedHeight: _size.width,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(children: [
                            PageView.builder(
                              controller: _controller,
                              allowImplicitScrolling:
                                  true, //이미지 넘길때 로딩 시간을 줄여준다.
                              itemBuilder: (context, index) {
                                return ExtendedImage.network(
                                  itemModel.imageDownloadUrls[index],
                                  fit: BoxFit.cover,
                                  scale: 0.1,
                                );
                              },
                              itemCount: itemModel.imageDownloadUrls.length,
                            ),
                            Positioned(
                              bottom: 16,
                              left: 0,
                              right: 0,
                              child: Container(
                                child: Center(
                                  child: SmoothPageIndicator(
                                      controller: _controller,
                                      count: itemModel.imageDownloadUrls.length,
                                      effect: WormEffect(
                                          activeDotColor: Colors.purple,
                                          dotColor: Colors.white60),
                                      onDotClicked: (index) {}),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Padding(
                          padding: EdgeInsets.all(_size.width / 24),
                          child: Row(
                            children: [
                              ExtendedImage.network(
                                itemModel.imageDownloadUrls[0],
                                fit: BoxFit.cover,
                                width: _size.width / 10,
                                height: _size.width / 10,
                                shape: BoxShape.circle,
                              ),
                              SizedBox(
                                width: _size.width / 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(itemModel.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: _size.width / 26)),
                                  Text(
                                    itemModel.category,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: _size.width / 30),
                                  )
                                ],
                              ),
                              Expanded(child: Container()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: _size.width / 10,
                                        child: Column(
                                          children: [
                                            Text(
                                              '37.3°C',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.purple),
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(1),
                                              child: LinearProgressIndicator(
                                                color: Colors.purple,
                                                value: 0.373,
                                                minHeight: 3,
                                                backgroundColor:
                                                    Colors.grey[200],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: _size.width / 100,
                                      ),
                                      Icon(
                                        Icons.mood_rounded,
                                        color: Colors.purple,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: _size.width / 100,
                                  ),
                                  Text(
                                    "매너온도",
                                    style: TextStyle(
                                        fontSize: _size.width / 30,
                                        decoration: TextDecoration.underline),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: _size.height * 2,
                          color: Colors.white,
                        )
                      ]))
                    ],
                  ),
                ),
              );
            });
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
