import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/viewmodels/conversation_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../core/services/locator.dart';

//kişiler arası sohbeti listelediğimiz widget.
class ConversationPage extends StatefulWidget {
  String? userId;
  String? conversationId;

  ConversationPage(
      {Key? key, this.userId, this.conversationId, required conversation})
      : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _editingController = TextEditingController();
  CollectionReference? _ref;
  late FocusNode _focusNode;
  late ScrollController _scrollController = ScrollController();
  //bu metod sayesinde atılan mesaj en sona kaydırılarak gösterilir.

  @override
  void initState() {
    _ref = FirebaseFirestore.instance
        .collection('conversations/${widget.conversationId}/messages');

    _focusNode = FocusNode();

    // _scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();

    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var model = getIt<ConversationModel>();
    return ChangeNotifierProvider(
      create: (BuildContext context) => getIt<ConversationModel>(),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: -5,
          title: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'http://docs.kariyer.net/job/jobtemplate/000/000/026/avatar/2618720210105090140285.jpeg'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 9.0),
                child: Text('Tersan Tersanesi'),
              )
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                child: Icon(Icons.phone),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                child: Icon(Icons.camera_alt),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                child: Icon(Icons.more_vert),
                onTap: () {},
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'http://docs.kariyer.net/job/jobtemplate/000/000/026/avatar/2618720210105090140285.jpeg'))),
          child: Column(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: (() => _focusNode.unfocus()),
                  child: StreamBuilder(
                      //Bu degisiklikler sayesinde mesaj sayisi kadar ekranda mesaj gözükecek.
                      stream: model.getConversation(widget.conversationId),
                      // stream: model.getConversation(widget.conversation.id),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return !snapshot.hasData
                            ? CircularProgressIndicator()
                            : ListView(
                                controller: _scrollController,
                                children: snapshot.data!.docs
                                    .map(
                                      (document) => ListTile(
                                        title: Align(
                                            //userıd document senderıd ye esitse sola degilse saga yaslar.
                                            alignment: widget.userId !=
                                                    document['senderId']
                                                ? Alignment.centerLeft
                                                : Alignment.centerRight,
                                            child: Container(
                                                padding: EdgeInsets.all(9),
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.horizontal(
                                                            left:
                                                                Radius.circular(
                                                                    10),
                                                            right:
                                                                Radius.circular(
                                                                    10))),
                                                child: Text(
                                                  document['message'],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))),
                                      ),
                                    )
                                    .toList(),
                              );
                      }),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(25),
                          right: Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: InkWell(
                              child: Icon(
                                Icons.tag_faces,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                                focusNode: _focusNode,
                                controller: _editingController,
                                decoration: InputDecoration(
                                    hintText: ' Type a message ',
                                    border: InputBorder.none)),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.attach_file,
                              color: Colors.white,
                            ),
                            onTap: () => model.uploadMedia,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: InkWell(
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                              onTap: () => model.uploadMedia,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await model.add({
                          'senderId': widget.userId,
                          'message': _editingController.text,
                          'timeStamp': DateTime.now(),
                          //mesajların gönderilme zamanı eklenmis oldu.
                        });
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(microseconds: 200),
                            curve: Curves.easeIn);

                        _editingController.text = ' ';
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
