import 'package:flutter/material.dart';
import '../theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        'Nova vaga perto de você',
        'Ajudante de mudança • R\$150',
        Icons.work_outline,
        '10 min',
      ),
      (
        'Candidatura aprovada!',
        'Mercado Central aceitou você',
        Icons.check_circle_outline,
        '1 h',
      ),
      (
        'Nova mensagem',
        'João enviou uma mensagem',
        Icons.chat_bubble_outline,
        '2 h',
      ),
      ('Lembrete', 'Seu turno começa amanhã às 8h', Icons.alarm, 'ontem'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Notificações')),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, i) {
          final it = items[i];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(.15),
              child: Icon(it.$3, color: AppColors.primary),
            ),
            title: Text(
              it.$1,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(it.$2),
            trailing: Text(
              it.$4,
              style: const TextStyle(fontSize: 11, color: AppColors.muted),
            ),
          );
        },
      ),
    );
  }
}
