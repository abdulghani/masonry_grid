import 'package:flutter/material.dart';

class MasonryGrid extends StatefulWidget {
  MasonryGrid(
      {this.column = 1,
      this.children,
      this.mainAxisSpacing = 0,
      this.crossAxisSpacing = 0,
      this.crossAxisAlignment = CrossAxisAlignment.stretch,
      this.staggered = false});

  final int column;
  final List<Widget> children;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final CrossAxisAlignment crossAxisAlignment;
  final bool staggered;

  @override
  _MasonryGrid createState() => _MasonryGrid();
}

class _MasonryGrid extends State<MasonryGrid> {
  int renderId = 0;
  List<List<Widget>> columnItem;
  List<GlobalKey> columnKey;

  @override
  void initState() {
    assert(this.widget.column >= 1, "column should be at least 1.");
    assert(this.widget.mainAxisSpacing >= 0,
        "mainAxisSpacing should be positive.");
    assert(this.widget.crossAxisSpacing >= 0,
        "crossAxisSpacing should be positive.");

    this.columnItem = List.generate(this.widget.column, (i) => []);
    this.columnKey = List.generate(this.widget.column, (i) => GlobalKey());
    super.initState();
  }

  int getSmallestColumnId() {
    int smallestColumnId = 0;
    try {
      final List<RenderBox> renderColumn = List.generate(this.columnKey.length,
          (i) => this.columnKey[i].currentContext?.findRenderObject());
      final List<double> columnHeight = List.generate(
          renderColumn.length, (i) => renderColumn[i].size.height);

      columnHeight.asMap().forEach((i, item) {
        if (columnHeight[i] < columnHeight[smallestColumnId])
          smallestColumnId = i;
      });
    } catch (err) {}
    return smallestColumnId;
  }

  void renderItem() {
    int columnId = getSmallestColumnId();
    this.columnItem[columnId].add(Padding(
          padding: EdgeInsets.only(bottom: this.widget.mainAxisSpacing),
          child: this.widget.children[this.renderId],
        ));

    setState(() {
      this.renderId = this.renderId + 1;
    });
  }

  void renderItemNormally() {
    for (int i = this.renderId; i < this.widget.children.length; i++) {
      this.columnItem[i % this.widget.column].add(Padding(
            padding: EdgeInsets.only(bottom: this.widget.mainAxisSpacing),
            child: this.widget.children[i],
          ));
    }
    setState(() {
      this.renderId = this.widget.children.length;
    });
  }

  void renderChildren() {
    if (!this.widget.staggered && this.renderId < this.widget.children.length) {
      this.renderItemNormally();
    } else if (this.widget.staggered &&
        this.renderId < this.widget.children.length) {
      Future.microtask(() => this.renderItem());
    }
  }

  @override
  Widget build(BuildContext context) {
    renderChildren();

    final List<Widget> column = this.widget.crossAxisSpacing == 0
        ? List.generate(
            this.widget.column,
            (i) => Expanded(
                  child: Column(
                    key: this.columnKey[i],
                    children: columnItem[i],
                    crossAxisAlignment: this.widget.crossAxisAlignment,
                  ),
                ))
        : List.generate(
            this.widget.column + (this.widget.column - 1),
            (i) => i.isEven
                ? Expanded(
                    child: Column(
                      key: this.columnKey[(i / 2).floor()],
                      children: columnItem[(i / 2).floor()],
                      crossAxisAlignment: this.widget.crossAxisAlignment,
                    ),
                  )
                : SizedBox(
                    width: this.widget.crossAxisSpacing,
                  ));

    return Row(
      children: column,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
