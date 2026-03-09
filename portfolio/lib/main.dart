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
      title: 'Ahmed Essamedeen - Mobile Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F172A),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
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
  // keys for scrolling to specific sections
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  late AnimationController _heroController;
  late Animation<double> _heroAnimation;
  late AnimationController _scrollController;
  late ScrollController _pageScrollController;
  bool _showNavBar = true;

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _heroController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _heroAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroController, curve: Curves.easeOut),
    );
    _heroController.forward();

    _scrollController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pageScrollController = ScrollController();
    _pageScrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageScrollController.position.pixels > 100) {
      if (_showNavBar) {
        setState(() => _showNavBar = false);
      }
    } else {
      if (!_showNavBar) {
        setState(() => _showNavBar = true);
      }
    }
  }

  @override
  void dispose() {
    _heroController.dispose();
    _scrollController.dispose();
    _pageScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _pageScrollController,
        child: Column(
          children: [
            // Navigation Bar
            AnimatedOpacity(
              opacity: _showNavBar ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ahmed Essamedeen',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Row(
                      children: [
                        _buildNavLink('About'),
                        _buildNavLink('Skills'),
                        _buildNavLink('Experience'),
                        _buildNavLink('Projects'),
                        _buildNavLink('Contact'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Hero Section with Enhanced Design
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0F172A),
                    const Color(0xFF1E293B),
                    const Color(0xFF334155),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Animated background elements
                  Positioned(
                    top: -100,
                    right: -100,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF3B82F6).withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    left: -50,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF8B5CF6).withOpacity(0.1),
                      ),
                    ),
                  ),
                  Center(
                    child: FadeTransition(
                      opacity: _heroAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(_heroAnimation),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ScaleTransition(
                              scale: Tween<double>(begin: 0.5, end: 1.0).animate(
                                CurvedAnimation(parent: _heroController, curve: Curves.easeOut),
                              ),
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      const Color(0xFF3B82F6),
                                      const Color(0xFF8B5CF6),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF3B82F6).withOpacity(0.4),
                                      blurRadius: 30,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            const Text(
                              'Ahmed Essamedeen',
                              style: TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: const [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                              ).createShader(bounds),
                              child: const Text(
                                'Mobile Developer',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Crafting Exceptional Mobile Experiences',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildCTAButton(
                                  'Explore Work',
                                  const Color(0xFF3B82F6),
                                  () => _scrollToSection(_projectsKey),
                                ),
                                const SizedBox(width: 20),
                                _buildCTAButton(
                                  'Contact Me',
                                  Colors.transparent,
                                  () => _scrollToSection(_contactKey),
                                  outlined: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // About Section
            _buildSection(
              'About Me',
              Container(
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mobile Development Expert',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'With 6+ years of professional experience, I specialize in creating robust and scalable mobile applications for Android and iOS. '
                            'My expertise spans from native development to cutting-edge technologies like Augmented Reality.\n\n'
                            'I\'m passionate about writing clean code, optimizing performance, and delivering exceptional user experiences. '
                            'I thrive in collaborative environments and am always eager to learn new technologies and best practices.',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.8,
                              color: Colors.grey,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildSkillTag('Android'),
                              _buildSkillTag('Java'),
                              _buildSkillTag('Kotlin'),
                              _buildSkillTag('iOS'),
                              _buildSkillTag('AR/VR'),
                              _buildSkillTag('Mobile Architecture'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 60),
                    Container(
                      width: 320,
                      height: 320,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF3B82F6).withOpacity(0.1),
                            const Color(0xFF8B5CF6).withOpacity(0.1),
                          ],
                        ),
                        border: Border.all(
                          color: const Color(0xFF3B82F6).withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.code,
                          size: 120,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Skills Section
            _buildSection(
              'Technical Skills',
              Container(
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 30,
                      runSpacing: 30,
                      children: [
                        _buildSkillCardAnimated('Java', 0.95, Icons.code),
                        _buildSkillCardAnimated('Android', 0.95, Icons.smartphone),
                        _buildSkillCardAnimated('AR/VR', 0.85, Icons.view_in_ar),
                        _buildSkillCardAnimated('iOS', 0.85, Icons.apple),
                        _buildSkillCardAnimated('Kotlin', 0.80, Icons.code),
                        _buildSkillCardAnimated('Architecture', 0.90, Icons.cloud),
                      ],
                    ),
                    const SizedBox(height: 60),
                    const Divider(height: 1),
                    const SizedBox(height: 60),
                    const Text(
                      'Languages',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Wrap(
                      spacing: 30,
                      runSpacing: 30,
                      children: [
                        _buildLanguageCard('Arabic', 'Native Speaker'),
                        _buildLanguageCard('English', 'Fluent'),
                        _buildLanguageCard('French', 'Intermediate'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Experience Timeline
            _buildSection(
              'Professional Experience',
              Container(
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                child: Column(
                  children: [
                    _buildExperienceTimelineItem(
                      'Senior Android Developer',
                      'SameSystem - Retail Workforce Solutions',
                      'January 2020 - Present',
                      '6 years 3 months',
                      'Egypt',
                      isFirst: true,
                    ),
                    _buildExperienceTimelineItem(
                      'Mobile Developer',
                      'Argaam Media',
                      'September 2019 - April 2020',
                      '8 months',
                      'Cairo, Egypt',
                    ),
                    _buildExperienceTimelineItem(
                      'Mobile Developer',
                      'Code95',
                      'March 2017 - September 2019',
                      '2 years 7 months',
                      'Ismailia, Egypt',
                    ),
                    _buildExperienceTimelineItem(
                      'Android Developer',
                      'magdsoft',
                      'March 2016 - March 2017',
                      '1 year 1 month',
                      'Nasr City, Egypt',
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),

            // Projects Gallery Section
            _buildSection(
              'Featured Projects',
              Container(
                key: _projectsKey,
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                child: Column(
                  children: [
                    const Text(
                      'Showcase of Recent Work',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildProjectCardWithHover(
                          'Retail Workforce Solutions',
                          'Enterprise platform for retail management and employee scheduling with real-time synchronization.',
                          ['Android', 'Java', 'REST API', 'Backend'],
                          Icons.business,
                        ),
                        _buildProjectCardWithHover(
                          'Augmented Reality Features',
                          'Cutting-edge AR implementation for product visualization and enhanced customer engagement.',
                          ['Android', 'AR', 'ARCore', 'Java'],
                          Icons.view_in_ar,
                        ),
                        _buildProjectCardWithHover(
                          'Media Platform',
                          'Seamless media content distribution with streaming capabilities and user management.',
                          ['Android', 'Streaming', 'Media APIs', 'Java'],
                          Icons.play_circle,
                        ),
                        _buildProjectCardWithHover(
                          'E-Commerce Solutions',
                          'Cross-platform mobile applications with integrated payment gateway and analytics.',
                          ['Android', 'iOS', 'Payment', 'Analytics'],
                          Icons.shopping_cart,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Education Section
            _buildSection(
              'Education & Certifications',
              Container(
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                child: Column(
                  children: [
                    _buildEducationCard(
                      'Bachelor of Computer Engineering',
                      'Zagazig University Faculty of Engineering',
                      '2008 - 2013',
                      Icons.school,
                    ),
                    const SizedBox(height: 60),
                    const Text(
                      'Professional Certifications',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildCertBadge('Management of Change'),
                        _buildCertBadge('SQL Fundamentals'),
                        _buildCertBadge('C++ Course'),
                        _buildCertBadge('Java Course'),
                        _buildCertBadge('Networking Fundamentals'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Contact Section
            Container(
              key: _contactKey,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0F172A),
                    const Color(0xFF1E293B),
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
              child: Column(
                children: [
                  const Text(
                    'Let\'s Connect',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Open for opportunities and collaborations',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildContactIconButton(
                        Icons.email,
                        'ahmedessamedeen@gmail.com',
                        () => launchUrl(Uri.parse('mailto:ahmedessamedeen@gmail.com')),
                      ),
                      const SizedBox(width: 30),
                      _buildContactIconButton(
                        Icons.phone,
                        '+201069682782',
                        () => launchUrl(Uri.parse('tel:+201069682782')),
                      ),
                      const SizedBox(width: 30),
                      _buildContactIconButton(
                        Icons.language,
                        'LinkedIn',
                        () => launchUrl(Uri.parse('https://linkedin.com/in/ahmedessamedeen')),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  const Divider(color: Colors.white30),
                  const SizedBox(height: 30),
                  const Text(
                    '© 2026 Ahmed Essamedeen. All rights reserved.',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      letterSpacing: 0.3,
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

  Widget _buildNavLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCTAButton(
    String text,
    Color bgColor,
    VoidCallback onPressed, {
    bool outlined = false,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: outlined ? Colors.transparent : bgColor,
          border: outlined
              ? Border.all(color: Colors.white, width: 2)
              : null,
          borderRadius: BorderRadius.circular(50),
          boxShadow: !outlined
              ? [
                  BoxShadow(
                    color: bgColor.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: outlined ? Colors.white : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildSkillTag(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3B82F6).withOpacity(0.1),
            const Color(0xFF8B5CF6).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: const Color(0xFF3B82F6).withOpacity(0.3),
        ),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          color: Color(0xFF3B82F6),
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildSkillCardAnimated(
    String skill,
    double proficiency,
    IconData icon,
  ) {
    return MouseRegion(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 180,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF3B82F6).withOpacity(0.1),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: const Color(0xFF3B82F6)),
            const SizedBox(height: 12),
            Text(
              skill,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: proficiency,
                minHeight: 6,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(proficiency * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard(String language, String level) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF3B82F6).withOpacity(0.1),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            language,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            level,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceTimelineItem(
    String title,
    String company,
    String period,
    String duration,
    String location, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withOpacity(0.4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 120,
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                  ),
              ],
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF3B82F6).withOpacity(0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      company,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          period,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF3B82F6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              location,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (!isLast) const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildProjectCardWithHover(
    String title,
    String description,
    List<String> tech,
    IconData icon,
  ) {
    return MouseRegion(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF3B82F6).withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withOpacity(0.15),
              blurRadius: 25,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.6,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tech.map((t) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    t,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF3B82F6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationCard(
    String degree,
    String institution,
    String years,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF3B82F6).withOpacity(0.1),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  degree,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  institution,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            years,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF3B82F6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertBadge(String cert) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3B82F6).withOpacity(0.1),
            const Color(0xFF8B5CF6).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: const Color(0xFF3B82F6).withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, size: 16, color: Color(0xFF3B82F6)),
          const SizedBox(width: 8),
          Text(
            cert,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactIconButton(
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          color: Colors.grey[50],
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[50],
          child: content,
        ),
      ],
    );
  }
}