import 'package:css_website_access/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class DisplayPage extends StatelessWidget {
  const DisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(label: "Display"),
      ],
    );
  }
}
