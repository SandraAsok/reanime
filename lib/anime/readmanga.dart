import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class ReadManga extends StatefulWidget {
  final String pdfUrl;

  const ReadManga({super.key, required this.pdfUrl});

  @override
  State<ReadManga> createState() => _ReadMangaState();
}

class _ReadMangaState extends State<ReadManga> {
  late PDFDocument? pdfDocument;
  bool isDocumentLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //
  // void loadDocument() async{
  //   pdfDocument = await PDFDocument.fromURL(widget.pdfUrl);
  //   setState(() {
  //     isDocumentLoading = false;
  //   });
  // }

  void loadDocument() async {
    try {
      pdfDocument = await PDFDocument.fromURL(widget.pdfUrl);
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading PDF: $e';
      });
    } finally {
      setState(() {
        isDocumentLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'REANIME',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      // body: PdfViewerScreen(pdfUrl: pdfUrl),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (errorMessage != null)
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            if (!isDocumentLoading && pdfDocument != null)
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black87,
                  height:
                      MediaQuery.of(context).size.height - kToolbarHeight - 50,
                  padding: const EdgeInsets.all(8.0),
                  child: PDFViewer(
                    document: pdfDocument!,
                    zoomSteps: 1,
                  ),
                ),
              ),
            if (isDocumentLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("loading",style: TextStyle(color: Colors.orange),),
                ),
              )
          ],
        ),
      ),
    );
  }
}
