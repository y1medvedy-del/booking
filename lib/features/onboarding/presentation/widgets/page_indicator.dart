import 'package:flutter/material.dart';

class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  final int currentPage;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 52,
        height: 20,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFCDD0D3).withValues(alpha: 0.82),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(pageCount, (index) {
            final isActive = index == currentPage;
            return Padding(
              padding: EdgeInsets.only(right: index == pageCount - 1 ? 0 : 5),
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFFFBBF28) : Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
