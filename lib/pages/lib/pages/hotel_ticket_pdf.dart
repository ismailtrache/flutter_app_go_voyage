import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

Future<Uint8List> generateHotelPDF(Map<String, dynamic> hotel) async {
  final pdf = pw.Document();
  const String passengerName = "HACHEM / S ISMAIL / T CHAKIB / R";
  final PdfColor primary = PdfColor.fromInt(0xFF265F6A);

  String fmtDate(DateTime d) => "${d.day}/${d.month}/${d.year}";

  pw.Widget infoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label,
              style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
          pw.Text(value,
              style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  pdf.addPage(
    pw.MultiPage(
      margin: const pw.EdgeInsets.all(24),
      build: (_) => [
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey400),
            borderRadius: pw.BorderRadius.circular(12),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "CONFIRMATION DE RÉSERVATION HÔTEL",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: primary,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text("Passager: $passengerName",
                  style: const pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 12),
              infoRow("Hôtel", hotel["name"]),
              infoRow("Destination", hotel["destination"]),
              infoRow("Arrivée", fmtDate(hotel["checkIn"])),
              infoRow("Départ", fmtDate(hotel["checkOut"])),
              infoRow("Nuits", "${hotel["nights"]}"),
              infoRow("Chambres", "${hotel["rooms"]}"),
              infoRow(
                  "Invités",
                  "${hotel["adults"]} adulte(s)"
                  "${hotel["children"] > 0 ? " · ${hotel["children"]} enfant(s)" : ""}"),
              infoRow("Tarif / nuit", "\$${hotel["price"]}"),
              infoRow("Total",
                  "\$${((hotel["price"] as num) * (hotel["nights"] as int) * (hotel["rooms"] as int)).toStringAsFixed(0)}"),
              pw.SizedBox(height: 16),
              pw.Text(
                "Merci d’avoir réservé avec GO TRAVEL.",
                style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  return pdf.save();
}
