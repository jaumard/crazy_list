part of '../crazy_list.dart';

class ListWidget extends StatelessWidget {
  final WidgetBuilder builder;
  final int itemCount;
  final OnTap onTap;
  final Color color1;
  final Color color2;

  const ListWidget({Key key, this.builder, this.itemCount, this.onTap, this.color1, this.color2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) =>
            Card(
              color: index % 2 == 0 ? color1 : color2,
              child: InkWell(onTap: onTap == null ? null : () => onTap(index), child: Center(child: builder(context, index, CrazyListLayout.list))),
            ),
        itemCount: itemCount);
  }
}
