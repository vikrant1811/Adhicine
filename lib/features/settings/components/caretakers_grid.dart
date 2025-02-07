import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CaretakersList extends StatelessWidget {
  final List<String> caretakers = ['Diba Luna', 'Rox Sod.', 'Sunny Tu...'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: caretakers.length + 1,
            itemBuilder: (context, index) {
              if (index == caretakers.length) {
                return _buildAddButton();
              }
              return _buildSlidableCaretakerTile(caretakers[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSlidableCaretakerTile(String name) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Slidable(
        key: ValueKey(name),
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(child: Text(name[0])),
                SizedBox(height: 8),
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () {}, // Implement add caretaker
          child: Container(
            width: 80,
            height: 80,
            child: Center(
              child: Icon(Icons.add, size: 40, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
