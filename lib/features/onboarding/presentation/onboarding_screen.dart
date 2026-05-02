import 'package:flutter/material.dart';
import 'package:booking/features/home/presentation/home_screen.dart';
import 'package:booking/features/onboarding/presentation/widgets/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPageData> _pages = const [
    _OnboardingPageData(
      imagePath: 'docs/imgs/onbord1.png',
      title: 'Находите идеальное жилье',
      description:
          'Исследуйте уникальные варианты проживания, подходящие именно вам',
    ),
    _OnboardingPageData(
      imagePath: 'docs/imgs/onbord2.png',
      title: 'Бронируйте\nс уверенностью',
      description:
          'Простой процесс бронирования и гарантии безопасности для вашего спокойствия',
    ),
    _OnboardingPageData(
      imagePath: 'docs/imgs/onbord3.png',
      title: 'Путешествуйте без границ',
      description:
          'Открывайте для себя новые места и незабываемые впечатления с местными экспертами',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _nextPage() async {
    if (_currentPage == _pages.length - 1) {
      if (!mounted) {
        return;
      }

      await Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const HomeScreen(),
        ),
      );
      return;
    }

    await _pageController.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final page = _pages[index];
          return _OnboardingPage(
            data: page,
            currentPage: _currentPage,
            pageCount: _pages.length,
            onNext: _nextPage,
            buttonLabel: index == _pages.length - 1 ? 'Начать' : 'Далее',
          );
        },
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.data,
    required this.currentPage,
    required this.pageCount,
    required this.onNext,
    required this.buttonLabel,
  });

  final _OnboardingPageData data;
  final int currentPage;
  final int pageCount;
  final VoidCallback onNext;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            data.imagePath,
            fit: BoxFit.fill,
          ),
          DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.48, 0.68, 1.0],
                colors: [
                  Color(0x00000000),
                  Color(0x14000000),
                  Color(0xAD1C1C18),
                  Color(0xFF292925),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 634,
            child: OnboardingPageIndicator(
              currentPage: currentPage,
              pageCount: pageCount,
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: 498,
            child: Column(
              children: [
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  data.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: 682,
            child: FilledButton(
              onPressed: onNext,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFF88A2A),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: Text(buttonLabel),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  final String imagePath;
  final String title;
  final String description;
}
