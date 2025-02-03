import 'package:css_website_access/pages/dashboard/dashboard-contents/low_responses.dart';
import 'package:css_website_access/pages/dashboard/dashboard-contents/trend_analysis.dart';
import 'package:css_website_access/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constrainst) {
        final double height = constrainst.maxHeight;
        final double width = constrainst.maxWidth;

        double customHeader = 100;
        double lowResponses = 300;
        double button = 23;

        double remainingHeignt =
            height - (customHeader + lowResponses + button + 91);

        return Column(
          children: [
            CustomHeader(
              label: "Dashboard",
            ),
            SizedBox(width: width, child: LowResponses(width: width)),
            TrendAnalysis(
              height: remainingHeignt,
            ),
          ],
        );
      },
    );
  }
}
