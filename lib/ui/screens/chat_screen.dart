import 'package:bigfoot_dashboard/data/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/models/chat.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isInit = false;
  late Chat _chat;
  late String _chatId;
  final _textEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _chat = arguments['chat'] as Chat;
      _chatId = arguments['chatId'] as String;
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_chat.clientName),
        actions: [
          if (kDebugMode)
            IconButton(
              onPressed: _addTestClientReply,
              icon: const Icon(Icons.add),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FirestoreListView(
              query: _messagesQuery,
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemBuilder: (context, snapshot) {
                final message = snapshot.data();
                return MessageBubble(
                  createdAt: message.createdAt,
                  senderId: message.senderId,
                  message: message.message,
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Type a message ...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_textEditingController.text.trim().isEmpty) return;

    final message = Message(
      message: _textEditingController.text,
      createdAt: Timestamp.now(),
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );

    final chat = FirebaseFirestore.instance.collection('chats').doc(_chatId);

    chat.collection('messages').add(message.toJson());
    chat.update({'lastMessage': message.toJson()});

    _textEditingController.clear();
  }

  Query<Message> get _messagesQuery {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(_chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .withConverter<Message>(
          fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
          toFirestore: (message, _) => message.toJson(),
        );
  }

  void _addTestClientReply() {
    final message = Message(
      message: 'TESTING FROM CLIENT ⚠',
      createdAt: Timestamp.now(),
      senderId: _chat.clientId,
    );

    final chat = FirebaseFirestore.instance.collection('chats').doc(_chatId);

    chat.collection('messages').add(message.toJson());
    chat.update({'lastMessage': message.toJson()});
  }
}
