import 'package:flutter/material.dart';
import '../../widgets/top_navbar.dart';
import '../../theme/app_theme.dart';

class AboutGladeScreen extends StatelessWidget {
  const AboutGladeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme.backgroundColor,
        child: Column(
          children: [
            const SubSettingsTopNavbar(title: 'About Glade'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20), // Adjusted outer padding
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppTheme.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical:
                            20, // Increased vertical padding for inner space
                        horizontal:
                            20, // Added horizontal padding for inner space
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.info,
                            size: 52,
                            color: Color.fromRGBO(81, 45, 168, 1),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Glade App',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'A mobile application designed to revolutionize the way students track and showcase their academic achievements. Our platform fosters a sense of friendly competition among students, promoting motivation and engagement in their respective learning fields.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 33),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.info,
                                          size: 36,
                                          color: Color.fromRGBO(81, 45, 168, 1),
                                        ),
                                        const SizedBox(height: 46),
                                        const Icon(
                                          Icons.info,
                                          size: 36,
                                          color: Color.fromRGBO(81, 45, 168, 1),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Need Help?\n',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              'Check our FAQ or contact support.',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                            Text(
                                              'Version Information',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 7),
                                            Text(
                                              'Glade v 1.0.0 - Last updated April 24',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 73),
                                const SizedBox(
                                  width: 247,
                                  child: Text(
                                    '© 2025 Glade. Empowering student achievements, one milestone at a time.',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
