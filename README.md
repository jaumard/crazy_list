# crazy_list

Crazy list is a widget that change his layout depending of the item count on the list, can be square, triangle, diagonal, grid, list

## Usage

```dart
CrazyList(
  itemCount: itemCount,
  mode: CrazyListMode.grid,
  color1: Colors.green[50],
  color2: Colors.green[300],
  onTap: (index) => print('$index tapped'),
  builder: (context, index, mode) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('My Label $index'),
    );
  },
),
```

By default depending of `itemCount` you'll get:
 
- Diagonal layout for item count 2
- Triangle layout for item count 3
- Square layout for item count 4
- List or Grid layout for item count more than 4

You can customize this widget with the following params: 

`mode` list or grid for item > 4

`color1` color 1 

`color2` color 2

`onTap` callback when an item is tapped
 
`builder` to build the item 

`itemCount` number of items

`curve` used for the enter animation

 