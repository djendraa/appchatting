import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByUsername(String username) async {
    return await Firestore.instance.collection("users")
      .where("name", isEqualTo: username )
      .getDocuments();
  }

  getUserByUserEmail(String userEmail) async {
    return await Firestore.instance.collection("users")
      .where("email", isEqualTo: userEmail )
      .getDocuments();
  }

  uploadUserInfo(userMap){
    Firestore.instance.collection("users")
      .add(userMap).catchError((e){
        print(e.toString());
      });
  }

  createChatRoom(String chatRoomId, chatRoomMap){
    Firestore.instance.collection("ChatRoom")
      .document(chatRoomId).setData(chatRoomMap).catchError((e){
        print(e.toString());
      });
  }

  addConversationMessage(String chatRoomId, mesaageMap){
    Firestore.instance.collection("ChatRoom")
    .document(chatRoomId)
    .collection("chats")
    .add(mesaageMap).catchError((e){print(e.toString());
    });
  }

  getConversationMessage(String chatRoomId) async {
    return Firestore.instance.collection("ChatRoom")
    .document(chatRoomId)
    .collection("chats")
    .orderBy("time")
    .snapshots();
  }

  getChatRooms(String userName) async {
    return Firestore.instance.collection("ChatRoom")
    .where("users", arrayContains: userName)
    .snapshots();
  }
}