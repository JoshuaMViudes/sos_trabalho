import 'package:flutter/material.dart';
import '../models.dart';
import '../theme.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mensagens')),
      body: ListView.separated(
        itemCount: kChats.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, i) {
          final c = kChats[i];
          return ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChatDetailScreen(chat: c)),
            ),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text(
                c.name[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              c.name,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              c.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  c.time,
                  style: const TextStyle(fontSize: 11, color: AppColors.muted),
                ),
                if (c.unread > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${c.unread}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
