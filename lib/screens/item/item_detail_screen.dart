import 'package:beamer/src/beamer.dart';
import 'package:blueberry/data/chatroom_model.dart';
import 'package:blueberry/data/item_model.dart';
import 'package:blueberry/data/user_model.dart';
import 'package:blueberry/repo/chat_service.dart';
import 'package:blueberry/repo/item_service.dart';
import 'package:blueberry/router/location.dart';
import 'package:blueberry/screens/item/similar_item.dart';
import 'package:blueberry/states/category_notifier.dart';
import 'package:blueberry/states/user_provider.dart';
import 'package:blueberry/utils/date_formatter.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatefulWidget {
  final String itemKey;
  const ItemDetailScreen(this.itemKey, {Key? key}) : super(key: key);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  PageController _controller = PageController();
  bool _isLikeClicked = false;
  Widget _divider = Divider(
    thickness: 1,
    height: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToChatroom(ItemModel itemModel, UserModel userModel) async {
    String chatroomKey =
        ChatroomModel.generateChatRoomKey(userModel.userKey, itemModel.itemKey);

    ChatroomModel _chatroomModel = ChatroomModel(
        itemImage: itemModel.imageDownloadUrls[0],
        itemTitle: itemModel.title,
        itemKey: itemModel.itemKey,
        itemAddress: itemModel.address,
        itemPrice: itemModel.price,
        sellerKey: itemModel.userKey,
        buyerKey: userModel.userKey,
        sellerImage:
            "https://minimaltoolkit.com/images/randomdata/male/101.jpg",
        buyerImage:
            "https://minimaltoolkit.com/images/randomdata/female/41.jpg",
        geoFirePoint: itemModel.geoFirePoint,
        chatroomKey: chatroomKey,
        lastMsgTime: DateTime.now());
    await ChatService().createNewChatroom(_chatroomModel);

    context.beamToNamed('/$LOCATION_ITEM/${widget.itemKey}/$chatroomKey');
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
                  bottomNavigationBar: bottomNav(
                      _size, itemModel), //Extracted (bottom in detail Page)
                  body: CustomScrollView(
                    slivers: [
                      sliverAppbar(itemModel, _size), //Extracted (AppBar)
                      sliverList(_size, itemModel), //Extracted (List)
                      SliverToBoxAdapter(
                        child: FutureBuilder<List<ItemModel>>(
                          future: ItemService().getuserItems(itemModel.userKey,
                              itemKey: widget.itemKey),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: _size.width / 26),
                                child: GridView.count(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  mainAxisSpacing: _size.width / 100,
                                  crossAxisSpacing: _size.width / 26,
                                  crossAxisCount: 2,
                                  childAspectRatio: 5 / 6,
                                  children: List.generate(
                                      snapshot.data!.length,
                                      (index) =>
                                          SimilarItem(snapshot.data![index])),
                                ),
                              );
                            } else {
                              return Center(
                                  child: Container(
                                child: Text("판매자의 다른 상품이 없습니다."),
                              ));
                            }
                          },
                        ),
                      ),

                      // SliverPadding(
                      //   padding:EdgeInsets.symmetric(horizontal: _size.width / 26),
                      //   sliver: SliverGrid.count(
                      //     mainAxisSpacing: _size.width / 100,
                      //     crossAxisSpacing: _size.width / 26,
                      //     crossAxisCount: 2,
                      //     childAspectRatio: 5 / 6,
                      //     children: List.generate(
                      //         itemModel.imageDownloadUrls.length,
                      //         (index) => SimilarItem(
                      //             index, itemModel.imageDownloadUrls[index])),
                      //   ),
                      // ),
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

  SliverList sliverList(Size _size, ItemModel itemModel) {
    return SliverList(
        delegate: SliverChildListDelegate([
      userInfo(_size, itemModel), //Extracted (UserInfo in detail Page)
      _divider,
      Padding(
          padding: EdgeInsets.all(_size.width / 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                itemModel.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: _size.width / 20),
              ),
              SizedBox(height: _size.width / 80),
              Row(
                children: [
                  Text(categoriesMapEngToKor[itemModel.category] ?? "미분류"),
                  Text(
                      ' · ${DateFormatter.dateForrmatter(itemModel.createdDate)}')
                ],
              ),
              SizedBox(height: _size.width / 20),
              Text(itemModel.detail,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: _size.width / 20),
              Text("조회 44")
            ],
          )),
      _divider,
      Padding(
        padding:
            EdgeInsets.only(left: _size.width / 24, right: _size.width / 24),
        child: TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () {},
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text("이 게시글 신고하기",
                    style: TextStyle(fontSize: _size.width / 24)))),
      ),
      _divider,
      Padding(
        padding:
            EdgeInsets.only(left: _size.width / 24, right: _size.width / 24),
        child: Row(
          children: [
            Text(
              '판매자의 다른 상품',
              style: TextStyle(fontSize: _size.width / 24),
            ),
            Expanded(child: Container()),
            TextButton(onPressed: () {}, child: Text('더보기'))
          ],
        ),
      ),
    ]));
  }

  Padding userInfo(Size _size, ItemModel itemModel) {
    return Padding(
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
                      fontWeight: FontWeight.bold, fontSize: _size.width / 26)),
              Text(
                categoriesMapEngToKor[itemModel.category] ?? "미분류",
                style:
                    TextStyle(color: Colors.grey, fontSize: _size.width / 30),
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
                          borderRadius: BorderRadius.circular(1),
                          child: LinearProgressIndicator(
                            color: Colors.purple,
                            value: 0.373,
                            minHeight: 3,
                            backgroundColor: Colors.grey[200],
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
    );
  }

  SliverAppBar sliverAppbar(ItemModel itemModel, Size _size) {
    return SliverAppBar(
      title: Text(itemModel.title),
      expandedHeight: _size.width,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(children: [
          PageView.builder(
            controller: _controller,
            allowImplicitScrolling: true, //이미지 넘길때 로딩 시간을 줄여준다.
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
    );
  }

  SafeArea bottomNav(Size _size, ItemModel itemModel) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 40,
              offset: Offset(0, 3),
            ),
          ],
        ),
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
                  onPressed: () {
                    UserModel userModel =
                        context.read<UserProvider>().userModel!;
                    _goToChatroom(itemModel, userModel);
                  },
                  child: Text("채팅으로 거래하기"))
              //expanded_container
              //button
            ],
          ),
        ),
      ),
    );
  }
}
