import 'package:flutter/material.dart';

/// Shows an animated viewfinder frame.
///
/// Implementation inspired by Flutter Spinkit's
/// [loading indicators](https://github.com/jogboms/flutter_spinkit/tree/master/lib/src).
class ViewfinderAnimation extends StatefulWidget {
  const ViewfinderAnimation({
    Key? key,
    required this.size,
    this.duration = const Duration(milliseconds: 1200),
    this.color = Colors.white,
  }) : super(key: key);

  final Size size;
  final Duration duration;
  final Color color;

  @override
  _ViewfinderAnimationState createState() => _ViewfinderAnimationState();
}

class _ViewfinderAnimationState extends State<ViewfinderAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() => setState(() {}))
      ..repeat(reverse: true);

    _animation = Tween(begin: 1.18, end: 1.25)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _animation.value,
      child: CustomPaint(
        size: widget.size,
        painter: ViewfinderPainter(color: widget.color),
      ),
    );
  }
}

/// Custom shape for a viewfinder frame, essentially the 4 corners of a square.
class ViewfinderPainter extends CustomPainter {
  ViewfinderPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final paint = Paint()
      ..color = color.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // top left
    final path_0 = Path()
      ..moveTo(w * 1 / 7, h * 2 / 7)
      ..lineTo(w * 1 / 7, h * 1 / 7)
      ..lineTo(w * 2 / 7, h * 1 / 7);

    // top right
    final path_1 = Path()
      ..moveTo(w * 5 / 7, h * 1 / 7)
      ..lineTo(w * 6 / 7, h * 1 / 7)
      ..lineTo(w * 6 / 7, h * 2 / 7);

    // bottom right
    final path_2 = Path()
      ..moveTo(w * 6 / 7, h * 5 / 7)
      ..lineTo(w * 6 / 7, h * 6 / 7)
      ..lineTo(w * 5 / 7, h * 6 / 7);

    // bottom left
    final path_3 = Path()
      ..moveTo(w * 2 / 7, h * 6 / 7)
      ..lineTo(w * 1 / 7, h * 6 / 7)
      ..lineTo(w * 1 / 7, h * 5 / 7);

    for (final path in [path_0, path_1, path_2, path_3]) {
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
