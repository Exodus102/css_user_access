import 'package:css_website_access/pages/reports/result_page_data_table.dart';
import 'package:css_website_access/widgets/custom_dropdown.dart';
import 'package:css_website_access/widgets/custom_elevated_button_reports.dart';
import 'package:css_website_access/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  String? selectedValue;
  String? selectedMonth;
  String? selectedDate;
  String? selectedQuarter;
  int? activeIndex;

  String text = "Results";

  final List<String> items = ["Academic Affairs"];
  final List<String> date = ["2024"];
  final List<String> quarter = ["4th Quarter"];
  final List<String> month = ["November"];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constrainst) {
      double height = constrainst.maxHeight;
      double parentwidth = constrainst.maxWidth;

      double headerHeight = 100.0;
      double rowHeight = 60.0;
      double dropdownHeight = 30.0;
      double paddingHeight = 40.0;

      double remainingHeight =
          height - (headerHeight + rowHeight + dropdownHeight + paddingHeight);
      return Column(
        children: [
          CustomHeader(label: "Reports: $text"),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomElevatedButtonReports(
                      text: "Monthly",
                      onTap: () {
                        setState(() {
                          activeIndex = 0;
                          text = "Monthly Results";
                        });
                      },
                      active: activeIndex == 0,
                    ),
                    CustomElevatedButtonReports(
                      text: "Quarterly",
                      onTap: () {
                        setState(() {
                          activeIndex = 1;
                          text = "Quarterly Results";
                        });
                      },
                      active: activeIndex == 1,
                    ),
                    CustomElevatedButtonReports(
                      text: "Annual",
                      onTap: () {
                        setState(() {
                          activeIndex = 2;
                          text = "Annual Results";
                        });
                      },
                      active: activeIndex == 2,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: parentwidth * 0.15,
                      child: CustomDropdown(
                        items: items,
                        selectedValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: parentwidth * 0.1,
                      child: CustomDropdown(
                        items: date,
                        selectedValue: selectedDate,
                        onChanged: (value) {
                          setState(() {
                            selectedDate = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: parentwidth * 0.1,
                      child: CustomDropdown(
                        items: quarter,
                        selectedValue: selectedQuarter,
                        onChanged: (value) {
                          setState(() {
                            selectedQuarter = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: parentwidth * 0.1,
                      child: CustomDropdown(
                        items: month,
                        selectedValue: selectedMonth,
                        onChanged: (value) {
                          setState(() {
                            selectedMonth = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: remainingHeight,
                  width: parentwidth,
                  child: ResultPageDataTable(),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
