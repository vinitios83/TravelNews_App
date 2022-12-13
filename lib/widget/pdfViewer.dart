import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PDFViewerCachedFromUrl extends StatelessWidget {
  final String url;

  const PDFViewerCachedFromUrl({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Uint8List>(
      future: _fetchPdfContent(url),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PdfPreview(
            allowPrinting: false,
            allowSharing: false,
            canChangePageFormat: false,
            initialPageFormat:
                PdfPageFormat(100 * PdfPageFormat.mm, 120 * PdfPageFormat.mm),
            build: (format) => snapshot.data!,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }

  Future<Uint8List> _fetchPdfContent(final String url) async {
    final Response<List<int>> response = await Dio().get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data!);
  }
}
