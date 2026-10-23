import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Minhas Candidaturas'),
          bottom: const TabBar(
            labelColor: AppColors.primary,
            tabs: [
              Tab(text: 'Em Análise'),
              Tab(text: 'Aprovadas'),
              Tab(text: 'Recusadas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _list(
              ['Ajudante de mudança', 'Diarista'],
              'Aguardando resposta',
              Colors.orange,
            ),
            _list(
              ['Atendente de loja'],
              'Aprovado! Compareça amanhã',
              Colors.green,
            ),
            _list(['Auxiliar admin'], 'Vaga preenchida', Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _list(List<String> titles, String status, Color color) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: titles
          .map(
            (t) => Card(
              color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withOpacity(.2),
                  child: Icon(Icons.work, color: color),
                ),
                title: Text(
                  t,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(status),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          )
          .toList(),
    );
  }
}
