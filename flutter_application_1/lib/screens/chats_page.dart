import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/conversation.dart';
import 'package:flutter_application_1/screens/conversation_page.dart';
import 'package:flutter_application_1/viewmodels/chats_model.dart';
import 'package:flutter_application_1/viewmodels/sign_in_model.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ChatsPage extends StatelessWidget {
  //final String userId = "tAWY0UsRR4Qg3cMg0M5tPTiAL573";
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = GetIt.instance<ChatsModel>();
    var user = Provider.of<SignInModel>(context).currentUser;

    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: StreamBuilder<List<Conversation>>(
        stream: model.conversation(user!.uid),
        // stream: FirebaseFirestore.instance
        //     .collection('conversations')
        //     .where('members', arrayContains: userId)
        //     //array içinde filtreleme yaptık.
        //     .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Conversation>> snapshot) {
          var messageArray = [];

          if (snapshot.connectionState == ConnectionState.active) {
            print("lenght: " + snapshot.data!.length.toString());

            for (var i = 0; i < snapshot.data!.length; i++) {
              // messageArray
              //     .add(Text(snapshot.data!.docs[i]["message"].toString()));
              messageArray.add({
                // "name": snapshot.data!.docs[i]["name"] != null
                //   ? snapshot.data!.docs[i]["name"].toString()
                //   : "",
                "id": snapshot.data![i].id ?? "bos",
                "name": snapshot.data![i].userName ?? "bos",
                "message": snapshot.data?[i].displayMessage != null
                    ? snapshot.data![i].displayMessage.toString()
                    : "",
              });
            }
          }

          return ListView(
              children: messageArray
                  .map(
                    (doc) => ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'http://docs.kariyer.net/job/jobtemplate/000/000/026/avatar/2618720210105090140285.jpeg'),
                      ),
                      title: Text(doc["name"] ?? "bos"),
                      subtitle: Text(doc["message"] ?? "bos"),
                      trailing: Column(
                        children: <Widget>[
                          Text('19:30'),
                          Container(
                            width: 20,
                            height: 20,
                            margin: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).accentColor),
                            child: Center(
                              child: Text(
                                '16',
                                textScaleFactor: 0.8,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (content) => ConversationPage(
                                      userId: user.uid,
                                      // conversationId: doc["id"],
                                      conversation: doc,
                                    )
                                //conversationId bizim dokumana verilen ıd.Bunu doc.documentId den
                                // cekıp conversationpage e gonderıyoruz.
                                ));
                      },
                    ),
                  )
                  .toList());
        },
      ),
    );
  }
}






// snapshot.data!.docs[0]["message"].toString()

// .documents,
//               .map((doc) => ListTile(
//                     title: Text(doc['name']),
//                     subtitle: Text(doc['message']),
//                   ))
//               .toList(),

 // return ListView(
        //   children: snapshot.data!.docs[0]
        // );

        // FirebaseFirestore.instance
        //     .collection('chats')
        //     .snapshots()
        //     .listen((event) {
        //   event.docChanges.forEach((res) {
        //     if (res.type == DocumentChangeType.modified) {
        //       // added
        //       print("document modified");
        //     }
        //   });
        // });

// .documents,
//               .map((doc) => ListTile(
//                     title: Text(doc['name']),
//                     subtitle: Text(doc['message']),
//                   ))
//               .toList(),