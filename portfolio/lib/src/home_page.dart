import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/l10n/app_localizations.dart';
import 'package:portfolio/providers/language_provider.dart';
import 'package:portfolio/src/constants.dart';
import 'package:portfolio/src/animations.dart';
import 'package:portfolio/src/widgets.dart';
import 'package:portfolio/widgets/language_switch.dart';

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
  int _selectedIndex = 0;

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

  bool _isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 900;
  }

  bool _isMobileAppStyle(BuildContext context) {
    return MediaQuery.of(context).size.width < 700;
  }

  double _sectionHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 20;
    if (width < 1000) return 30;
    return 40;
  }

  void _showMobileNavMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Navigate',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textLight,
                ),
              ),
              const SizedBox(height: 20),
              _buildMobileNavTile(
                AppLocalizations.of(context)!.navHome,
                _heroKey,
                context,
              ),
              _buildMobileNavTile(
                AppLocalizations.of(context)!.navJourney,
                _aboutKey,
                context,
              ),
              _buildMobileNavTile(
                AppLocalizations.of(context)!.navProjects,
                _projectsKey,
                context,
              ),
              _buildMobileNavTile(
                AppLocalizations.of(context)!.navSkills,
                _skillsKey,
                context,
              ),
              _buildMobileNavTile(
                AppLocalizations.of(context)!.navContact,
                _contactKey,
                context,
              ),
              const SizedBox(height: 20),
              const LanguageSwitch(),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileNavTile(String label, GlobalKey key, BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: const TextStyle(color: textLight, fontSize: 16),
      ),
      trailing: const Icon(Icons.chevron_right, color: accentColor),
      onTap: () {
        Navigator.of(context).pop();
        _scrollToSection(key);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isMobileAppStyle = _isMobileAppStyle(context);

    return Directionality(
      textDirection: languageProvider.isRTL
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
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
              'Ahmed Essam',
              style: TextStyle(
                color: textLight,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          actions: _isMobile(context)
              ? [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () => _showMobileNavMenu(context),
                  ),
                ]
              : [
                  _buildNavItem(AppLocalizations.of(context)!.navHome, _heroKey),
                  _buildNavItem(AppLocalizations.of(context)!.navJourney, _aboutKey),
                  _buildNavItem(
                    AppLocalizations.of(context)!.navProjects,
                    _projectsKey,
                  ),
                  _buildNavItem(AppLocalizations.of(context)!.navSkills, _skillsKey),
                  _buildNavItem(
                    AppLocalizations.of(context)!.navContact,
                    _contactKey,
                  ),
                  const LanguageSwitch(),
                  const SizedBox(width: 20),
                ],
        ),
        body: isMobileAppStyle
            ? _buildMobileAppShell(
                context,
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      _buildHeroSection(context),
                      _buildJourneySection(context),
                      _buildStackShowcaseSection(context),
                      _buildSkillsSection(context),
                      _buildProjectsSection(context),
                      _buildContactSection(context),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    _buildHeroSection(context),
                    _buildJourneySection(context),
                    _buildStackShowcaseSection(context),
                    _buildSkillsSection(context),
                    _buildProjectsSection(context),
                    _buildContactSection(context),
                  ],
                ),
              ),
        bottomNavigationBar: isMobileAppStyle
            ? BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _handleMobileTabTap,
                selectedItemColor: accentColor,
                unselectedItemColor: textGray,
                showUnselectedLabels: false,
                showSelectedLabels: true,
                type: BottomNavigationBarType.fixed,
                backgroundColor: primaryBg,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: AppLocalizations.of(context)!.navHome,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.timeline),
                    label: AppLocalizations.of(context)!.navJourney,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.phone_android),
                    label: AppLocalizations.of(context)!.navProjects,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.star),
                    label: AppLocalizations.of(context)!.navSkills,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.mail),
                    label: AppLocalizations.of(context)!.navContact,
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Container(
      key: _heroKey,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 80 : 120,
        horizontal: _sectionHorizontalPadding(context),
      ),
      child: FadeInUp(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [accentColor, accentSecondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                AppLocalizations.of(context)!.heroName,
                style: TextStyle(
                  fontSize: isMobile ? 42 : 64,
                  fontWeight: FontWeight.bold,
                  color: textLight,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                border: Border.all(color: accentColor.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                '🚀 ${AppLocalizations.of(context)!.heroTitle}',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 20,
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              AppLocalizations.of(context)!.heroDescription,
              style: TextStyle(
                fontSize: isMobile ? 16 : 20,
                color: textGray,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () => _scrollToSection(_projectsKey),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: primaryBg,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 28 : 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                    shadowColor: accentColor.withOpacity(0.3),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.heroCta,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () => _scrollToSection(_contactKey),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: accentColor),
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 28 : 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.heroContact,
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
    );
  }

  Widget _buildStackShowcaseSection(BuildContext context) {
    return _buildSection(
      context,
      'Development Stack',
      FadeInUp(
        child: const TechStackShowcase(),
      ),
    );
  }

  Widget _buildJourneySection(BuildContext context) {
    final isMobile = _isMobile(context);
    final journeyItems = [
      _buildCareerStep(
        AppLocalizations.of(context)!.companyMagdsoft,
        AppLocalizations.of(context)!.jobAndroidDeveloper,
        AppLocalizations.of(context)!.period2016_2017,
        'https://www.magdsoft.com/teamwork',
        isMobile: isMobile,
      ),
      _buildCareerStep(
        AppLocalizations.of(context)!.companyCode95,
        AppLocalizations.of(context)!.jobMobileDeveloper,
        AppLocalizations.of(context)!.period2017_2019,
        'https://code95.com/',
        isMobile: isMobile,
      ),
      _buildCareerStep(
        AppLocalizations.of(context)!.companyArgaam,
        AppLocalizations.of(context)!.jobMobileDeveloper,
        AppLocalizations.of(context)!.period2019_2020,
        'https://www.media.argaam.com/',
        isMobile: isMobile,
      ),
      _buildCareerStep(
        AppLocalizations.of(context)!.companySamesystem,
        AppLocalizations.of(context)!.jobSeniorAndroidDeveloper,
        AppLocalizations.of(context)!.period2020_present,
        'https://www.samesystem.com/',
        isMobile: isMobile,
      ),
    ];

    return _buildSection(
      context,
      AppLocalizations.of(context)!.journeyTitle,
      isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                journeyItems.length * 2 - 1,
                (index) {
                  if (index.isOdd) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Icon(
                          Icons.arrow_downward,
                          color: accentColor,
                          size: 20,
                        ),
                      ),
                    );
                  }
                  return journeyItems[index ~/ 2];
                },
              ),
            )
          : SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    journeyItems[0],
                    _buildCareerArrow(),
                    journeyItems[1],
                    _buildCareerArrow(),
                    journeyItems[2],
                    _buildCareerArrow(),
                    journeyItems[3],
                  ],
                ),
              ),
            ),
      key: _aboutKey,
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemSize = width < 600 ? 76.0 : 88.0;
    return _buildSection(
      context,
      AppLocalizations.of(context)!.skillsTitle,
      Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 18,
          runSpacing: 18,
          children: [
            _buildTechIcon('Android', Icons.android, size: itemSize),
            _buildTechIcon('iOS', Icons.apple, size: itemSize),
            _buildTechIcon('Flutter', Icons.flutter_dash, size: itemSize),
            _buildTechIcon('Java', Icons.code, size: itemSize),
            _buildTechIcon('Kotlin', Icons.code, size: itemSize),
            _buildTechIcon('Swift', Icons.code, size: itemSize),
            _buildTechIcon('Firebase', Icons.cloud, size: itemSize),
            _buildTechIcon('REST API', Icons.api, size: itemSize),
            _buildTechIcon('SQLite', Icons.storage, size: itemSize),
            _buildTechIcon('MVVM', Icons.architecture, size: itemSize),
            _buildTechIcon('Clean Code', Icons.cleaning_services, size: itemSize),
            _buildTechIcon('Git', Icons.commit, size: itemSize),
          ],
        ),
      ),
      key: _skillsKey,
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    return _buildSection(
      context,
      AppLocalizations.of(context)!.projectsTitle,
      FadeInUp(
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 1200
              ? 3
              : (MediaQuery.of(context).size.width > 800 ? 2 : 1),
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
      ),
      key: _projectsKey,
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final isMobile = _isMobile(context);
    return Container(
      key: _contactKey,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: _sectionHorizontalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [accentColor, accentSecondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              AppLocalizations.of(context)!.contactTitle,
              style: TextStyle(
                fontSize: isMobile ? 36 : 48,
                fontWeight: FontWeight.bold,
                color: textLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Ready for exciting opportunities, collaborations, and fresh challenges in mobile development',
            style: TextStyle(fontSize: isMobile ? 16 : 18, color: textGray),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: isMobile ? double.infinity : 400,
                child: _buildContactForm(),
              ),
              SizedBox(width: isMobile ? 0 : 60, height: isMobile ? 30 : 0),
              SizedBox(
                width: isMobile ? double.infinity : 320,
                child: _buildContactInfo(),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            AppLocalizations.of(context)!.footerCopyright,
            style: const TextStyle(color: textGray, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget child, {GlobalKey? key}) {
    final isMobile = _isMobile(context);
    return Container(
      key: key,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: _sectionHorizontalPadding(context),
      ),
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
              style: TextStyle(
                fontSize: isMobile ? 32 : 48,
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

  Widget _buildCareerStep(
    String company,
    String role,
    String period,
    String url, {
    bool isMobile = false,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: isMobile ? double.infinity : 300,
        margin: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 8, vertical: isMobile ? 8 : 0),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            hoverColor: accentColor.withOpacity(0.13),
            onTap: () => launchUrl(Uri.parse(url)),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: accentColor.withOpacity(0.4)),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [cardBg.withOpacity(0.95), cardBg],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.business_center,
                        color: accentSecondary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          company,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    role,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: accentSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    period,
                    style: const TextStyle(fontSize: 13, color: textGray),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCareerArrow() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Icon(
          Icons.arrow_forward_ios,
          color: accentColor,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildMobileAppShell(BuildContext context, Widget child) {
    return SafeArea(
      child: Container(
        color: primaryBg,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 520),
            decoration: BoxDecoration(
              color: secondaryBg,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: borderColor.withOpacity(0.7), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withOpacity(0.18),
                  blurRadius: 30,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 8),
                  width: 72,
                  height: 6,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: primaryBg.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.heroTitle,
                        style: const TextStyle(
                          color: textLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.signal_cellular_alt, color: accentColor, size: 18),
                          const SizedBox(width: 8),
                          Icon(Icons.wifi, color: accentColor, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            '100%',
                            style: const TextStyle(color: textLight, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTechIcon(String name, IconData icon, {double size = 40.0}) {
    return Tooltip(
      message: name,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: accentColor.withOpacity(0.1),
          ),
          padding: EdgeInsets.all(size * 0.4),
          child: Icon(
            icon,
            size: size,
            color: accentColor,
          ),
        ),
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
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              gradient: LinearGradient(
                colors: [
                  accentColor.withOpacity(0.2),
                  accentSecondary.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(Icons.phone_android, size: 60, color: accentColor),
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
                  style: TextStyle(fontSize: 16, color: textGray, height: 1.6),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: tags
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: accentColor.withOpacity(0.1),
                            border: Border.all(
                              color: accentColor.withOpacity(0.3),
                            ),
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
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          HoverScaleButton(
                            onTap: () {},
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                foregroundColor: textLight,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('View Demo'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          HoverScaleButton(
                            onTap: () {},
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: accentColor.withOpacity(0.5),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'GitHub',
                                style: TextStyle(color: accentColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          AppStoreButton(
                            platform: 'App Store',
                            url: 'https://apps.apple.com',
                          ),
                          SizedBox(width: 12),
                          AppStoreButton(
                            platform: 'Google Play',
                            url: 'https://play.google.com',
                          ),
                        ],
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

  void _handleMobileTabTap(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        _scrollToSection(_heroKey);
        break;
      case 1:
        _scrollToSection(_aboutKey);
        break;
      case 2:
        _scrollToSection(_projectsKey);
        break;
      case 3:
        _scrollToSection(_skillsKey);
        break;
      case 4:
        _scrollToSection(_contactKey);
        break;
    }
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
            onPressed: () =>
                launchUrl(Uri.parse('mailto:ahmedessamedeen@gmail.com')),
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
            _buildSocialIcon(
              'LinkedIn',
              'https://linkedin.com/in/ahmedessamedeen',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactItem(String icon, String text) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(fontSize: 16, color: textGray)),
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
