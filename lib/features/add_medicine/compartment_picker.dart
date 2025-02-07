import 'package:flutter/material.dart';

class CompartmentPicker extends StatelessWidget {
  final int selectedCompartment;
  final ValueChanged<int> onChanged;

  const CompartmentPicker({
    required this.selectedCompartment,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 6,
      children: List.generate(6, (index) {
        return GestureDetector(
          onTap: () => onChanged(index + 1),
          child: Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: selectedCompartment == index + 1
                  ? Colors.blue.withOpacity(0.3)
                  : Colors.grey[200],
              border: Border.all(
                color: selectedCompartment == index + 1
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 18,
                  color: selectedCompartment == index + 1
                      ? Colors.blue
                      : Colors.black,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}