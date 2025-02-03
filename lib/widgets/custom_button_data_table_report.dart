import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtonDataTableReport extends StatelessWidget {
  final Color backgroundColor;
  const CustomButtonDataTableReport({
    super.key,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Color(0xFF064089),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFF064089)),
          borderRadius: BorderRadius.circular(60),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'svg/icons/view-eye.svg',
            color: Color(0xFF064089),
            width: 15,
            height: 15,
          ),
          SizedBox(width: 8),
          Text("View"),
        ],
      ),
    );
  }
}
