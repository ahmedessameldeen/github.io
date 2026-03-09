import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahmed Essamedeen - Senior Android Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F2937),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> with TickerProviderStateMixin {
  late AnimationController _heroController;
  late Animation<double> _heroAnimation;

  @override
  void initState() {
    super.initState();
    _heroController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _heroAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroController, curve: Curves.easeOut),
    );
    _heroController.forward();
  }

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1F2937), Color(0xFF374151)],
                ),
              ),
              child: Center(
                child: FadeTransition(
                  opacity: _heroAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white24,
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Ahmed Essamedeen',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Senior Android Developer',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'SameSystem - Retail Workforce Solutions',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF1F2937),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('View My Work'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // About Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'About Me',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mobile Development Expert',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Senior Android Developer with 6+ years of professional experience in designing and developing scalable mobile applications. '
                              'Specialized in Android and iOS development with expertise in Augmented Reality technology. '
                              'Proven track record of delivering high-quality solutions, leading technical teams, and driving innovation in mobile development. '
                              'Strong focus on performance optimization, user experience, and best practices in mobile architecture.',
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.6,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _buildSkillChip('Android'),
                                _buildSkillChip('Java'),
                                _buildSkillChip('iOS'),
                                _buildSkillChip('Augmented Reality'),
                                _buildSkillChip('Mobile Development'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F2937).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.code,
                          size: 100,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Skills & Technologies Section
            Container(
              color: Colors.grey[50],
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Skills & Technologies',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _buildSkillCard('Java', 0.95),
                      _buildSkillCard('Android', 0.95),
                      _buildSkillCard('AR/VR', 0.85),
                      _buildSkillCard('iOS', 0.85),
                      _buildSkillCard('Kotlin', 0.8),
                      _buildSkillCard('Mobile Architecture', 0.9),
                    ],
                  ),
                  const SizedBox(height: 60),
                  const Divider(),
                  const SizedBox(height: 60),
                  const Text(
                    'Languages',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _buildLanguageCard('Arabic', 'Native'),
                      _buildLanguageCard('English', 'Fluent'),
                      _buildLanguageCard('French', 'Intermediate'),
                    ],
                  ),
                ],
              ),
            ),

            // Experience Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Experience',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildExperienceCard(
                    'Senior Android Developer',
                    'SameSystem - Retail Workforce Solutions',
                    'January 2020 - Present (6 years 3 months)',
                    'Egypt',
                  ),
                  const SizedBox(height: 20),
                  _buildExperienceCard(
                    'Mobile Developer',
                    'Argaam Media',
                    'September 2019 - April 2020 (8 months)',
                    'Cairo, Egypt',
                  ),
                  const SizedBox(height: 20),
                  _buildExperienceCard(
                    'Mobile Developer',
                    'Code95',
                    'March 2017 - September 2019 (2 years 7 months)',
                    'Ismailia, Egypt',
                  ),
                  const SizedBox(height: 20),
                  _buildExperienceCard(
                    'Android Developer',
                    'magdsoft',
                    'March 2016 - March 2017 (1 year 1 month)',
                    'Nasr City, Egypt',
                  ),
                ],
              ),
            ),

            // Projects Gallery Section
            Container(
              color: Colors.grey[50],
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Featured Projects',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: _buildProjectCard(
                          'Retail Workforce Solutions',
                          'Enterprise mobile platform for retail management and employee scheduling with real-time synchronization.',
                          ['Android', 'Java', 'REST API', 'Backend Integration'],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildProjectCard(
                          'Augmented Reality Features',
                          'Implemented cutting-edge AR capabilities for product visualization and enhanced customer engagement.',
                          ['Android', 'Augmented Reality', 'ARCore', 'Java'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildProjectCard(
                          'Media Platform',
                          'Mobile application for seamless media content distribution and management with streaming capabilities.',
                          ['Android', 'Streaming', 'Media APIs', 'Java'],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildProjectCard(
                          'E-Commerce Solutions',
                          'Cross-platform mobile applications with integrated payment gateway and user management.',
                          ['Android', 'iOS', 'Payment Gateway', 'Java/Kotlin'],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Education Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Education',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildEducationCard(
                    'Bachelor of Computer Engineering',
                    'Zagazig University Faculty of Engineering',
                    '2008 - 2013',
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Certifications',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildCertChip('Management of Change'),
                      _buildCertChip('SQL Fundamentals'),
                      _buildCertChip('C++ Course'),
                      _buildCertChip('Java Course'),
                      _buildCertChip('Networking Fundamentals'),
                    ],
                  ),
                ],
              ),
            ),

            // Contact Section
            Container(
              color: const Color(0xFF1F2937),
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Get In Touch',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Let\'s connect and discuss opportunities',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildContactButton(Icons.email, 'Email', () {}),
                      const SizedBox(width: 20),
                      _buildContactButton(Icons.phone, 'Phone', () {}),
                      const SizedBox(width: 20),
                      _buildContactButton(Icons.link, 'LinkedIn', () {}),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Column(
                    children: [
                      Text(
                        'Email: ahmedessamedeen@gmail.com',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Phone: +201069682782',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'LinkedIn: linkedin.com/in/ahmedessamedeen',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '© 2026 Ahmed Essamedeen. All rights reserved.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Chip(
      label: Text(skill),
      backgroundColor: const Color(0xFF1F2937).withOpacity(0.1),
      labelStyle: const TextStyle(color: Color(0xFF1F2937)),
    );
  }

  Widget _buildSkillCard(String skill, double proficiency) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            skill,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: proficiency,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1F2937)),
          ),
          const SizedBox(height: 8),
          Text(
            '${(proficiency * 100).toInt()}%',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard(String language, String level) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            language,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            level,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(String title, String company, String duration, String location) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      company,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1F2937),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String title, String description, List<String> technologies) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: technologies.map((tech) => Chip(
              label: Text(tech),
              backgroundColor: const Color(0xFF1F2937).withOpacity(0.1),
              labelStyle: const TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 12,
              ),
            )).toList(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F2937),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('View Project'),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(String degree, String institution, String years) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  degree,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  institution,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            years,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1F2937),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertChip(String cert) {
    return Chip(
      label: Text(cert),
      backgroundColor: Colors.white,
      side: const BorderSide(color: Color(0xFF1F2937), width: 1),
      labelStyle: const TextStyle(
        color: Color(0xFF1F2937),
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildContactButton(IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}