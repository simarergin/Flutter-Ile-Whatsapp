import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/services/chat_service.dart';
import 'package:flutter_application_1/models/conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/viewmodels/base_model.dart';
import 'package:get_it/get_it.dart';

class ChatsModel extends BaseModel {
  final ChatService _db = GetIt.instance<ChatService>();

  Stream<List<Conversation>> conversation(String userId) {
    return _db.getConversations(userId);
  }
}
