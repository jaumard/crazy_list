library infinite_widgets;

import 'package:flutter/material.dart';

part 'src/diagonal.dart';
part 'src/grid.dart';
part 'src/list.dart';
part 'src/single.dart';
part 'src/square.dart';
part 'src/triangle.dart';

typedef WidgetBuilder = Widget Function(BuildContext context, int index, CrazyListLayout mode);
typedef OnTap = Function(int);

enum CrazyListLayout { single, diagonal, triangle, square, list, grid }

enum CrazyListMode { list, grid }

class CrazyList extends StatelessWidget {
  final WidgetBuilder builder;
  final int itemCount;
  final OnTap onTap;
  final Curve curve;
  final Color color1;
  final Color color2;
  final CrazyListMode mode;

  const CrazyList({
    Key key,
    this.builder,
    this.itemCount,
    this.onTap,
    this.mode = CrazyListMode.list,
    this.curve = Curves.fastLinearToSlowEaseIn,
    this.color1,
    this.color2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (itemCount == 1) {
      return SingleWidget(builder: builder);
    } else if (itemCount == 2) {
      return DiagonalWidget(
        builder: builder,
        curve: curve,
        color1: color1,
        color2: color2,
        onTap: onTap,
      );
    } else if (itemCount == 3) {
      return TriangleWidget(
        builder: builder,
        curve: curve,
        color1: color1,
        color2: color2,
        onTap: onTap,
      );
    } else if (itemCount == 4) {
      return SquareWidget(
        builder: builder,
        curve: curve,
        color1: color1,
        color2: color2,
        onTap: onTap,
      );
    }

    if (mode == CrazyListMode.grid) {
      return GridWidget(
        color2: color2,
        color1: color1,
        onTap: onTap,
        builder: builder,
        itemCount: itemCount,
      );
    }
    return ListWidget(
      color2: color2,
      color1: color1,
      onTap: onTap,
      builder: builder,
      itemCount: itemCount,
    );
  }
}

enum _Position { TOP_LEFT, TOP_RIGHT, OUTER_TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT, OUTER_BOTTOM_RIGHT }

class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _DiagonalClipper extends CustomClipper<Path> {
  final double clipHeight;
  final _Position position;

  _DiagonalClipper(this.clipHeight, this.position);

  @override
  Path getClip(Size size) {
    switch (position) {
      case _Position.TOP_LEFT:
        return _getTopLeftPath(size);
      case _Position.OUTER_TOP_RIGHT:
        return _getOuterTopRightPath(size);
      case _Position.TOP_RIGHT:
        return _getTopRightPath(size);
      case _Position.BOTTOM_LEFT:
        return _getBottomLeftPath(size);
      case _Position.BOTTOM_RIGHT:
        return _getBottomRightPath(size);
      case _Position.OUTER_BOTTOM_RIGHT:
        return _getOuterBottomRightPath(size);
      default:
        return _getBottomLeftPath(size);
    }
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

  _getTopLeftPath(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, clipHeight);
    path.close();
    return path;
  }

  _getTopRightPath(Size size) {
    var path = Path();
    path.moveTo(0.0, clipHeight);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  _getOuterTopRightPath(Size size) {
    var path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, clipHeight);
    path.close();
    return path;
  }

  _getOuterBottomRightPath(Size size) {
    var path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, clipHeight);
    path.close();
    return path;
  }

  _getBottomLeftPath(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height - clipHeight);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  _getBottomRightPath(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - clipHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }
}

class MaterialInkWell extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const MaterialInkWell({Key key, this.onTap, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: child,
        onTap: onTap,
      ),
      color: Colors.transparent,
    );
  }
}
