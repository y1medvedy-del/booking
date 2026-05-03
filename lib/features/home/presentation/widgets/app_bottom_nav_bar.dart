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
        boxShadow: [BoxShadow(color: Color(0x11103363), blurRadius: 32)],
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
                          style: const TextStyle(
                            color: Color(0xFFF88A2A),
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
          const SizedBox(height: 8),
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
