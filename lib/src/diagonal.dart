part of '../crazy_list.dart';

class DiagonalWidget extends StatefulWidget {
  final WidgetBuilder builder;
  final OnTap onTap;
  final Curve curve;
  final Color color1;
  final Color color2;

  const DiagonalWidget({Key key, this.builder, this.onTap, this.curve, this.color1, this.color2}) : super(key: key);

  @override
  _DiagonalWidgetState createState() => _DiagonalWidgetState();
}

class _DiagonalWidgetState extends State<DiagonalWidget> with SingleTickerProviderStateMixin {
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
                    translation: Offset((-1 + _animation.value) / 2, (-1 + _animation.value) / 2),
                    child: child,
                  ),
              child: ClipPath(
                clipper: _DiagonalClipper(maxHeight, _Position.BOTTOM_LEFT),
                child: Container(
                  color: widget.color1,
                  width: double.infinity,
                  height: double.infinity,
                  child: MaterialInkWell(
                    onTap: () => widget.onTap(0),
                    child: Align(alignment: Alignment.topLeft, child: widget.builder(context, 0, CrazyListLayout.diagonal)),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => FractionalTranslation(
                    translation: Offset((1 - _animation.value) / 2, (1 - _animation.value) / 2),
                    child: child,
                  ),
              child: ClipPath(
                clipper: _DiagonalClipper(maxHeight, _Position.TOP_RIGHT),
                child: Container(
                  color: widget.color2,
                  width: double.infinity,
                  height: double.infinity,
                  child: MaterialInkWell(
                    onTap: () => widget.onTap(1),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: widget.builder(context, 1, CrazyListLayout.diagonal),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
