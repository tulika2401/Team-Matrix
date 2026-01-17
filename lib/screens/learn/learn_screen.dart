import 'package:flutter/material.dart';
import '../../core/colors.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Learn & Invest")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionTitle("Quick Videos"),
          _VideoCard("SIP kya hota hai?", "RBI", "2 min"),
          _VideoCard("Crop Insurance", "NABARD", "3 min"),

          SizedBox(height: 20),
          _SectionTitle("Government Schemes"),
          _SchemeCard("PM Kisan", "₹6,000 yearly"),
          _SchemeCard("Atal Pension", "Pension after 60"),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style:
            Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold));
  }
}

class _VideoCard extends StatelessWidget {
  final String title, source, duration;
  const _VideoCard(this.title, this.source, this.duration);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.play_circle_fill, color: AppColors.primary),
        title: Text(title),
        subtitle: Text("$source • $duration"),
      ),
    );
  }
}

class _SchemeCard extends StatelessWidget {
  final String title, description;
  const _SchemeCard(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.account_balance, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}
