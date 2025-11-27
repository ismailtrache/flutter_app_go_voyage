import 'package:flutter/material.dart';
import 'payment_success_page.dart';

class CardPaymentPage extends StatefulWidget {
  final Map<String, dynamic> vol;

  const CardPaymentPage({super.key, required this.vol});

  @override
  State<CardPaymentPage> createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> {
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController expiry = TextEditingController();
  final TextEditingController cvv = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF265F6A);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Paiement par Carte", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFF9F3F7),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Informations de la carte", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primary)),
            const SizedBox(height: 20),

            TextField(
              controller: cardNumber,
              decoration: const InputDecoration(
                labelText: "Numéro de Carte",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: expiry,
                    decoration: const InputDecoration(
                      labelText: "MM/YY",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: cvv,
                    decoration: const InputDecoration(
                      labelText: "CVV",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),

                // 🔥 هنا نرسل vol إلى PaymentSuccessPage
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentSuccessPage(vol: widget.vol),
                    ),
                  );
                },

                child: const Text(
                  "Payer Maintenant",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
