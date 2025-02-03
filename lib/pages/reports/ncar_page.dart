import 'package:css_website_access/pages/reports/ncar_page_data_table.dart';
import 'package:css_website_access/widgets/custom_dropdown.dart';
import 'package:css_website_access/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class NcarPage extends StatefulWidget {
  const NcarPage({super.key});

  @override
  State<NcarPage> createState() => _NcarPageState();
}

class _NcarPageState extends State<NcarPage> {
  String? selectedValue;
  String? selectedDate;
  String? selectedQuarter;

  final List<String> items = ["Academic Affairs"];
  final List<String> date = ["2024"];
  final List<String> quarter = ["4th Quarter"];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constrainst) {
        double height = constrainst.maxHeight;
        double parentwidth = constrainst.maxWidth;

        double headerHeight = 100.0;
        double dropdownHeight = 30.0;
        double paddingHeight = 40.0;
        double buttonHeight = 15.0;
        double paddingWidth = 30.0;

        double remainingWidth = parentwidth - paddingWidth;

        double remainingHeight = height -
            (headerHeight + dropdownHeight + paddingHeight + buttonHeight);

        return Column(
          children: [
            CustomHeader(
                label: "Reports: Non-conformity and Corrective Action Report"),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
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
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: remainingHeight,
                    width: parentwidth,
                    child: NcarPageDataTable(
                      width: remainingWidth,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
