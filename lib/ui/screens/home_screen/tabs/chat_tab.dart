import 'dart:math';

import 'package:bigfoot_dashboard/data/models/chat.dart';
import 'package:bigfoot_dashboard/data/models/message.dart';
import 'package:bigfoot_dashboard/ui/screens/chat_screen.dart';
import 'package:bigfoot_dashboard/ui/widgets/chat_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirestoreListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        query: _chatsQuery,
        emptyBuilder: (context) => Center(
          child: Text(
            'No chats yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        itemBuilder: (context, snapshot) {
          return Column(
            children: [
              ChatItem(
                chat: snapshot.data(),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ChatScreen.routeName,
                    arguments: {
                      'chat': snapshot.data(),
                      'chatId': snapshot.id,
                    },
                  );
                },
              ),
              const Divider(),
            ],
          );
        },
      ),
      floatingActionButton: kDebugMode
          ? FloatingActionButton(
              onPressed: _addTestChat,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Query<Chat> get _chatsQuery {
    return FirebaseFirestore.instance
        .collection('chats')
        .orderBy('lastMessage.createdAt', descending: true)
        .withConverter<Chat>(
          fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
          toFirestore: (chat, _) => chat.toJson(),
        );
  }

  void _addTestChat() {
    final chat = Chat(
      clientId: 'testClientId',
      clientName: 'Test Client',
      productId: Random().nextInt(1000000000).toString(),
      lastMessage: Message(
        message: 'TESTING ⚠',
        createdAt: Timestamp.now(),
        senderId: FirebaseAuth.instance.currentUser!.uid,
      ),
    );

    FirebaseFirestore.instance.collection('chats').add(chat.toJson());
  }
}
