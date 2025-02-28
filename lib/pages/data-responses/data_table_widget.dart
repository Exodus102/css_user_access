import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DataTableWidget extends StatefulWidget {
  final String? selectedDivision;
  final String? selectedCollege;

  const DataTableWidget({
    super.key,
    this.selectedDivision,
    this.selectedCollege,
  });

  @override
  DataTableWidgetState createState() => DataTableWidgetState();
}

class DataTableWidgetState extends State<DataTableWidget> {
  List<String> columns = [];
  List<Map<String, dynamic>> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          "http://192.168.100.46/database/data-response/data_response.php"));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          columns = List<String>.from(jsonData["columns"]);
          data = List<Map<String, dynamic>>.from(jsonData["data"]);
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> getFilteredData() {
    List<Map<String, dynamic>> filtered = data.where((row) {
      bool matchesDivision = widget.selectedDivision == null ||
          widget.selectedDivision == "Show All" ||
          row["division"]?.toString().trim() == widget.selectedDivision?.trim();

      bool matchesCollege = widget.selectedCollege == null ||
          widget.selectedCollege == "Show All" ||
          (row["officeUnit"] != null &&
              row["officeUnit"].toString().trim() ==
                  widget.selectedCollege?.trim());

      return matchesDivision && matchesCollege;
    }).toList();
    return filtered;
  }

  Color getAnalysisColor(String value) {
    switch (value.toLowerCase()) {
      case "positive":
        return Color(0xFF29AB87);
      case "negative":
        return Color(0xFFEE6B6E);
      case "neutral":
        return Color(0xFFFF9D5C);
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    List<Map<String, dynamic>> filteredData = getFilteredData();

    if (columns.isEmpty || filteredData.isEmpty) {
      return const Center(
        child: Text("No data available"),
      );
    }

    final ScrollController vertical = ScrollController();
    final ScrollController horizontal = ScrollController();

    return Scrollbar(
      trackVisibility: true,
      thumbVisibility: true,
      interactive: true,
      thickness: 8.0,
      controller: horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: horizontal,
        child: Scrollbar(
          trackVisibility: true,
          thumbVisibility: true,
          interactive: true,
          thickness: 8.0,
          controller: vertical,
          child: SingleChildScrollView(
            controller: vertical,
            child: DataTable(
              border: TableBorder.all(
                color: const Color(0xFF7B8186),
                width: 1,
                style: BorderStyle.solid,
              ),
              headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                (states) => const Color(0xFF064089),
              ),
              columns: columns.map((col) {
                return DataColumn(
                  label: Text(
                    col,
                    style: const TextStyle(
                        color: Color(0xFFF1F7F9), fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
              rows: List<DataRow>.generate(filteredData.length, (index) {
                return DataRow(
                  color: WidgetStateProperty.resolveWith<Color?>(
                    (states) => index.isEven
                        ? const Color(0xFFF1F7F9)
                        : const Color(0xFFD8E5EF),
                  ),
                  cells: columns.map((col) {
                    if (col.toLowerCase() == "analysis") {
                      return DataCell(
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: getAnalysisColor(
                                filteredData[index][col]?.toString() ?? ""),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.black12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            filteredData[index][col]?.toString() ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return DataCell(
                        Text(
                          filteredData[index][col]?.toString() ?? "",
                        ),
                      );
                    }
                  }).toList(),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
