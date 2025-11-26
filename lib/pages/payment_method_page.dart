import 'package:flutter/material.dart';
import 'payment_success_page.dart';
import 'card_payment_page.dart'; 

class PaymentMethodPage extends StatelessWidget {
  final Map<String, dynamic> vol;

  const PaymentMethodPage({super.key, required this.vol});

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF265F6A);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F7),
      appBar: AppBar(
        title: const Text("Méthode de paiement", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Montant à payer",
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            const SizedBox(height: 6),

            Text(
              "\$${vol["price"]}",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),

            const SizedBox(height: 30),

            Text("Choisissez votre méthode de paiement",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),

            // ------------------ Options de paiement --------------------

            _paymentOption(
              Icons.credit_card,
              "Carte Bancaire",
              primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CardPaymentPage(vol: vol),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),

            _paymentOption(
              Icons.paypal,
              "PayPal",
              primary,
              onTap: () {
                // Vous pouvez créer une page PayPal ici
              },
            ),
            const SizedBox(height: 15),

            _paymentOption(
              Icons.phone_android,
              "Google Pay",
              primary,
              onTap: () {
                // Future Google Pay page
              },
            ),
            const SizedBox(height: 15),

            _paymentOption(
              Icons.apple,
              "Apple Pay",
              primary,
              onTap: () {
                // Future Apple Pay page
              },
            ),

            const Spacer(),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PaymentSuccessPage(),
                    ),
                  );
                },
                child: const Text(
                  "Procéder au paiement",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ========================== WIDGET OPTION =============================

  Widget _paymentOption(
      IconData icon, String text, Color primary,
      {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: primary.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: primary, size: 28),
            const SizedBox(width: 15),
            Text(text, style: const TextStyle(fontSize: 17)),
          ],
        ),
      ),
    );
  }
}
