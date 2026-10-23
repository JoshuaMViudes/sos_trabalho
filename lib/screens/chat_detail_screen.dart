import 'package:flutter/material.dart';
import '../models.dart';
import '../theme.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatConversation chat;
  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _c = TextEditingController();
  final List<Map<String, dynamic>> _msgs = [
    {'me': false, 'txt': 'Olá! Tudo bem?'},
    {'me': true, 'txt': 'Oi! Tudo sim, vi sua vaga.'},
    {'me': false, 'txt': 'Pode começar amanhã às 8h?'},
  ];

  void _send() {
    if (_c.text.trim().isEmpty) return;
    setState(() {
      _msgs.add({'me': true, 'txt': _c.text});
      _c.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chat.name)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: _msgs.length,
              itemBuilder: (_, i) {
                final m = _msgs[i];
                final me = m['me'] as bool;
                return Align(
                  alignment: me ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: me ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      m['txt'],
                      style: TextStyle(
                        color: me ? Colors.white : AppColors.navy,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _c,
                    decoration: const InputDecoration(
                      hintText: 'Digite uma mensagem...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _send,
                  icon: const Icon(Icons.send, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
