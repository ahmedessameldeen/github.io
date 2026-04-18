import 'dart:ui';
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
  final GlobalKey _journeyKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  int _activeNavIndex = 0;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    final scrolled = _scrollController.offset > 20;
    if (scrolled != _isScrolled) setState(() => _isScrolled = scrolled);

    final keys = [_heroKey, _journeyKey, _skillsKey, _projectsKey, _contactKey];
    for (int i = keys.length - 1; i >= 0; i--) {
      final ctx = keys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final pos = box.localToGlobal(Offset.zero);
      if (pos.dy <= kNavBarHeight + 40) {
        if (_activeNavIndex != i) setState(() => _activeNavIndex = i);
        return;
      }
    }
    if (_activeNavIndex != 0) setState(() => _activeNavIndex = 0);
  }

  void _scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null) return;
    final targetY = box.localToGlobal(Offset.zero).dy +
        _scrollController.offset -
        kNavBarHeight;
    _scrollController.animateTo(
      targetY.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  bool get _isMobile => MediaQuery.of(context).size.width < kBreakpointMobile;

  double get _hPad =>
      _isMobile ? kSectionHorizontalPaddingMobile : kSectionHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LanguageProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: lp.isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: primaryBg,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context, l10n),
        body: Stack(
          children: [
            IgnorePointer(
              child: Stack(
                children: [
                  Positioned(
                    top: -150,
                    left: -100,
                    child: _buildOrb(accentColor, 500),
                  ),
                  Positioned(
                    top: 400,
                    right: -150,
                    child: _buildOrb(accentSecondary, 400),
                  ),
                  Positioned(
                    top: 900,
                    left: -80,
                    child: _buildOrb(accentColor, 350),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _buildHeroSection(context, l10n),
                  _buildJourneySection(context, l10n),
                  _buildSkillsSection(context, l10n),
                  _buildProjectsSection(context, l10n),
                  _buildContactSection(context, l10n),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrb(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(0.15),
            color.withOpacity(0.05),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, AppLocalizations l10n) {
    final isMobile = _isMobile;
    final navLabels = [
      l10n.navHome,
      l10n.navJourney,
      l10n.navSkills,
      l10n.navProjects,
      l10n.navContact,
    ];
    final navKeys = [_heroKey, _journeyKey, _skillsKey, _projectsKey, _contactKey];

    return PreferredSize(
      preferredSize: const Size.fromHeight(kNavBarHeight),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: kNavBarHeight,
            decoration: BoxDecoration(
              color: primaryBg.withOpacity(_isScrolled ? 0.7 : 0.0),
              border: Border(
                bottom: BorderSide(
                  color: borderColor.withOpacity(_isScrolled ? 0.3 : 0.0),
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _hPad),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _scrollToSection(_heroKey),
                    child: const GradientText(
                      'AE.',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                  ),
                  if (!isMobile)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(
                          navLabels.length,
                          (i) => _NavItem(
                            label: navLabels[i],
                            isActive: _activeNavIndex == i,
                            onTap: () => _scrollToSection(navKeys[i]),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const LanguageSwitch(),
                      ],
                    )
                  else
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const LanguageSwitch(),
                        IconButton(
                          icon: const Icon(Icons.menu_rounded, color: textLight),
                          onPressed: () =>
                              _showMobileMenu(context, navLabels, navKeys),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(
    BuildContext context,
    List<String> labels,
    List<GlobalKey> keys,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: borderColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ...List.generate(
                labels.length,
                (i) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    labels[i],
                    style: const TextStyle(color: textLight, fontSize: 16),
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded, color: accentColor),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToSection(keys[i]);
                  },
                ),
              ),
              const SizedBox(height: 8),
              const LanguageSwitch(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, AppLocalizations l10n) {
    final isMobile = _isMobile;
    return Container(
      key: _heroKey,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: _hPad,
        vertical: kNavBarHeight + 20,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInUp(
              child: Column(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [accentColor, accentSecondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withOpacity(0.5),
                          blurRadius: 30,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryBg,
                        ),
                        child: const Center(
                          child: Text(
                            'AE',
                            style: TextStyle(
                              color: textLight,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  GradientText(
                    l10n.heroName,
                    style: TextStyle(
                      fontSize: isMobile ? 42 : 68,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.12),
                      border: Border.all(color: accentColor.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      l10n.heroTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        color: accentSecondary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 24,
                runSpacing: 8,
                children: [
                  _buildStatItem('9+', 'Years Exp.'),
                  _buildStatDivider(),
                  _buildStatItem('Android · iOS · Flutter', 'Platforms'),
                  _buildStatDivider(),
                  _buildStatItem('Enterprise', 'Focus'),
                ],
              ),
            ),
            const SizedBox(height: 48),
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 12,
                children: [
                  HoverScaleButton(
                    onTap: () => _scrollToSection(_projectsKey),
                    child: _buildPrimaryButton(l10n.heroCta),
                  ),
                  HoverScaleButton(
                    onTap: () => _scrollToSection(_contactKey),
                    child: _buildOutlineButton(l10n.heroContact),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        GradientText(
          value,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: textGray)),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 36,
      color: borderColor.withOpacity(0.5),
    );
  }

  Widget _buildPrimaryButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [accentColor, accentSecondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildOutlineButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: accentColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: accentSecondary,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildJourneySection(BuildContext context, AppLocalizations l10n) {
    final entries = [
      (l10n.companyMagdsoft, l10n.jobAndroidDeveloper, l10n.period2016_2017, false),
      (l10n.companyCode95, l10n.jobMobileDeveloper, l10n.period2017_2019, false),
      (l10n.companyArgaam, l10n.jobMobileDeveloper, l10n.period2019_2020, false),
      (
        l10n.companySamesystem,
        l10n.jobSeniorAndroidDeveloper,
        l10n.period2020_present,
        true,
      ),
    ];

    return _buildSection(
      context,
      l10n.journeyTitle,
      Column(
        children: List.generate(entries.length, (i) {
          final e = entries[i];
          return ScrollReveal(
            scrollController: _scrollController,
            delay: Duration(milliseconds: i * 150),
            child: _buildTimelineItem(
              company: e.$1,
              role: e.$2,
              period: e.$3,
              isCurrent: e.$4,
              isLast: i == entries.length - 1,
            ),
          );
        }),
      ),
      key: _journeyKey,
    );
  }

  Widget _buildTimelineItem({
    required String company,
    required String role,
    required String period,
    required bool isCurrent,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: isCurrent ? 18 : 14,
                  height: isCurrent ? 18 : 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCurrent ? accentSecondary : accentColor,
                    boxShadow: isCurrent
                        ? [
                            BoxShadow(
                              color: accentSecondary.withOpacity(0.6),
                              blurRadius: 14,
                              spreadRadius: 3,
                            ),
                          ]
                        : null,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: borderColor.withOpacity(0.4),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: GlassCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            company,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: textLight,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            role,
                            style: const TextStyle(
                              fontSize: 14,
                              color: accentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            period,
                            style: const TextStyle(fontSize: 12, color: textGray),
                          ),
                        ],
                      ),
                    ),
                    if (isCurrent)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: accentSecondary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: accentSecondary.withOpacity(0.4),
                          ),
                        ),
                        child: const Text(
                          'Current',
                          style: TextStyle(
                            fontSize: 11,
                            color: accentSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context, AppLocalizations l10n) {
    final isMobile = _isMobile;
    final categories = [
      ('Mobile', [
        ('Android', Icons.android),
        ('iOS', Icons.apple),
        ('Flutter', Icons.flutter_dash),
        ('Kotlin', Icons.terminal),
        ('Java', Icons.coffee),
        ('Swift', Icons.bolt),
      ]),
      ('Backend', [
        ('Firebase', Icons.local_fire_department),
        ('REST API', Icons.api),
        ('SQLite', Icons.storage),
        ('WebSocket', Icons.cable),
      ]),
      ('Architecture', [
        ('MVVM', Icons.layers),
        ('Clean Code', Icons.auto_fix_high),
        ('Git', Icons.account_tree),
        ('Agile', Icons.loop),
        ('CI/CD', Icons.build_circle),
      ]),
    ];

    Widget skillCard(int i) {
      return ScrollReveal(
        scrollController: _scrollController,
        delay: Duration(milliseconds: i * 100),
        child: GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categories[i].$1,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: accentSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: categories[i].$2
                    .map((s) => SkillChip(s.$1, icon: s.$2))
                    .toList(),
              ),
            ],
          ),
        ),
      );
    }

    return _buildSection(
      context,
      l10n.skillsTitle,
      isMobile
          ? Column(
              children: List.generate(
                categories.length,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: skillCard(i),
                ),
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                categories.length,
                (i) => [
                  Expanded(child: skillCard(i)),
                  if (i < categories.length - 1) const SizedBox(width: 20),
                ],
              ).expand((w) => w).toList(),
            ),
      key: _skillsKey,
    );
  }

  static const _projects = [
    (
      'Retail Workforce Solutions',
      'Enterprise platform for employee scheduling and task sync across retail chains.',
      ['Android', 'Java', 'REST API', 'SQLite'],
      Icons.store_rounded,
    ),
    (
      'Media Streaming Platform',
      'Full-featured media app with live streaming, content management and analytics.',
      ['Android', 'Kotlin', 'Firebase'],
      Icons.play_circle_rounded,
    ),
    (
      'E-Commerce Mobile App',
      'Complete shopping solution with payment gateway and real-time order tracking.',
      ['Android', 'iOS', 'Flutter', 'Firebase'],
      Icons.shopping_bag_rounded,
    ),
    (
      'AR Product Visualization',
      'Augmented reality experience for product visualization using ARCore.',
      ['Android', 'ARCore', 'Java'],
      Icons.view_in_ar_rounded,
    ),
  ];

  Widget _buildProjectsSection(BuildContext context, AppLocalizations l10n) {
    final isMobile = _isMobile;

    Widget mobileCard(int i) {
      final p = _projects[i];
      return ScrollReveal(
        scrollController: _scrollController,
        delay: Duration(milliseconds: i * 80),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GlassCard(
            padding: EdgeInsets.zero,
            glowOnHover: true,
            child: _buildMobileProjectContent(p.$1, p.$2, p.$3, p.$4),
          ),
        ),
      );
    }

    return _buildSection(
      context,
      l10n.projectsTitle,
      isMobile
          ? Column(children: List.generate(_projects.length, mobileCard))
          : ScrollReveal(
              scrollController: _scrollController,
              child: _PhoneShowcase(projects: _projects),
            ),
      key: _projectsKey,
    );
  }

  Widget _buildMobileProjectContent(
    String title,
    String description,
    List<String> tags,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 110,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accentColor.withOpacity(0.3),
                accentSecondary.withOpacity(0.15),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(child: Icon(icon, size: 44, color: accentSecondary)),
        ),
        Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textLight,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: textGray, height: 1.5),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: tags
                    .map(
                      (tag) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.1),
                          border: Border.all(color: accentColor.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 10,
                            color: accentColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context, AppLocalizations l10n) {
    return Container(
      key: _contactKey,
      padding: EdgeInsets.symmetric(
        horizontal: _hPad,
        vertical: kSectionVerticalPadding,
      ),
      child: ScrollReveal(
        scrollController: _scrollController,
        child: Column(
          children: [
            SectionTitle(l10n.contactTitle, centerAlign: true),
            const SizedBox(height: 20),
            Text(
              l10n.contactDescription,
              style: const TextStyle(fontSize: 16, color: textGray),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 12,
              children: [
                HoverScaleButton(
                  onTap: () => launchUrl(
                    Uri.parse('mailto:ahmedessamedeen@gmail.com'),
                  ),
                  child: _buildPrimaryButton('Email Me'),
                ),
                HoverScaleButton(
                  onTap: () => launchUrl(
                    Uri.parse('https://github.com/ahmedessameldeen'),
                  ),
                  child: _buildOutlineButton('GitHub'),
                ),
                HoverScaleButton(
                  onTap: () => launchUrl(
                    Uri.parse('https://linkedin.com/in/ahmedessamedeen'),
                  ),
                  child: _buildOutlineButton('LinkedIn'),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Divider(color: borderColor.withOpacity(0.3)),
            const SizedBox(height: 24),
            Text(
              l10n.footerCopyright,
              style: const TextStyle(color: textGray, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    Widget child, {
    GlobalKey? key,
  }) {
    return Container(
      key: key,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: _hPad,
        vertical: kSectionVerticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollReveal(
            scrollController: _scrollController,
            child: SectionTitle(title),
          ),
          const SizedBox(height: 60),
          child,
        ],
      ),
    );
  }
}

class _PhoneShowcase extends StatefulWidget {
  final List<(String, String, List<String>, IconData)> projects;

  const _PhoneShowcase({required this.projects});

  @override
  State<_PhoneShowcase> createState() => _PhoneShowcaseState();
}

class _PhoneShowcaseState extends State<_PhoneShowcase>
    with SingleTickerProviderStateMixin {
  int _selected = 0;
  bool _switching = false;
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeIn),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _switchTo(int index) async {
    if (_switching || index == _selected) return;
    _switching = true;
    await _ctrl.forward();
    setState(() => _selected = index);
    await _ctrl.reverse();
    _switching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildPhone(),
        const SizedBox(width: 52),
        Expanded(child: _buildSelector()),
      ],
    );
  }

  Widget _buildPhone() {
    final p = widget.projects[_selected];
    return Container(
      width: 264,
      height: 540,
      decoration: BoxDecoration(
        color: const Color(0xFF0C0818),
        borderRadius: BorderRadius.circular(44),
        border: Border.all(color: borderColor, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.35),
            blurRadius: 50,
            spreadRadius: 5,
          ),
          BoxShadow(
            color: accentSecondary.withOpacity(0.1),
            blurRadius: 80,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          // Notch bar
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: borderColor.withOpacity(0.4),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 72,
                  height: 10,
                  decoration: BoxDecoration(
                    color: borderColor.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: borderColor.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          // Screen content
          Expanded(
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (context, child) => Opacity(
                opacity: _fade.value,
                child: Transform.scale(scale: _scale.value, child: child),
              ),
              child: _buildScreen(p),
            ),
          ),
          // Home indicator
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Container(
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                color: borderColor.withOpacity(0.45),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreen((String, String, List<String>, IconData) p) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App icon
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [accentColor, accentSecondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withOpacity(0.45),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(p.$4, color: Colors.white, size: 34),
          ),
          const SizedBox(height: 22),
          Text(
            p.$1,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textLight,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            p.$2,
            style: const TextStyle(fontSize: 12, color: textGray, height: 1.55),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: p.$3
                .map(
                  (tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: accentColor.withOpacity(0.35)),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontSize: 10,
                        color: accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 28),
          // Progress dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.projects.length, (i) {
              final active = i == _selected;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: active ? 22 : 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  gradient: active
                      ? const LinearGradient(colors: [accentColor, accentSecondary])
                      : null,
                  color: active ? null : borderColor.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.projects.length, (i) {
        final p = widget.projects[i];
        final isActive = i == _selected;
        return GestureDetector(
          onTap: () => _switchTo(i),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isActive
                    ? accentColor.withOpacity(0.12)
                    : cardBg.withOpacity(0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isActive
                      ? accentColor.withOpacity(0.55)
                      : borderColor.withOpacity(0.2),
                ),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: accentColor.withOpacity(0.18),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: isActive
                          ? accentColor.withOpacity(0.2)
                          : borderColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      p.$4,
                      color: isActive ? accentSecondary : textGray,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.$1,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                            color: isActive ? textLight : textGray,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          p.$3.take(3).join(' · '),
                          style: TextStyle(
                            fontSize: 11,
                            color: isActive
                                ? accentColor
                                : textGray.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: isActive ? 1.0 : 0.0,
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: accentSecondary,
                      size: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.isActive || _hovered ? accentSecondary : textGray,
                  fontSize: 14,
                  fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 2,
                width: widget.isActive ? 24.0 : 0.0,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [accentColor, accentSecondary],
                  ),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
