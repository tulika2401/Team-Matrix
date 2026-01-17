import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../profile/profile_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final bankNameCtrl = TextEditingController();
  final bankAccountCtrl = TextEditingController();

  String gender = "Male";
  String designation = "Farmer";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field("Full Name", nameCtrl),
              _field("Age", ageCtrl, number: true),
              _field("Phone", phoneCtrl, number: true),
              _field("Email", emailCtrl),
              _field("Bank Name", bankNameCtrl),
              _field("Bank Account Number", bankAccountCtrl, number: true),

              const SizedBox(height: 12),

              DropdownButtonFormField(
                value: gender,
                items: ["Male", "Female", "Other"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => gender = v!),
                decoration: const InputDecoration(labelText: "Gender"),
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField(
                value: designation,
                items: ["Farmer", "Student", "Worker"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => designation = v!),
                decoration: const InputDecoration(labelText: "Designation"),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  final user = UserModel(
                    name: nameCtrl.text,
                    age: int.parse(ageCtrl.text),
                    gender: gender,
                    phone: phoneCtrl.text,
                    email: emailCtrl.text,
                    bankName: bankNameCtrl.text,
                    bankAccount: bankAccountCtrl.text,
                    designation: designation,
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen(user: user),
                    ),
                  );
                },
                child: const Text("Create Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController c,
      {bool number = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        keyboardType:
            number ? TextInputType.number : TextInputType.text,
        validator: (v) => v!.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
