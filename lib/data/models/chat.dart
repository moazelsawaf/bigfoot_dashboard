import 'package:bigfoot_dashboard/data/models/message.dart';

class Chat {
  final String orderId;
  final String clientId;
  final String clientName;
  final Message lastMessage;

  const Chat({
    required this.orderId,
    required this.clientId,
    required this.clientName,
    required this.lastMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      orderId: json['orderId'],
      clientId: json['clientId'],
      clientName: json['clientName'],
      lastMessage: Message.fromJson(json['lastMessage']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'clientId': clientId,
      'clientName': clientName,
      'lastMessage': lastMessage.toJson(),
    };
  }
}
