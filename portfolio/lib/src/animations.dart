import 'package:flutter/material.dart';

class FadeInUp extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double offset;
  final Curve curve;

  const FadeInUp({
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.delay = Duration.zero,
    this.offset = 30.0,
    this.curve = Curves.easeOut,
    super.key,
  });

  @override
  State<FadeInUp> createState() => _FadeInUpState();
}

class _FadeInUpState extends State<FadeInUp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _slideAnimation = Tween<double>(begin: widget.offset, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Opacity(
        opacity: _fadeAnimation.value,
        child: Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final Duration duration;
  final Duration delay;
  final double offset;
  final Curve curve;

  const ScrollReveal({
    required this.child,
    required this.scrollController,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.offset = 40.0,
    this.curve = Curves.easeOut,
    super.key,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> with SingleTickerProviderStateMixin {
  final GlobalKey _key = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _slideAnimation = Tween<double>(begin: widget.offset, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
      widget.scrollController.addListener(_checkVisibility);
    });
  }

  void _checkVisibility() {
    if (_isVisible) return;
    final ctx = _key.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final position = box.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(ctx).size.height;
    if (position.dy < screenHeight * 0.92) {
      _isVisible = true;
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _key,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: child,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

class HoverScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double scale;

  const HoverScaleButton({
    required this.child,
    required this.onTap,
    this.scale = 1.05,
    super.key,
  });

  @override
  State<HoverScaleButton> createState() => _HoverScaleButtonState();
}

class _HoverScaleButtonState extends State<HoverScaleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
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
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: GestureDetector(
        onTap: widget.onTap,
        child: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: widget.scale).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
