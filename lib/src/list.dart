part of '../crazy_list.dart';

class ListWidget extends StatefulWidget {
  final WidgetBuilder builder;
  final int itemCount;
  final OnTap onTap;
  final Color color1;
  final Color color2;

  const ListWidget({Key key, this.builder, this.itemCount, this.onTap, this.color1, this.color2}) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  var _itemCount = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _animItems();
    });
  }

  @override
  void didUpdateWidget(ListWidget oldWidget) {
    if (oldWidget.itemCount != widget.itemCount) {
      _itemCount = widget.itemCount;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _key,
      itemBuilder: (context, index, animation) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, .0),
              end: Offset.zero,
            )
                .chain(CurveTween(
                  curve: Curves.fastOutSlowIn,
                ))
                .animate(animation),
            child: Card(
              color: index % 2 == 0 ? widget.color1 : widget.color2,
              child: InkWell(
                  onTap: widget.onTap == null ? null : () => widget.onTap(index), child: Center(child: widget.builder(context, index, CrazyListLayout.list))),
            ),
          ),
      initialItemCount: _itemCount,
    );
  }

  void _animItems() async {
    for (var i = 0; i < widget.itemCount; i++) {
      if (i > 0) {
        await Future.delayed(Duration(milliseconds: 100));
      }
      _key.currentState.insertItem(_itemCount);
      _itemCount++;
    }
  }
}
