import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
 
  List<String> paths = ['1.jpg', '2.png', '3.jpg', '4.jpg'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Expanded(
          child: DraggableGridViewBuilder(
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: [
                const QuiltedGridTile(1, 1),
                const QuiltedGridTile(2, 1),
                const QuiltedGridTile(1, 1),
                const QuiltedGridTile(2, 1),
                const QuiltedGridTile(1, 1),
              ],
            ),
            children: List.generate(
              10,
              (index) => DraggableGridItem(
                isDraggable: true,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.pink,
                    image: DecorationImage(
                      image: AssetImage('assets/${paths[index % 4]}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            isOnlyLongPress: false,
            dragCompletion: (List<DraggableGridItem> list, int beforeIndex,
                int afterIndex) {
              debugPrint('onDragAccept: $beforeIndex -> $afterIndex');
            },
            dragFeedback: (List<DraggableGridItem> list, int index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 20,
                height: index.isEven ? 250 : 120,
                child: list[index].child,
              );
            },
            dragPlaceHolder: (List<DraggableGridItem> list, int index) {
              return PlaceHolderWidget(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
