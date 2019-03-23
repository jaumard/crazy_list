part of '../crazy_list.dart';

class TriangleWidget extends StatefulWidget {
  final WidgetBuilder builder;
  final OnTap onTap;
  final Curve curve;
  final Color color1;
  final Color color2;

  const TriangleWidget({Key key, this.builder, this.onTap, this.curve, this.color1, this.color2}) : super(key: key);

  @override
  _TriangleWidgetState createState() => _TriangleWidgetState();
}

class _TriangleWidgetState extends State<TriangleWidget> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _animationController.duration = Duration(milliseconds: 800);
    _animation = CurvedAnimation(parent: _animationController, curve: widget.curve);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final maxHeight = constraint.maxHeight;

        return Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => FractionalTranslation(
                    translation: Offset(1 - _animation.value, 0),
                    child: child,
                  ),
              child: ClipPath(
                clipper: _DiagonalClipper(maxHeight / 2, _Position.OUTER_TOP_RIGHT),
                child: Container(
                  color: widget.color2,
                  width: double.infinity,
                  height: double.infinity,
                  child: MaterialInkWell(
                    onTap: () => widget.onTap(0),
                    child: Align(alignment: Alignment.topRight, child: widget.builder(context, 0, CrazyListLayout.triangle)),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => FractionalTranslation(
                    translation: Offset(-1 + _animation.value, 0),
                    child: child,
                  ),
              child: ClipPath(
                clipper: _TriangleClipper(),
                child: Container(
                  color: widget.color1,
                  width: double.infinity,
                  height: double.infinity,
                  child: MaterialInkWell(
                    onTap: () => widget.onTap(1),
                    child: Center(child: widget.builder(context, 1, CrazyListLayout.triangle)),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => FractionalTranslation(
                    translation: Offset(1 - _animation.value, 0),
                    child: child,
                  ),
              child: ClipPath(
                clipper: _DiagonalClipper(maxHeight / 2, _Position.OUTER_BOTTOM_RIGHT),
                child: Container(
                  color: widget.color2,
                  width: double.infinity,
                  height: double.infinity,
                  child: MaterialInkWell(
                    onTap: () => widget.onTap(2),
                    child: Align(alignment: Alignment.bottomRight, child: widget.builder(context, 2, CrazyListLayout.triangle)),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
