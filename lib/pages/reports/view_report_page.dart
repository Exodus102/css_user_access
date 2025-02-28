import 'package:css_website_access/services/function/edit_quarter_report.dart';
import 'package:css_website_access/services/function/get_office_unit_average.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:css_website_access/widgets/custom_button_no_icon.dart';
import 'package:css_website_access/pages/reports/submit_report_dialog.dart';
import 'package:http/http.dart' as http;

class ViewReportPage extends StatefulWidget {
  final VoidCallback onBack;
  final String? year;
  final String? quarter;

  const ViewReportPage({
    super.key,
    required this.onBack,
    this.year,
    this.quarter,
  });

  @override
  ViewReportPageState createState() => ViewReportPageState();
}

class ViewReportPageState extends State<ViewReportPage> {
  Uint8List? _pdfBytes;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    setState(() {
      _pdfBytes = null; // Reset before loading
    });

    try {
      // Get the modified base PDF
      Uint8List? modifiedPdf = await modifyPdf(widget.year, widget.quarter);

      if (modifiedPdf == null) {
        print("Failed to modify base PDF");
        return;
      }

      // Pass non-null modifiedPdf to getOfficeUnitPdf
      Uint8List? finalPdf =
          await getOfficeUnitPdf(widget.year, widget.quarter, modifiedPdf);

      if (finalPdf == null) {
        print("Failed to modify office unit PDF");
        return;
      }

      setState(() {
        _pdfBytes = finalPdf; // Ensure this is set after all modifications
      });
    } catch (e) {
      print("Error loading PDF: $e");
    }
  }

  Future<void> fetchReportData() async {
    final String apiUrl =
        "https://192.168.100.46/database/date/get_quarterly_report.php?year=${widget.year}";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print("Report Data: ${response.body}");
      } else {
        print("Failed to fetch report: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching report: $e");
    }
  }

  //create another Future function for adding the text to the column

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      double width = constraints.maxWidth;
      double height = constraints.maxHeight;
      double remainingHeight = height - (30 + 20);

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: widget.onBack,
                    icon: const Icon(Icons.arrow_circle_left_outlined),
                    color: const Color(0xFF064089),
                  ),
                  Text(
                    "${widget.year} ${widget.quarter}",
                    style: const TextStyle(
                      color: Color(0xFF064089),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              CustomButtonNoIcon(
                label: "Submit Report",
                onPressed: () {
                  showSubmitReportDialog(context);
                },
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: width,
            height: remainingHeight,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F7F9),
            ),
            child: _pdfBytes == null
                ? const Center(child: CircularProgressIndicator())
                : SfPdfViewer.memory(_pdfBytes!),
          ),
        ],
      );
    });
  }
}
