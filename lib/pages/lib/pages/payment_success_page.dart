import 'package:flutter/material.dart';
import 'ticket_page.dart';

class PaymentSuccessPage extends StatelessWidget {
  final Map<String, dynamic> vol;

  const PaymentSuccessPage({super.key, required this.vol});

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF265F6A);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F7),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: primary, size: 120),

              const SizedBox(height: 20),

              const Text(
                "Paiement Réussi !",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Votre réservation a été confirmée.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // 🔥 زر رؤية التذكرة
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TicketPage(vol: vol),
                    ),
                  );
                },
                child: const Text(
                  "CHECK YOUR FLIGHT TICKET",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              const SizedBox(height: 25),

              // 🔙 زر العودة إلى الصفحة الرئيسية
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  "Retour à l'accueil",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
