import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;
  const JobDetailScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Vaga')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (job.urgent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE8D0),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                '⚡ VAGA URGENTE',
                style: TextStyle(
                  color: Color(0xFF9A4E0A),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          const SizedBox(height: 12),
          Text(
            job.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            job.company,
            style: const TextStyle(color: AppColors.muted, fontSize: 15),
          ),
          const SizedBox(height: 20),
          _info(Icons.location_on_outlined, 'Local', job.location),
          _info(Icons.schedule, 'Horário', job.schedule),
          _info(Icons.payments_outlined, 'Pagamento', job.payment),
          _info(
            Icons.star_rounded,
            'Avaliação do contratante',
            '${job.rating} ⭐',
          ),
          const Divider(height: 32),
          const Text(
            'Descrição',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.navy,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            job.description,
            style: const TextStyle(color: AppColors.muted, height: 1.5),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 50,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: job.urgent
                    ? AppColors.accent
                    : AppColors.primary,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Candidatura enviada!')),
                );
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check),
              label: const Text('Candidatar-me agora'),
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_outline),
            label: const Text('Falar com o contratante'),
          ),
        ],
      ),
    );
  }

  Widget _info(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w700,
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
