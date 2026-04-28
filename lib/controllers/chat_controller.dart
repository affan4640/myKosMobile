import 'package:get/get.dart';
import '../models/chat_model.dart';

class ChatController extends GetxController {
  var searchQuery = ''.obs;

  var chatList = <ChatModel>[
    ChatModel(
      name: 'Kost Nyaman Setiabudi',
      lastMessage: 'Boleh, kapan ya? 😊',
      time: '10:37',
      unread: 2,
      avatar:
          'https://images.unsplash.com/photo-1522771731470-4202111d4408?auto=format&fit=crop&w=100&q=60',
    ),
    ChatModel(
      name: 'Kost Putri Mandiri',
      lastMessage: 'Terima kasih, saya tunggu kabarnya.',
      time: 'Kemarin',
      unread: 0,
      avatar:
          'https://images.unsplash.com/photo-1518780664697-55e3ad937233?auto=format&fit=crop&w=100&q=60',
    ),
    ChatModel(
      name: 'Green Kost Kemang',
      lastMessage: 'Sama-sama kak, ditunggu kedatangannya.',
      time: '20/04',
      unread: 0,
      avatar:
          'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?auto=format&fit=crop&w=100&q=60',
    ),
  ].obs;

  List<ChatModel> get filteredChatList {
    if (searchQuery.value.isEmpty) return chatList;
    return chatList
        .where(
          (chat) =>
              chat.name.toLowerCase().contains(searchQuery.value.toLowerCase()),
        )
        .toList();
  }

  void updateSearchQuery(String query) => searchQuery.value = query;

  void deleteChat(String name) =>
      chatList.removeWhere((item) => item.name == name);
}
