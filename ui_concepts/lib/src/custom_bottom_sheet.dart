import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final List<Widget> children;

  const CustomBottomSheet({
    Key? key,
    this.children = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FractionallySizedBox(
            widthFactor: 0.25,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              child: Container(
                height: 5.0,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(2.5),
                  ),
                ),
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            // padding: EdgeInsets.only(bottom: 10),
            itemCount: children.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) => children[index],
          ),
        ],
      ),
    );
  }
}
