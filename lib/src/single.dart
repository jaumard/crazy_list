part of '../crazy_list.dart';

class SingleWidget extends StatelessWidget {
  final WidgetBuilder builder;
  final OnTap onTap;

  const SingleWidget({Key key, this.builder, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(child: builder(context, 0, CrazyListLayout.single)),
      ),
    );
  }
}