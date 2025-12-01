import 'package:flutter/material.dart';
import 'hotel_card_payment_page.dart';
import 'hotel_payment_success_page.dart';

class HotelPaymentMethodPage extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const HotelPaymentMethodPage({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF265F6A);
    final total =
        (hotel["price"] as num) * (hotel["nights"] as int) * (hotel["rooms"] as int);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F7),
      appBar: AppBar(
        title: const Text("Méthode de paiement", style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              "\$${total.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${hotel["nights"]} nuit(s) · ${hotel["rooms"]} chambre(s)",
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 30),
            const Text(
              "Choisissez votre méthode de paiement",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _paymentOption(
              Icons.credit_card,
              "Carte Bancaire",
              primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HotelCardPaymentPage(hotel: hotel),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            _paymentOption(Icons.paypal, "PayPal", primary),
            const SizedBox(height: 15),
            _paymentOption(Icons.phone_android, "Google Pay", primary),
            const SizedBox(height: 15),
            _paymentOption(Icons.apple, "Apple Pay", primary),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HotelPaymentSuccessPage(hotel: hotel),
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

  Widget _paymentOption(IconData icon, String text, Color primary,
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
