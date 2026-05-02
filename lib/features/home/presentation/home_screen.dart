import 'package:flutter/material.dart';
import 'package:booking/features/home/presentation/widgets/app_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 44, bottom: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFF88A2A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFF6ED),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xCCF88A2A),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            size: 16,
                            color: Color(0xFF525252),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Хочу снять жилье в…',
                              style: TextStyle(
                                color: Color(0xFF525252),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _HeaderCircleButton(
                    icon: Icons.tune_rounded,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _HeaderCircleButton(
                    icon: Icons.notifications_none_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Stack(
                children: [
                  Center(
                    child: Transform.translate(
                      offset: const Offset(0, -32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'docs/imgs/serchBarEmpty.png',
                            width: 183.08,
                            height: 160,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 24),
                          const SizedBox(
                            width: 345,
                            child: Text(
                              'Укажите город и даты поездки, чтобы увидеть подходящие варианты',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF1A1B1C),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 24,
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFF88A2A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                        ),
                        child: const Text('Найти отель'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppBottomNavBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _HeaderCircleButton extends StatelessWidget {
  const _HeaderCircleButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 44,
        height: 44,
        decoration: ShapeDecoration(
          color: const Color(0xFFFFF6ED),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0xCCF88A2A),
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Icon(
          icon,
          size: 24,
          color: const Color(0xFF7A4310),
        ),
      ),
    );
  }
}
