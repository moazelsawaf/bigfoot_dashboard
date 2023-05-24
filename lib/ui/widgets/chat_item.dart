import 'package:bigfoot_dashboard/data/models/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatItem extends StatelessWidget {
  final Chat chat;
  final VoidCallback? onTap;

  const ChatItem({
    super.key,
    required this.chat,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      isThreeLine: true,
      title: Text(
        chat.clientName,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text('Order #${chat.orderId}'),
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(children: [
              if (_isSentByMe)
                const TextSpan(text: 'You: ')
              else
                TextSpan(text: '${chat.clientName.split(' ')[0]}: '),
              TextSpan(text: chat.lastMessage.message)
            ]),
          ),
        ],
      ),
      trailing: Column(
        children: [
          Text(
            timeago.format(chat.lastMessage.createdAt.toDate()),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  bool get _isSentByMe =>
      chat.lastMessage.senderId == FirebaseAuth.instance.currentUser!.uid;
}
