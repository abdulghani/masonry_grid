import 'package:flutter/material.dart';

class MasonryGrid extends StatelessWidget {
  MasonryGrid(
      {this.column = 1,
      this.children,
      this.mainAxisSpacing = 0,
      this.crossAxisSpacing = 0,
      this.crossAxisAlignment = CrossAxisAlignment.stretch});

  final int column;
  final List<Widget> children;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> columnItem = List.generate(this.column, (i) => []);

    this.children.asMap().forEach((i, item) {
      columnItem[i % this.column].add(Padding(
        padding: EdgeInsets.only(bottom: this.mainAxisSpacing),
        child: item,
      ));
    });

    final List<Widget> columnWithSpacer = List.generate(
        this.column + (this.column - 1),
        (i) => i.isEven
            ? Expanded(
                child: Column(
                  children: columnItem[(i / 2).floor()],
                  crossAxisAlignment: this.crossAxisAlignment,
                ),
              )
            : SizedBox(
                width: this.crossAxisSpacing,
              ));

    return Row(
      children: columnWithSpacer,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
