import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';
import 'job_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _c = TextEditingController();
  String _filter = 'Todas';

  @override
  Widget build(BuildContext context) {
    final q = _c.text.toLowerCase();
    final list = kJobs.where((j) {
      final okQ =
          q.isEmpty || '${j.title} ${j.company}'.toLowerCase().contains(q);
      final okF = _filter == 'Todas' || (_filter == 'Urgentes' && j.urgent);
      return okQ && okF;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Vagas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _c,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Cargo, empresa, bairro...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: ['Todas', 'Urgentes', 'Hoje', 'Fim de semana']
                  .map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(f),
                        selected: _filter == f,
                        onSelected: (_) => setState(() => _filter = f),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              itemBuilder: (_, i) {
                final j = list[i];
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JobDetailScreen(job: j),
                      ),
                    ),
                    title: Text(
                      j.title,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text('${j.company} • ${j.payment}'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
