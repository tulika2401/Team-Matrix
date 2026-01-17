import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Community")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _PostCard(
            title: "Saving Tips",
            content:
                "Save at least 10% of your income every month for emergencies.",
          ),
          _PostCard(
            title: "Government Scheme",
            content:
                "PMJDY offers zero balance accounts with insurance benefits.",
          ),
          _PostCard(
            title: "Farmer Discussion",
            content:
                "Best bank loans available for Kharif crops this season.",
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final String title;
  final String content;

  const _PostCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}
