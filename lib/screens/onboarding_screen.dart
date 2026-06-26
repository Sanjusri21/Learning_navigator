import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentPage = 0;

  final List<Map<String, dynamic>> pages = [
    {
      'icon': Icons.school,
      'title': 'Learn Anywhere',
      'subtitle': 'Access courses and study materials anytime.',
    },
    {
      'icon': Icons.track_changes,
      'title': 'Track Progress',
      'subtitle': 'Monitor your learning journey effectively.',
    },
    {
      'icon': Icons.psychology,
      'title': 'AI Guidance',
      'subtitle': 'Personalized recommendations powered by AI.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Container(
          width: 350,
          height: 650,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: pages.length,
                  onPageChanged: (value) => setState(() => currentPage = value),
                  itemBuilder: (_, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2563EB), Color(0xFFA855F7)],
                            ),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Icon(
                            pages[index]['icon'] as IconData,
                            color: Colors.white,
                            size: 70,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          pages[index]['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          pages[index]['subtitle'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Dot indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.all(4),
                    width: currentPage == index ? 25 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: currentPage == index
                          ? const LinearGradient(
                              colors: [Color(0xFF2563EB), Color(0xFFA855F7)],
                            )
                          : null,
                      color: currentPage == index ? null : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (currentPage == pages.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2563EB), Color(0xFFA855F7)],
                      ),
                      // FIXED: was BorderRadius.circula(18) — typo corrected
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Text(
                        currentPage == pages.length - 1 ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}