import 'package:flutter/material.dart';
import 'package:portfolio/src/constants.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final List<Color> colors;
  final TextAlign? textAlign;

  const GradientText(
    this.text, {
    required this.style,
    this.colors = const [accentColor, accentSecondary],
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
        textAlign: textAlign,
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final bool centerAlign;

  const SectionTitle(this.title, {this.centerAlign = false, super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width < kBreakpointMobile ? 34.0 : 44.0;
    return Column(
      crossAxisAlignment: centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GradientText(
          title,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, height: 1.1),
          textAlign: centerAlign ? TextAlign.center : null,
        ),
        const SizedBox(height: 12),
        Container(
          height: 3,
          width: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [accentColor, accentSecondary]),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool glowOnHover;
  final Color? glowColor;

  const GlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.glowOnHover = false,
    this.glowColor,
    super.key,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final glow = widget.glowColor ?? accentColor;
    return MouseRegion(
      onEnter: widget.glowOnHover ? (_) => setState(() => _hovered = true) : null,
      onExit: widget.glowOnHover ? (_) => setState(() => _hovered = false) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        clipBehavior: Clip.antiAlias,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? glow.withOpacity(0.6) : borderColor.withOpacity(0.4),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: glow.withOpacity(_hovered ? 0.25 : 0.08),
              blurRadius: _hovered ? 30 : 12,
              spreadRadius: _hovered ? 2 : 0,
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}

class SkillChip extends StatefulWidget {
  final String label;

  const SkillChip(this.label, {super.key});

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: _hovered ? accentColor.withOpacity(0.25) : accentColor.withOpacity(0.1),
          border: Border.all(
            color: _hovered ? accentSecondary.withOpacity(0.8) : accentColor.withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: 13,
            color: _hovered ? accentSecondary : textGrayLight,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
