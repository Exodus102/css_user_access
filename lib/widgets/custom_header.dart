import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomHeader extends StatelessWidget {
  final String label;
  const CustomHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFFF1F7F9),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1E1E1E).withValues(alpha: 0.4),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Color(0xFF064089),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'svg/images/image-1.svg',
                  height: 50,
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Jayson Daluyon'),
                    Text('CSS Coordinator'),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
