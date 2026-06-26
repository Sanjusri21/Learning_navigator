import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CertificateService {

  Future<Uint8List>
      generateCertificate({

    required String userName,
    required String skillName,
    required String date,

  }) async {

    final pdf = pw.Document();

    pdf.addPage(

      pw.Page(

        pageFormat: PdfPageFormat.a4,

        build: (context) {

          return pw.Container(

            padding:
                const pw.EdgeInsets.all(
                    40),

            decoration: pw.BoxDecoration(

              border: pw.Border.all(

                color: PdfColors.blue,

                width: 5,
              ),
            ),

            child: pw.Column(

              mainAxisAlignment:
                  pw.MainAxisAlignment
                      .center,

              crossAxisAlignment:
                  pw.CrossAxisAlignment
                      .center,

              children: [

                pw.Text(

                  "CERTIFICATE",

                  style: pw.TextStyle(

                    fontSize: 40,

                    fontWeight:
                        pw.FontWeight.bold,

                    color:
                        PdfColors.blue,
                  ),
                ),

                pw.SizedBox(height: 10),

                pw.Text(

                  "OF COMPLETION",

                  style: pw.TextStyle(

                    fontSize: 22,

                    fontWeight:
                        pw.FontWeight.bold,
                  ),
                ),

                pw.SizedBox(height: 40),

                pw.Text(

                  "This certificate is proudly presented to",

                  style: const pw.TextStyle(
                    fontSize: 18,
                  ),
                ),

                pw.SizedBox(height: 25),

                pw.Text(

                  userName,

                  style: pw.TextStyle(

                    fontSize: 32,

                    fontWeight:
                        pw.FontWeight.bold,

                    color:
                        PdfColors.deepPurple,
                  ),
                ),

                pw.SizedBox(height: 30),

                pw.Text(

                  "For successfully completing",

                  style: const pw.TextStyle(
                    fontSize: 18,
                  ),
                ),

                pw.SizedBox(height: 20),

                pw.Text(

                  skillName,

                  style: pw.TextStyle(

                    fontSize: 28,

                    fontWeight:
                        pw.FontWeight.bold,

                    color:
                        PdfColors.blue,
                  ),
                ),

                pw.SizedBox(height: 40),

                pw.Text(

                  "Completion Date",

                  style: pw.TextStyle(

                    fontSize: 16,

                    fontWeight:
                        pw.FontWeight.bold,
                  ),
                ),

                pw.SizedBox(height: 10),

                pw.Text(

                  date,

                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                ),

                pw.SizedBox(height: 60),

                pw.Row(

                  mainAxisAlignment:
                      pw.MainAxisAlignment
                          .spaceBetween,

                  children: [

                    pw.Column(

                      children: [

                        pw.Container(
                          width: 150,
                          height: 1,
                          color:
                              PdfColors.black,
                        ),

                        pw.SizedBox(height: 5),

                        pw.Text(
                          "Instructor",
                        ),
                      ],
                    ),

                    pw.Column(

                      children: [

                        pw.Container(
                          width: 150,
                          height: 1,
                          color:
                              PdfColors.black,
                        ),

                        pw.SizedBox(height: 5),

                        pw.Text(
                          "Authorized Signature",
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}