import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import 'chat_detail_screen.dart';
import '../../controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatC = Get.put(ChatController());

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pesan',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                onChanged: chatC.updateSearchQuery,
                decoration: const InputDecoration(
                  hintText: 'Cari obrolan...',
                  hintStyle: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final filteredChatList = chatC.filteredChatList;
              
              if (filteredChatList.isEmpty) {
                return const Center(
                  child: Text(
                    'Tidak ada obrolan ditemukan.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                );
              }
              
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 12),
                itemCount: filteredChatList.length,
                itemBuilder: (context, index) {
                  final chat = filteredChatList[index];
                  return Dismissible(
                    key: Key(chat.name),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return await Get.dialog<bool>(
                        Dialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withAlpha((0.1 * 255).round()),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.delete_outline, color: Colors.red, size: 32),
                                ),
                                const SizedBox(height: 20),
                                const Text('Hapus Obrolan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                const Text(
                                  'Apakah Anda yakin ingin menghapus obrolan ini secara permanen?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: AppColors.textSecondary, height: 1.5),
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), side: BorderSide(color: Colors.grey.shade300)),
                                        onPressed: () => Get.back(result: false),
                                        child: const Text('Batal', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                                        onPressed: () => Get.back(result: true),
                                        child: const Text('Hapus', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    onDismissed: (direction) {
                      chatC.deleteChat(chat.name);
                      Get.snackbar(
                        'Berhasil',
                        'Obrolan dengan ${chat.name} telah dihapus',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                    child: InkWell(
                      onTap: () => Get.to(() => const ChatDetailScreen()),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(chat.avatar),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          chat.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        chat.time,
                                        style: TextStyle(
                                          color: chat.unread > 0
                                              ? AppColors.primary
                                              : AppColors.textSecondary,
                                          fontSize: 12,
                                          fontWeight: chat.unread > 0
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          chat.lastMessage,
                                          style: TextStyle(
                                            color: chat.unread > 0
                                                ? AppColors.textPrimary
                                                : AppColors.textSecondary,
                                            fontWeight: chat.unread > 0
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (chat.unread > 0)
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: const BoxDecoration(
                                            color: AppColors.primary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            chat.unread.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
