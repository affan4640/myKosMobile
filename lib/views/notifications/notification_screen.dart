import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Data mock notifikasi
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Pembayaran Berhasil! 🎉',
      'desc':
          'Pembayaran untuk Kost Nyaman Setiabudi bulan ini telah dikonfirmasi.',
      'time': 'Baru saja',
      'type': 'success',
      'isRead': false,
    },
    {
      'title': 'Pesan Baru dari Pemilik',
      'desc': 'Pemilik Kost Putri Mandiri membalas pesan Anda.',
      'time': '2 jam yang lalu',
      'type': 'chat',
      'isRead': false,
    },
    {
      'title': 'Jatuh Tempo Pembayaran',
      'desc':
          'Sewa kamar Anda akan berakhir dalam 3 hari. Segera lakukan perpanjangan.',
      'time': '1 hari yang lalu',
      'type': 'warning',
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all, color: AppColors.primary),
            onPressed: () {
              setState(() {
                for (var notif in notifications) {
                  notif['isRead'] = true;
                }
              });
              Get.snackbar(
                'Berhasil',
                'Semua notifikasi telah ditandai sebagai dibaca',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Dismissible(
            key: Key('${notif['title']}_$index'),
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
                          child: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Hapus Notifikasi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Apakah Anda yakin ingin menghapus notifikasi ini?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  side: BorderSide(color: Colors.grey.shade300),
                                ),
                                onPressed: () => Get.back(result: false),
                                child: const Text(
                                  'Batal',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () => Get.back(result: true),
                                child: const Text(
                                  'Hapus',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
              setState(() {
                notifications.removeAt(index);
              });
              Get.snackbar(
                'Berhasil',
                'Notifikasi telah dihapus',
                backgroundColor: Colors.green,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(16),
              );
            },
            child: _buildNotificationItem(notif),
          );
        },
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notif) {
    IconData icon;
    Color iconColor;
    Color bgColor;

    switch (notif['type']) {
      case 'success':
        icon = Icons.check_circle_outline;
        iconColor = Colors.green;
        bgColor = Colors.green.withAlpha((0.1 * 255).round());
        break;
      case 'warning':
        icon = Icons.warning_amber_rounded;
        iconColor = AppColors.warning;
        bgColor = AppColors.warning.withAlpha((0.1 * 255).round());
        break;
      case 'chat':
        icon = Icons.chat_bubble_outline;
        iconColor = AppColors.primary;
        bgColor = AppColors.primary.withAlpha((0.1 * 255).round());
        break;
      default:
        icon = Icons.notifications_none;
        iconColor = Colors.grey;
        bgColor = Colors.grey.withAlpha((0.1 * 255).round());
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notif['isRead']
            ? Colors.white
            : AppColors.primary.withAlpha((0.03 * 255).round()),
        borderRadius: BorderRadius.circular(16),
        border: notif['isRead']
            ? Border.all(color: Colors.grey.shade200)
            : Border.all(
                color: AppColors.primary.withAlpha((0.3 * 255).round()),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 24),
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
                        notif['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      notif['time'],
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  notif['desc'],
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
