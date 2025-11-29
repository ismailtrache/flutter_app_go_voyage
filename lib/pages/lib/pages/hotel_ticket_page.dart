import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'hotel_ticket_pdf.dart';

class HotelTicketPage extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const HotelTicketPage({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF265F6A);
    final total =
        (hotel["price"] as num) * (hotel["nights"] as int) * (hotel["rooms"] as int);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F1F4),
      appBar: AppBar(
        title: const Text("Votre réservation d'hôtel", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Réservation confirmée",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
                const SizedBox(height: 15),
                _ticketRow("Hôtel", hotel["name"]),
                _ticketRow("Destination", hotel["destination"]),
                _ticketRow(
                  "Arrivée",
                  "${hotel["checkIn"].day}/${hotel["checkIn"].month}/${hotel["checkIn"].year}",
                ),
                _ticketRow(
                  "Départ",
                  "${hotel["checkOut"].day}/${hotel["checkOut"].month}/${hotel["checkOut"].year}",
                ),
                _ticketRow("Nuits", "${hotel["nights"]}"),
                _ticketRow("Chambres", "${hotel["rooms"]}"),
                _ticketRow(
                  "Invités",
                  "${hotel["adults"]} adulte(s)"
                  "${hotel["children"] > 0 ? " · ${hotel["children"]} enfant(s)" : ""}",
                ),
                _ticketRow("Prix", "\$${hotel["price"]} / nuit"),
                _ticketRow("Total", "\$${total.toStringAsFixed(0)}"),
                const SizedBox(height: 25),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                  label: const Text(
                    "Télécharger PDF",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () async {
                    final pdfData = await generateHotelPDF(hotel);
                    await Printing.layoutPdf(onLayout: (format) => pdfData);
                  },
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text(
                    "Retour à l'accueil",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _ticketRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, color: Colors.black54)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
