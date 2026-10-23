import 'package:flutter/material.dart';
import '../theme.dart';
import 'notifications_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 46,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    'P',
                    style: TextStyle(color: Colors.white, fontSize: 36),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Pedro Silva',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.navy,
                  ),
                ),
                Text(
                  'pedro@email.com',
                  style: TextStyle(color: AppColors.muted),
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Color(0xFFE0A100), size: 18),
                    SizedBox(width: 4),
                    Text(
                      '4.9 • 23 trabalhos',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _tile(Icons.person_outline, 'Editar perfil', () {}),
          _tile(Icons.badge_outlined, 'Documentos e verificação', () {}),
          _tile(
            Icons.notifications_outlined,
            'Notificações',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            ),
          ),
          _tile(Icons.payment_outlined, 'Métodos de pagamento', () {}),
          _tile(Icons.help_outline, 'Ajuda e suporte', () {}),
          _tile(
            Icons.logout,
            'Sair',
            () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
            danger: true,
          ),
        ],
      ),
    );
  }

  Widget _tile(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool danger = false,
  }) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: danger ? Colors.red : AppColors.primary),
        title: Text(
          title,
          style: TextStyle(
            color: danger ? Colors.red : AppColors.navy,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
