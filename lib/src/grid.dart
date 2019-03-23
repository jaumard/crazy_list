part of '../crazy_list.dart';

class GridWidget extends StatelessWidget {
  final WidgetBuilder builder;
  final int itemCount;
  final OnTap onTap;
  final Color color1;
  final Color color2;

  const GridWidget({
    Key key,
    this.builder,
    this.itemCount,
    this.onTap,
    this.color1,
    this.color2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(itemCount, (index) {
        final line = ((index + 1) / 2).ceil();
        Color color;
        if (line % 2 == 0) {
          color = index % 2 == 0 ? color1 : color2;
        } else {
          color = index % 2 == 0 ? color2 : color1;
        }
        return Material(
          color: color,
          child: InkWell(
            onTap: onTap == null ? null : () => onTap(index),
            child: builder(
              context,
              index,
              CrazyListLayout.grid,
            ),
          ),
        );
      }),
    );
  }
}
