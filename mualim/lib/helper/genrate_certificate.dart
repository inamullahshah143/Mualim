// ignore_for_file: depend_on_referenced_packages, import_of_legacy_library_into_null_safe, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:mualim/main.dart';
import 'package:path_provider/path_provider.dart';

///Pdf import
import 'package:syncfusion_flutter_pdf/pdf.dart';

/// Render pdf of course completion certificate
class CourseCompletionCertificatePdf {
  final BuildContext? context;
  const CourseCompletionCertificatePdf(this.context);
  Future<void> createPDF() async {
    final PdfDocument document = PdfDocument();
    document.pageSettings.orientation = PdfPageOrientation.landscape;
    document.pageSettings.margins.all = 0;
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get the page size
    final Size pageSize = page.getClientSize();
    //Draw image
    page.graphics.drawImage(PdfBitmap(await _readImageData('certificate.jpg')),
        Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));
    //Create font
    final PdfFont nameFont =
        PdfStandardFont(PdfFontFamily.courier, 14, style: PdfFontStyle.bold);
    double x = _calculateXPosition(
        prefs!.getString('username').toString(), nameFont, pageSize.width);
    page.graphics.drawString(prefs!.getString('username').toString(), nameFont,
        bounds: Rect.fromLTWH(x + 50, 242.5, 0, 0),
        brush: PdfSolidBrush(PdfColor(43, 43, 43)));
    //Save and launch the document
    final List<int> bytes = await document.save();
    //Dispose the document.
    document.dispose();

    saveAndLaunchFile(bytes, 'Certificate.pdf', context);
  }

  double _calculateXPosition(String text, PdfFont font, double pageWidth) {
    final Size textSize =
        font.measureString(text, layoutArea: Size(pageWidth, 0));
    return (pageWidth - textSize.width) / 2;
  }

  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName, context) async {
    final path = (await getExternalStorageDirectory())?.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true).whenComplete(() {
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return const PDF(enableSwipe: true).fromPath(
              file.path,
            );
          });
    });
  }
}
