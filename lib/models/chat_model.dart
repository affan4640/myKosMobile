class ChatModel {
  final String name;
  final String lastMessage;
  final String time;
  final int unread;
  final String avatar;

  ChatModel({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unread,
    required this.avatar,
  });
}
