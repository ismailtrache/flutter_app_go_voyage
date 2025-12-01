import 'package:flutter/material.dart';
import 'payment_method_page.dart';

class CheapestFlightDetails extends StatelessWidget {
  final Map<String, dynamic> vol;

  const CheapestFlightDetails({super.key, required this.vol});

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF265F6A); 

    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F7),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Details du vol",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // IMAGE HEADER
            ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: Image.asset(
                "assets/images/toronto.jpg",
                height: 200,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),

            const SizedBox(height: 25),

            // ***** VOL ALLER *****
            const Text("Vol Aller",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            _segmentCard(
              "${vol["from"]} (${vol["fromCode"]})  →  ${vol["to"]} (${vol["toCode"]})",
              vol["depart"],
              vol["arrive"],
              primary,
            ),

            const SizedBox(height: 25),

            // ***** VOL RETOUR *****
            const Text("Vol Retour",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            _segmentCard(
              "${vol["to"]} (${vol["toCode"]})  →  ${vol["from"]} (${vol["fromCode"]})",
              vol["returnDepart"],
              vol["returnArrive"],
              primary,
            ),

            const SizedBox(height: 25),

            // INFORMATIONS COMPLÉMENTAIRES
            const Text("Informations complémentaires",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            const SizedBox(height: 15),

            _info(Icons.work_outline, "1 bagage cabine", primary),
            const SizedBox(height: 12),

            _info(Icons.edit_outlined, "Vous pouvez modifier ce vol", primary),
            const SizedBox(height: 12),

            _info(Icons.airline_seat_recline_normal, "Siège standard", primary),
            const SizedBox(height: 12),

            _info(Icons.cancel_outlined, "Vous pouvez annuler ce vol", primary),

            const SizedBox(height: 40),

// PRICE + BUTTON
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PaymentMethodPage(vol: vol),
          ),
        );
      },
      child: const Text(
        "Reserver ce vol",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),

    Text(
      "\$${vol["price"]}",
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
    ),
  ],
),

  


            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ==========================
  //      WIDGETS
  // ==========================

  Widget _segmentCard(String route, String depart, String arrive, Color primary) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primary.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(route,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 8),
          Text(
            "$depart  →  $arrive",
            style: TextStyle(color: Colors.grey[700], fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _info(IconData icon, String text, Color primary) {
    return Row(
      children: [
        Icon(icon, size: 22, color: primary),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
