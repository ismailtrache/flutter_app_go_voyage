// lib/pages/ticket_pdf.dart

import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generateTicketPDF(Map<String, dynamic> vol) async {
  final pdf = pw.Document();

  final PdfColor primary = PdfColor.fromInt(0xFF265F6A);
  final PdfColor lightGrey = PdfColor.fromInt(0xFFEFEFEF);

  // بيانات إضافية (افتراضية) ليشبه التذكرة الحقيقية
  const String passengerName = "HACHEM / S ISMAIL / T CHAKIB / R";
  const String airlineName = "GO TRAVEL AIRLINES";
  const String boardingGroup = "F";
  const String seat = "12C";
  const String gate = "A12";
  const String sequenceNumber = "0001";

  pw.Widget buildBoardingPassCopy(String copyLabel) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey700, width: 1),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          // ---------- HEADER ----------
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: PdfColors.white,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      airlineName,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: primary,
                      ),
                    ),
                    pw.Text(
                      "Boarding Pass",
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey700,
                      ),
                    ),
                    pw.Text(
                      copyLabel,
                      style: pw.TextStyle(
                        fontSize: 9,
                        color: PdfColors.grey600,
                      ),
                    ),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      "Sequence number: $sequenceNumber",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Container(
                      height: 32,
                      width: 140,
                      child: pw.BarcodeWidget(
                        barcode: pw.Barcode.code128(),
                        data: "SEQ-$sequenceNumber-${vol["flightNumber"]}",
                        drawText: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ---------- NAME + MAIN INFO ----------
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            color: lightGrey,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  passengerName,
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // LEFT: FLIGHT / TIMES
                    pw.Expanded(
                      flex: 3,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text("FLIGHT",
                                      style: pw.TextStyle(
                                          fontSize: 8,
                                          color: PdfColors.grey700)),
                                  pw.Text(
                                    vol["flightNumber"],
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text("DEPARTURE",
                                      style: pw.TextStyle(
                                          fontSize: 8,
                                          color: PdfColors.grey700)),
                                  pw.Text(
                                    vol["depart"],
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text("ARRIVAL",
                                      style: pw.TextStyle(
                                          fontSize: 8,
                                          color: PdfColors.grey700)),
                                  pw.Text(
                                    vol["arrive"],
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          pw.SizedBox(height: 12),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text("FROM",
                                      style: pw.TextStyle(
                                          fontSize: 8,
                                          color: PdfColors.grey700)),
                                  pw.Text(
                                    "${vol["from"]} (${vol["fromCode"]})",
                                    style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              pw.Icon(
                                pw.IconData(0xe530),
                                size: 26,
                                color: PdfColors.grey700,
                              ),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text("TO",
                                      style: pw.TextStyle(
                                          fontSize: 8,
                                          color: PdfColors.grey700)),
                                  pw.Text(
                                    "${vol["to"]} (${vol["toCode"]})",
                                    style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // RIGHT: small details box
                    pw.SizedBox(width: 8),
                    pw.Container(
                      width: 120,
                      padding: const pw.EdgeInsets.all(8),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.grey500),
                        color: PdfColors.white,
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          _infoLine("Cabin Class", vol["cabin"]),
                          _infoLine(
                              "Ticket Number", "TVL-${vol["flightNumber"]}"),
                          _infoLine("Price", "\$${vol["price"]}"),
                          _infoLine("Seat", seat),
                          _infoLine("Gate", gate),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ---------- LOWER STRIP ----------
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("GATE",
                        style: pw.TextStyle(
                            fontSize: 8, color: PdfColors.grey700)),
                    pw.Text(gate,
                        style: pw.TextStyle(
                            fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 6),
                    pw.Text("BOARDING GROUP",
                        style: pw.TextStyle(
                            fontSize: 8, color: PdfColors.grey700)),
                    pw.Text(boardingGroup,
                        style: pw.TextStyle(
                            fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("BOARDING TIME",
                        style: pw.TextStyle(
                            fontSize: 8, color: PdfColors.grey700)),
                    pw.Text("45 min before departure",
                        style: pw.TextStyle(fontSize: 10)),
                    pw.SizedBox(height: 6),
                    pw.Text("SEAT",
                        style: pw.TextStyle(
                            fontSize: 8, color: PdfColors.grey700)),
                    pw.Text(seat,
                        style: pw.TextStyle(
                            fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Container(
                  height: 60,
                  width: 120,
                  child: pw.BarcodeWidget(
                    barcode: pw.Barcode.qrCode(),
                    data:
                        "FLIGHT-${vol["flightNumber"]}-${vol["fromCode"]}-${vol["toCode"]}-${seat}",
                    drawText: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // صفحة فيها نسختين: Passenger + Airline
  pdf.addPage(
    pw.MultiPage(
      margin: const pw.EdgeInsets.all(24),
      build: (context) => [
        buildBoardingPassCopy("Passenger Copy"),
        _dashedSeparator(),
        buildBoardingPassCopy("Airline Copy"),
      ],
    ),
  );

  return pdf.save();
}

// سطر مقطّع بين النسختين (مثل علامة المقص)
pw.Widget _dashedSeparator() {
  return pw.Column(
    children: [
      pw.SizedBox(height: 4),
      pw.Row(
        children: List.generate(
          50,
          (index) => pw.Expanded(
            child: pw.Container(
              height: 1,
color: index.isEven ? PdfColors.grey500 : PdfColor.fromInt(0x00FFFFFF),
            ),
          ),
        ),
      ),
      pw.SizedBox(height: 8),
    ],
  );
}

// سطر معلومات صغير في الصندوق الجانبي
pw.Widget _infoLine(String label, String value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 4),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Flexible(
          child: pw.Text(
            label,
            style: pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
          ),
        ),
        pw.SizedBox(width: 4),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
        ),
      ],
    ),
  );
}
