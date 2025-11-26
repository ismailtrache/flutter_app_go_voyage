import 'package:flutter/material.dart';
import 'payment_success_page.dart';

class CardPaymentPage extends StatefulWidget {
  final Map<String, dynamic> vol;

  const CardPaymentPage({super.key, required this.vol});

  @override
  State<CardPaymentPage> createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> {
  final _formKey = GlobalKey<FormState>();

  String cardNumber = "";
  String cardHolder = "";
  String expiry = "";
  String cvv = "";

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF265F6A);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Paiement par carte", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Numéro de carte"),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Champ requis" : null,
                onSaved: (v) => cardNumber = v!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Nom sur la carte"),
                validator: (v) => v!.isEmpty ? "Champ requis" : null,
                onSaved: (v) => cardHolder = v!,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: "Expiration (MM/YY)"),
                      validator: (v) => v!.isEmpty ? "Champ requis" : null,
                      onSaved: (v) => expiry = v!,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: "CVV"),
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? "Champ requis" : null,
                      onSaved: (v) => cvv = v!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PaymentSuccessPage(),
                      ),
                    );
                  }
                },
                child: const Text("Payer maintenant", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
