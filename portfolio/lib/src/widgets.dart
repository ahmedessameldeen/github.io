import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/src/constants.dart';

class TechStackShowcase extends StatelessWidget {
  const TechStackShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 900;

    return Column(
      children: [
        Text(
          'Mobile Development Stack',
          style: TextStyle(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.bold,
            color: textLight,
          ),
        ),
        const SizedBox(height: 32),
        isMobile
            ? Column(
                children: [
                  _buildStackItem(
                    'Android',
                    'Expert',
                    ['Java', 'Kotlin', 'Firebase'],
                    isMobile: isMobile,
                  ),
                  const SizedBox(height: 18),
                  _buildStackItem(
                    'iOS',
                    'Advanced',
                    ['Swift', 'UIKit', 'Combine'],
                    isMobile: isMobile,
                  ),
                  const SizedBox(height: 18),
                  _buildStackItem(
                    'Cross-Platform',
                    'Expert',
                    ['Flutter', 'Firebase'],
                    isMobile: isMobile,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStackItem('Android', 'Expert', ['Java', 'Kotlin', 'Firebase']),
                  _buildStackItem('iOS', 'Advanced', ['Swift', 'UIKit', 'Combine']),
                  _buildStackItem('Cross-Platform', 'Expert', ['Flutter', 'Firebase']),
                ],
              ),
      ],
    );
  }

  Widget _buildStackItem(String platform, String level, List<String> tools, {bool isMobile = false}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 12),
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accentColor.withOpacity(0.1),
              accentSecondary.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: borderColor.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              platform,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textLight,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                level,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: accentSecondary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: tools
                  .map(
                    (tool) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: accentSecondary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            tool,
                            style: const TextStyle(
                              fontSize: 13,
                              color: textGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceMockup extends StatelessWidget {
  final String device;
  final IconData icon;

  const DeviceMockup({
    required this.device,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accentColor.withOpacity(0.15),
            accentSecondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: borderColor.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: accentColor,
          ),
          const SizedBox(height: 16),
          Text(
            device,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textLight,
            ),
          ),
        ],
      ),
    );
  }
}

class AppStoreButton extends StatefulWidget {
  final String platform;
  final String url;

  const AppStoreButton({
    required this.platform,
    required this.url,
    super.key,
  });

  @override
  State<AppStoreButton> createState() => _AppStoreButtonState();
}

class _AppStoreButtonState extends State<AppStoreButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.08).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: GestureDetector(
          onTap: () async {
            if (await canLaunchUrl(Uri.parse(widget.url))) {
              await launchUrl(Uri.parse(widget.url));
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: accentColor),
              borderRadius: BorderRadius.circular(12),
              color: accentColor.withOpacity(0.1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.platform == 'App Store'
                      ? Icons.apple
                      : Icons.android,
                  color: accentColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.platform,
                  style: const TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
