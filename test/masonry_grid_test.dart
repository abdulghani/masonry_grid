import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:masonry_grid/masonry_grid.dart';

void main() {
  testWidgets(
    'test MasonryGrid layout',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: MasonryGrid(
                    column: 2,
                    children: List.generate(
                      10,
                      (index) => SizedBox(
                        width: 100,
                        height: 100,
                        child: Text(index.isEven ? 'hello' : 'goodbye'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('hello'), findsNWidgets(5));
      expect(find.text('goodbye'), findsNWidgets(5));
    },
  );
}
