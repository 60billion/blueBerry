import 'package:beamer/src/beamer.dart';
import 'package:blueberry/data/chatroom_model.dart';
import 'package:blueberry/data/user_model.dart';
import 'package:blueberry/repo/chat_service.dart';
import 'package:blueberry/states/user_provider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String myUserKey = context.read<UserProvider>().userModel!.userKey;
    return FutureBuilder<List<ChatroomModel>>(
        future: ChatService().getMyChatList(myUserKey),
        builder: (context, snapshot) {
          Size size = MediaQuery.of(context).size;
          return Scaffold(
            body: ListView.separated(
                itemBuilder: (context, index) {
                  ChatroomModel chatroomModel = snapshot.data![index];
                  bool iamBuyer = chatroomModel.buyerKey == myUserKey;

                  return ListTile(
                    onTap: () {
                      context.beamToNamed('/${chatroomModel.chatroomKey}');
                    },
                    leading: ExtendedImage.network(
                      "https://randomuser.me/api/portraits/women/32.jpg",
                      shape: BoxShape.circle,
                      fit: BoxFit.cover,
                      width: size.width / 8,
                      height: size.width / 8,
                    ),
                    trailing: ExtendedImage.network(
                      chatroomModel.itemImage,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4),
                      fit: BoxFit.cover,
                      width: size.width / 8,
                      height: size.width / 8,
                    ),
                    subtitle: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: iamBuyer ? "셀러: 데이터 미정" : "바이어: 데이터 미정",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: "   "),
                            TextSpan(
                                text: "어제 · ${chatroomModel.itemAddress}",
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey))
                          ]),
                    ),
                    title: Text(
                      chatroomModel.lastMsg,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey,
                  );
                },
                itemCount: snapshot.hasData ? snapshot.data!.length : 0),
          );
        });
  }
}
