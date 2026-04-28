import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1522771731470-4202111d4408?auto=format&fit=crop&w=100&q=60',
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kost Nyaman Setiabudi',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(color: Colors.green.shade600, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildChatBubble(
                  'Halo, saya tertarik dengan kamar ini. Apakah masih tersedia?',
                  true,
                  '10:30',
                ),
                _buildChatBubble('Halo! Masih tersedia ya 😊', false, '10:32'),
                _buildChatBubble(
                  'Apa saja fasilitas yang didapatkan kak?',
                  true,
                  '10:33',
                ),
                _buildChatBubble(
                  'Fasilitas lengkap: Wi-Fi, AC, kamar mandi dalam, dapur, dan parkir ya.',
                  false,
                  '10:35',
                ),
                _buildChatBubble(
                  'Baik, boleh saya jadwalkan untuk lihat langsung?',
                  true,
                  '10:36',
                ),
                _buildChatBubble('Boleh, kapan ya? 😊', false, '10:37'),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isMe, String time) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16),
          ),
          boxShadow: isMe
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.05 * 255).round()),
                    blurRadius: 5,
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.white : AppColors.textPrimary,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: isMe ? Colors.white70 : AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(Icons.attach_file, color: AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Ketik pesan...',
                  hintStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            CircleAvatar(
              backgroundColor: AppColors.primary,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 18),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
