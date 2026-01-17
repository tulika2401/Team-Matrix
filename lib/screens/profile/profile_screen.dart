import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../main.dart'; // for MainNavigation

class ProfileScreen extends StatelessWidget {
  final UserModel user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Created")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _item("Name", user.name),
            _item("Age", user.age.toString()),
            _item("Gender", user.gender),
            _item("Phone", user.phone),
            _item("Email", user.email),
            _item("Bank", user.bankName),
            _item("Account No", user.bankAccount),
            _item("Designation", user.designation),

            const Spacer(),

            // ✅ IMPORTANT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Enter App"),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MainNavigation(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        "$label: $value",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
