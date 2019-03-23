part of '../crazy_list.dart';

class SquareWidget extends StatefulWidget {
  final WidgetBuilder builder;
  final OnTap onTap;
  final Curve curve;
  final Color color1;
  final Color color2;

  const SquareWidget({Key key, this.builder, this.onTap, this.curve, this.color1, this.color2}) : super(key: key);

  @override
  _SquareWidgetState createState() => _SquareWidgetState();
}

class _SquareWidgetState extends State<SquareWidget> with SingleTickerProviderStateMixin {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) => FractionalTranslation(
                        translation: Offset(-1 + _animation.value, -1 + _animation.value),
                        child: child,
                      ),
                  child: Container(
                    color: widget.color1,
                    width: double.infinity,
                    height: double.infinity,
                    child: MaterialInkWell(
                      onTap: () => widget.onTap(0),
                      child: Center(child: widget.builder(context, 0, CrazyListLayout.square)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) => FractionalTranslation(
                        translation: Offset(1 - _animation.value, -1 + _animation.value),
                        child: child,
                      ),
                  child: Container(
                    color: widget.color2,
                    width: double.infinity,
                    height: double.infinity,
                    child: MaterialInkWell(
                      onTap: () => widget.onTap(1),
                      child: Center(child: widget.builder(context, 1, CrazyListLayout.square)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) => FractionalTranslation(
                        translation: Offset(-1 + _animation.value, 1 - _animation.value),
                        child: child,
                      ),
                  child: Container(
                    color: widget.color2,
                    width: double.infinity,
                    height: double.infinity,
                    child: MaterialInkWell(
                      onTap: () => widget.onTap(2),
                      child: Center(child: widget.builder(context, 2, CrazyListLayout.square)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) => FractionalTranslation(
                        translation: Offset(1 - _animation.value, 1 - _animation.value),
                        child: child,
                      ),
                  child: Container(
                    color: widget.color1,
                    width: double.infinity,
                    height: double.infinity,
                    child: MaterialInkWell(
                      onTap: () => widget.onTap(3),
                      child: Center(child: widget.builder(context, 3, CrazyListLayout.square)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
