import 'package:css_website_access/pages/data-responses/data_table_widget.dart';
import 'package:css_website_access/pages/data-responses/upload_csv_dialog.dart';
import 'package:css_website_access/services/data-responses-services/get_division.dart';
import 'package:css_website_access/services/data-responses-services/get_office.dart';
import 'package:css_website_access/widgets/custom_button.dart';
import 'package:css_website_access/widgets/custom_dropdown.dart';
import 'package:css_website_access/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class DataResponses extends StatefulWidget {
  const DataResponses({super.key});

  @override
  State<DataResponses> createState() => _DataResponsesState();
}

class _DataResponsesState extends State<DataResponses> {
  String? selectedDivision;
  String? selectedCollege;
  String? selectedDate;
  String? selectedQuarter;

  List<String> divisionItems = [];
  List<String> collegeItems = [];
  final List<String> dateItems = ["2024"];
  final List<String> quarterItems = ["4th Quarter"];

  @override
  void initState() {
    super.initState();
    FetchDataDivisionService(updateDivisions: (List<String> divisions) {
      setState(() {
        divisionItems = divisions;
      });
    }).fetchDivisions();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;
        double parentWidth = constraints.maxWidth;

        double customHeaderHeight = 100;
        double paddingHeight = 20 * 2;
        double rowHeight = 30;
        double spacingHeight = 10 + 10;

        double remainingHeight = height -
            (customHeaderHeight + paddingHeight + rowHeight + spacingHeight);

        return SizedBox(
          height: height,
          width: parentWidth,
          child: Column(
            children: [
              CustomHeader(label: "Data Responses"),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: parentWidth * 0.15,
                          child: CustomDropdown(
                            items: divisionItems,
                            selectedValue: selectedDivision,
                            onChanged: (value) {
                              setState(() {
                                selectedDivision = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: parentWidth * 0.15,
                          child: CustomDropdown(
                            items: collegeItems,
                            selectedValue: selectedCollege,
                            onChanged: (value) {
                              setState(() {
                                selectedCollege = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: parentWidth * 0.1,
                          child: CustomDropdown(
                            items: dateItems,
                            selectedValue: selectedDate,
                            onChanged: (value) {
                              setState(() {
                                selectedDate = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: parentWidth * 0.1,
                          child: CustomDropdown(
                            items: quarterItems,
                            selectedValue: selectedQuarter,
                            onChanged: (value) {
                              setState(() {
                                selectedQuarter = value;
                              });
                            },
                          ),
                        ),
                        Spacer(),
                        CustomButton(
                          label: "Input Manually",
                          svgPath: "svg/icons/input-manually.svg",
                          onPressed: () {},
                        ),
                        SizedBox(width: 10),
                        CustomButton(
                          label: "Upload CSV/XLS",
                          svgPath: "svg/icons/upload-csv.svg",
                          onPressed: () {
                            showUploadDialog(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: remainingHeight,
                      width: parentWidth,
                      child: DataTableWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
