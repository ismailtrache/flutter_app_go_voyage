import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'ticket_pdf.dart';
import 'package:printing/printing.dart';

class TicketPage extends StatelessWidget {
  final Map<String, dynamic> vol;

  const TicketPage({super.key, required this.vol});

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF265F6A);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F1F4),
      appBar: AppBar(
        title: const Text("Votre Billet d’Avion", style: TextStyle(color: Colors.black)),
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

                Text(
                  "Billet Confirmé",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),

                const SizedBox(height: 15),

                ticketRow("Départ", "${vol['from']} (${vol['fromCode']})"),
                ticketRow("Arrivée", "${vol['to']} (${vol['toCode']})"),
                ticketRow("Date Départ", vol["depart"]),
                ticketRow("Date Arrivée", vol["arrive"]),
                ticketRow("Numéro du vol", vol["flightNumber"]),
                ticketRow("Cabine", vol["cabin"]),
                ticketRow("Prix", "\$${vol["price"]}"),

                const SizedBox(height: 25),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: QrImageView(
                    data: "FLIGHT-${vol["flightNumber"]}-${vol["price"]}",
                    size: 150,
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                  "Code QR à scanner à l’aéroport",
                  style: TextStyle(color: Colors.grey.shade600),
                ),

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
                    final pdfData = await generateTicketPDF(vol);
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

  Widget ticketRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, color: Colors.black54)),
          Text(value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}
