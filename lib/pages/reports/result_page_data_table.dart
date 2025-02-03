import 'package:flutter/material.dart';

class ResultPageDataTable extends StatelessWidget {
  ResultPageDataTable({super.key});

  final List<Map<String, String>> data = [
    {
      "Office": "College of Accountancy",
      "Actions": "View",
      "Status": "Pending",
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                color: Color(0xFF7B8186),
                width: 1,
                style: BorderStyle.solid,
              ),
              headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                (states) => const Color(0xFF064089),
              ),
              columns: const [
                DataColumn(
                  label: Text(
                    'Office',
                    style: TextStyle(color: Color(0xFFF1F7F9)),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Actions',
                    style: TextStyle(color: Color(0xFFF1F7F9)),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style: TextStyle(color: Color(0xFFF1F7F9)),
                  ),
                ),
              ],
              rows: data
                  .asMap()
                  .map((index, row) {
                    Color rowColor =
                        index.isEven ? Color(0xFFF1F7F9) : Color(0xFFD8E5EF);

                    return MapEntry(
                      index,
                      DataRow(
                        color: WidgetStateProperty.all(rowColor),
                        cells: [
                          DataCell(Text(row['Office']!)),
                          DataCell(Text(row['Actions']!)),
                          DataCell(Text(row['Status']!)),
                        ],
                      ),
                    );
                  })
                  .values
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
