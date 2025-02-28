import 'package:css_website_access/widgets/custom_button_data_table_report.dart';
import 'package:css_website_access/widgets/custom_text_data_table_report.dart';
import 'package:flutter/material.dart';

class NcarPageDataTable extends StatelessWidget {
  final double width;
  NcarPageDataTable({
    super.key,
    required this.width,
  });

  final List<Map<String, String>> data = [
    {
      "Office": "College of Accountancy",
      "Actions": "View",
      "Status": "Unresolved",
    },
    {
      "Office": "College of Accountancy",
      "Actions": "View",
      "Status": "Unresolved",
    },
    {
      "Office": "College of Accountancy",
      "Actions": "View",
      "Status": "Unresolved",
    },
    {
      "Office": "College of Accountancy",
      "Actions": "View",
      "Status": "Unresolved",
    },
    {
      "Office": "College of Accountancy",
      "Actions": "View",
      "Status": "Unresolved",
    },
    {
      "Office": "College of Accountancy",
      "Actions": "View",
      "Status": "Unresolved",
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF7B8186), width: 1),
                ),
                child: DataTable(
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      color: Color(0xFF7B8186),
                      width: 1,
                    ),
                    verticalInside: BorderSide(
                      color: Color(0xFF7B8186),
                      width: 1,
                    ),
                  ),
                  headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                    (states) => const Color(0xFF064089),
                  ),
                  columns: [
                    DataColumn(
                      label: SizedBox(
                        width: width * 0.7,
                        child: Text(
                          textAlign: TextAlign.center,
                          'Office',
                          style: TextStyle(color: Color(0xFFF1F7F9)),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: width * 0.08,
                        child: Text(
                          textAlign: TextAlign.center,
                          'Actions',
                          style: TextStyle(color: Color(0xFFF1F7F9)),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: width * 0.08,
                        child: Text(
                          textAlign: TextAlign.center,
                          'Status',
                          style: TextStyle(color: Color(0xFFF1F7F9)),
                        ),
                      ),
                    ),
                  ],
                  rows: data
                      .asMap()
                      .map((index, row) {
                        Color rowColor = index.isEven
                            ? Color(0xFFF1F7F9)
                            : Color(0xFFCFD8E5);

                        return MapEntry(
                          index,
                          DataRow(
                            color: WidgetStateProperty.all(rowColor),
                            cells: [
                              DataCell(
                                Text(
                                  row['Office']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: CustomButtonDataTableReport(
                                    onPressed: (){},
                                    backgroundColor: rowColor,
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: CustomTextDataTableReport(
                                    text: "Unresolved",
                                  ),
                                ),
                              ),
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
        ),
      ),
    );
  }
}
