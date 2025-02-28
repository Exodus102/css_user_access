import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TermsOfServices extends StatelessWidget {
  final double width;
  final VoidCallback onBack;
  const TermsOfServices({
    super.key,
    required this.width,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: onBack,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("svg/Logo.svg"),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(
                      "URSatisfaction",
                      style: TextStyle(
                        height: 1,
                        color: Color(0xFF064089),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      "We comply so URSatisfy",
                      style: TextStyle(
                        height: 1,
                        color: Color(0xFF1E1E1E),
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.1,
              vertical: width * 0.2,
            ),
            child: Column(
              children: [
                Text("Hello World"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
