import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SupportViewScreen extends StatelessWidget {
  final String title;
  final String pdfUrl;
  const SupportViewScreen({super.key, required this.title, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(title),
      ),
      body: SizedBox(height: 900, child: SfPdfViewer.network(pdfUrl)),
    );
  }
}