import 'package:flutter/material.dart';

class AuditLogsDataTable extends StatelessWidget {
  AuditLogsDataTable({super.key});

  final List<Map<String, String>> data = [
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
    {
      "Time": "10/19/2024 18:08:53",
      "User Account": "William James L. Lagonoy",
      "Unit": "College of Computer Studies",
      "Action": "Downloaded Monthly Result of January",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final ScrollController vertical = ScrollController();
    final ScrollController horizontal = ScrollController();
    return LayoutBuilder(builder: (context, BoxConstraints constrainst) {
      double tableWidth = constrainst.maxWidth;
      double columnWidth = tableWidth / 5;

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
                columns: [
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth,
                      child: Text(
                        'Time',
                        style: TextStyle(color: Color(0xFFF1F7F9)),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth,
                      child: Text(
                        'User Account',
                        style: TextStyle(color: Color(0xFFF1F7F9)),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth,
                      child: Text(
                        'Unit',
                        style: TextStyle(color: Color(0xFFF1F7F9)),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth,
                      child: Text(
                        'Action',
                        style: TextStyle(color: Color(0xFFF1F7F9)),
                      ),
                    ),
                  ),
                ],
                rows: data
                    .asMap()
                    .map((index, row) {
                      Color rowColor =
                          index.isEven ? Color(0xFFCED7E4) : Color(0xFFEFF4F6);

                      return MapEntry(
                        index,
                        DataRow(
                          color: WidgetStateProperty.all(rowColor),
                          cells: [
                            DataCell(Text(row['Time']!)),
                            DataCell(Text(row['User Account']!)),
                            DataCell(Text(row['Unit']!)),
                            DataCell(Text(row['Action']!)),
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
    });
  }
}
