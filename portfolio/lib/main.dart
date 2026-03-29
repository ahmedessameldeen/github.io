import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

const Color primaryBg = Color(0xFF030014);
const Color secondaryBg = Color(0xFF0A0A1A);
const Color accentColor = Color(0xFF8B26EB);
const Color accentSecondary = Color(0xFF0AD3FF);
const Color textLight = Color(0xFFFFFFFF);
const Color textGray = Color(0xFFB7B8C9);
const Color textGrayLight = Color(0xFFCBD5E1);
const Color cardBg = Color(0xFF1A0E2E);
const Color borderColor = Color(0xFF7042F8);

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahmed Essamedeen - Mobile Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: primaryBg,
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
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

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: primaryBg.withOpacity(0.8),
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryBg.withOpacity(0.1),
                secondaryBg.withOpacity(0.1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [accentColor, accentSecondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            'Ahmed Essamedeen',
            style: TextStyle(
              color: textLight,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          _buildNavItem('Home', _heroKey),
          _buildNavItem('About', _aboutKey),
          _buildNavItem('Projects', _projectsKey),
          _buildNavItem('Skills', _skillsKey),
          _buildNavItem('Contact', _contactKey),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Hero Section
            Container(
              key: _heroKey,
              padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [accentColor, accentSecondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      'Ahmed Essamedeen',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: textLight,
                        height: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      border: Border.all(color: accentColor.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text(
                      '🚀 Web & Mobile Developer',
                      style: TextStyle(
                        fontSize: 20,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Crafting exceptional digital experiences with cutting-edge technology. '
                    'Specializing in web and mobile development with modern frameworks.',
                    style: TextStyle(
                      fontSize: 20,
                      color: textGray,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _scrollToSection(_projectsKey),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor,
                          foregroundColor: primaryBg,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 8,
                          shadowColor: accentColor.withOpacity(0.3),
                        ),
                        child: const Text(
                          'View My Work',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton(
                        onPressed: () => _scrollToSection(_contactKey),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: accentColor),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Contact Me',
                          style: TextStyle(
                            color: accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Professional Journey
            _buildSection(
              'About Me',
              Column(
                children: [
                  _buildExperienceCard(
                    'Senior Android Developer',
                    'SameSystem - Retail Workforce Solutions',
                    'Jan 2020 - Present',
                    'Developed and maintained enterprise-level retail management platform. '
                    'Led architecture decisions, mentored junior developers, and optimized performance.',
                  ),
                  _buildExperienceCard(
                    'Mobile Developer',
                    'Argaam Media',
                    'Sep 2019 - Apr 2020',
                    'Built media streaming and distribution platform. Implemented real-time data syncing.',
                  ),
                  _buildExperienceCard(
                    'Mobile Developer',
                    'Code95',
                    'Mar 2017 - Sep 2019',
                    'Developed multiple commercial Android applications. Led UI/UX improvements.',
                  ),
                  _buildExperienceCard(
                    'Android Developer',
                    'magdsoft',
                    'Mar 2016 - Mar 2017',
                    'Built Android applications from concept to production. Implemented Firebase integration.',
                  ),
                ],
              ),
              key: _aboutKey,
            ),

            // Tech Arsenal
            _buildSection(
              'Tech Stack',
              GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 6 : (MediaQuery.of(context).size.width > 800 ? 4 : 3),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildTechIcon('Android', Icons.android),
                  _buildTechIcon('iOS', Icons.apple),
                  _buildTechIcon('Flutter', Icons.flutter_dash),
                  _buildTechIcon('Java', Icons.code),
                  _buildTechIcon('Kotlin', Icons.code),
                  _buildTechIcon('Swift', Icons.code),
                  _buildTechIcon('Firebase', Icons.cloud),
                  _buildTechIcon('REST API', Icons.api),
                  _buildTechIcon('SQLite', Icons.storage),
                  _buildTechIcon('MVVM', Icons.architecture),
                  _buildTechIcon('Clean Code', Icons.cleaning_services),
                  _buildTechIcon('Git', Icons.commit),
                ],
              ),
            ),

            // Featured Projects
            _buildSection(
              'Featured Projects',
              GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 3 : (MediaQuery.of(context).size.width > 800 ? 2 : 1),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildProjectCard(
                    'Retail Workforce Solutions',
                    'Enterprise platform for retail management with real-time employee scheduling '
                    'and task synchronization across multiple stores.',
                    ['Android', 'Java', 'REST API', 'SQLite'],
                  ),
                  _buildProjectCard(
                    'Media Streaming Platform',
                    'Full-featured media distribution platform with live streaming, '
                    'content management, and user analytics.',
                    ['Android', 'Kotlin', 'Firebase', 'Real-time Sync'],
                  ),
                  _buildProjectCard(
                    'E-Commerce Mobile App',
                    'Complete e-commerce solution with payment gateway integration, '
                    'product catalog, and order tracking.',
                    ['Android', 'iOS', 'Payment Gateway', 'Analytics'],
                  ),
                  _buildProjectCard(
                    'AR Product Visualization',
                    'Augmented reality features for product visualization and virtual try-on experiences.',
                    ['Android', 'ARCore', 'AR', 'Java'],
                  ),
                ],
              ),
              key: _projectsKey,
            ),

            // Skills Matrix
            _buildSection(
              'Skills & Proficiency',
              GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 800 ? 2 : 1,
                crossAxisSpacing: 40,
                mainAxisSpacing: 40,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildSkillRow('Java', 0.95),
                  _buildSkillRow('Android Development', 0.95),
                  _buildSkillRow('Mobile Architecture', 0.90),
                  _buildSkillRow('Kotlin', 0.85),
                  _buildSkillRow('iOS Development', 0.85),
                  _buildSkillRow('AR/VR Development', 0.80),
                ],
              ),
              key: _skillsKey,
            ),

            // Contact Section
            Container(
              key: _contactKey,
              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [accentColor, accentSecondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      'Let\'s Build Something Amazing',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: textLight,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Ready for exciting opportunities, collaborations, and fresh challenges in mobile development',
                    style: TextStyle(
                      fontSize: 18,
                      color: textGray,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildContactForm(),
                      const SizedBox(width: 60),
                      _buildContactInfo(),
                    ],
                  ),
                  const SizedBox(height: 60),
                  const Text(
                    '© 2026 Ahmed Essamedeen. Crafted with ❤️ for mobile innovation.',
                    style: TextStyle(
                      color: textGray,
                      fontSize: 14,
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

  Widget _buildSection(String title, Widget child, {GlobalKey? key}) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [accentColor, accentSecondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: textLight,
              ),
            ),
          ),
          const SizedBox(height: 40),
          child,
        ],
      ),
    );
  }

  Widget _buildExperienceCard(
    String title,
    String company,
    String period,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: cardBg,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            company,
            style: const TextStyle(
              fontSize: 16,
              color: accentColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            period,
            style: const TextStyle(
              fontSize: 14,
              color: textGray,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: textGray,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechBadge(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: cardBg,
        border: Border.all(color: accentColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.1),
            blurRadius: 5,
          ),
        ],
      ),
      child: Text(
        tech,
        style: const TextStyle(
          fontSize: 14,
          color: textLight,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTechIcon(String name, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        border: Border.all(color: borderColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: accentColor,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              color: textGray,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    String title,
    String description,
    List<String> tags,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: cardBg,
        border: Border.all(color: borderColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mockup image placeholder
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              gradient: LinearGradient(
                colors: [accentColor.withOpacity(0.2), accentSecondary.withOpacity(0.2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.phone_android,
                size: 60,
                color: accentColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textLight,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: textGray,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: tags
                      .map((tag) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: accentColor.withOpacity(0.1),
                              border: Border.all(color: accentColor.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(
                                fontSize: 12,
                                color: accentColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: textLight,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('View Demo'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: accentColor.withOpacity(0.5)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'GitHub',
                        style: TextStyle(color: accentColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillRow(String skill, double proficiency) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textLight,
                ),
              ),
              Text(
                '${(proficiency * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 14,
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: proficiency,
              minHeight: 8,
              backgroundColor: borderColor,
              valueColor: const AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, GlobalKey key) {
    return TextButton(
      onPressed: () => _scrollToSection(key),
      child: Text(
        label,
        style: const TextStyle(
          color: textLight,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Send Message',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textLight,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: const TextStyle(color: textGray),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: accentColor),
              ),
              filled: true,
              fillColor: secondaryBg,
            ),
            style: const TextStyle(color: textLight),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: const TextStyle(color: textGray),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: accentColor),
              ),
              filled: true,
              fillColor: secondaryBg,
            ),
            style: const TextStyle(color: textLight),
          ),
          const SizedBox(height: 16),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Message',
              labelStyle: const TextStyle(color: textGray),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: accentColor),
              ),
              filled: true,
              fillColor: secondaryBg,
            ),
            style: const TextStyle(color: textLight),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => launchUrl(Uri.parse('mailto:ahmedessamedeen@gmail.com')),
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: primaryBg,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              'Send Message',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Get in Touch',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textLight,
          ),
        ),
        const SizedBox(height: 24),
        _buildContactItem('📧', 'ahmedessamedeen@gmail.com'),
        const SizedBox(height: 16),
        _buildContactItem('📍', 'Egypt'),
        const SizedBox(height: 16),
        _buildContactItem('💼', 'Available for opportunities'),
        const SizedBox(height: 32),
        Row(
          children: [
            _buildSocialIcon('GitHub', 'https://github.com/ahmedessameldeen'),
            const SizedBox(width: 16),
            _buildSocialIcon('LinkedIn', 'https://linkedin.com/in/ahmedessamedeen'),
          ],
        ),
      ],
    );
  }

  Widget _buildContactItem(String icon, String text) {
    return Row(
      children: [
        Text(
          icon,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: textGray,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String platform, String url) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          platform,
          style: const TextStyle(
            color: accentColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}