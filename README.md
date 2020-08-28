# masonry_grid
Flutter Masonry Grid layout to create masonry, staggered items layout.

## Support
Support this project on [patreon](https://www.patreon.com/abdulghani)
![patreon](https://belikabel-assets.s3.ap-southeast-1.amazonaws.com/4157795e-e18e-479e-8237-e50c771b3a63.jpeg)

## Getting Started
Install the package, add the dependencies to your `pubspec.yaml`
```yaml
dependencies:
  // ... the rest of your dependencies
  masonry_grid: [version]
```

## Usage
Import and use the widget to create your grid
```dart
import 'package:masonry_grid/masonry_grid.dart';

class YourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: MasonryGrid(
                column: 2,
                children: List.generate(10, (i) =>
                      SizedBox(width: 100, height: 100, child: Text("hello")),
                )))
      ],
    ));
  }
}
```

## Properties
```dart
int column  // number of column rendered
List<Widget> children // children widgets that's going to be rendered.                                        
double mainAxisSpacing  // amount of vertical spacing between items
double crossAxisSpacing // amount of horizontal spacing between columns
bool staggered  //  stagger layout to override children order to paint items on the lowest column first
CrossAxisAlignment crossAxisAlignment // cross axis alignment inside of each column
```
