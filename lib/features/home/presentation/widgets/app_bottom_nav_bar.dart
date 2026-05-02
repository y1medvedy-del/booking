import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = <_BottomNavItem>[
    _BottomNavItem(
      label: 'Поиск',
      activeIcon: 'docs/icon/IconlyBar/Bold/Search.png',
      inactiveIcon: 'docs/icon/IconlyBar/Light/Search.png',
    ),
    _BottomNavItem(
      label: 'Брони',
      activeIcon: 'docs/icon/IconlyBar/Bold/Home.png',
      inactiveIcon: 'docs/icon/IconlyBar/Light/Home.png',
    ),
    _BottomNavItem(
      label: 'Избранное',
      activeIcon: 'docs/icon/IconlyBar/Bold/Heart.png',
      inactiveIcon: 'docs/icon/IconlyBar/Light/Heart.png',
    ),
    _BottomNavItem(
      label: 'Чаты',
      activeIcon: 'docs/icon/IconlyBar/Bold/Chat.png',
      inactiveIcon: 'docs/icon/IconlyBar/Light/Chat.png',
    ),
    _BottomNavItem(
      label: 'Профиль',
      activeIcon: 'docs/icon/IconlyBar/Bold/Group.png',
      inactiveIcon: 'docs/icon/IconlyBar/Light/Profile.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFBF2),
        boxShadow: [
          BoxShadow(
            color: Color(0x11103363),
            blurRadius: 32,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 68,
            child: Row(
              children: List.generate(_items.length, (index) {
                final item = _items[index];
                final isSelected = index == currentIndex;
                return Expanded(
                  child: InkWell(
                    onTap: () => onTap(index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          isSelected ? item.activeIcon : item.inactiveIcon,
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFFF88A2A)
                                : const Color(0xFF9C8F7B),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            width: 134,
            height: 5,
            margin: const EdgeInsets.only(top: 21, bottom: 8),
            decoration: ShapeDecoration(
              color: const Color(0xFF1A1B1C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem {
  const _BottomNavItem({
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  final String label;
  final String activeIcon;
  final String inactiveIcon;
}
