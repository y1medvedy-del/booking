import 'package:flutter/material.dart';

class OnboardingStatusBar extends StatelessWidget {
  const OnboardingStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Text(
              '9:41',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                height: 1.29,
              ),
            ),
            const Spacer(),
            Opacity(
              opacity: 0.35,
              child: Container(
                width: 25,
                height: 13,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(4.3),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 21,
              height: 9,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
