import 'package:css_website_access/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class DataManagement extends StatelessWidget {
  const DataManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(label: "Data Management"),
      ],
    );
  }
}
