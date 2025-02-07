import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/models/medicine.dart';
import '../../core/services/firestore_service.dart';
import '../../core/utils/constants.dart';
import 'compartment_picker.dart';

class AddMedicineScreen extends StatefulWidget {
  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;
  int _compartment = 1;
  String _type = AppConstants.medicineTypes[0];
  String _frequency = AppConstants.frequencyOptions[0];
  String _time = AppConstants.timeSlots[0];
  String _status = 'Pending';

  // New UI fields per provided design:
  Color _selectedColor = Colors.pink;
  final List<Color> _colorOptions = [Colors.pink,Colors.purple,Colors.red, Colors.green, Colors.orange, Colors.blue,];
  int _quantity = 1;
  List<bool> _mealTimings = [true, false, false];

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Add Medicines',style: TextStyle(fontWeight: FontWeight.bold),)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Medicine Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Medicine Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 20),
              // Compartment Picker
              Text('Compartment', style: TextStyle(fontWeight: FontWeight.bold)),
              CompartmentPicker(
                selectedCompartment: _compartment,
                onChanged: (value) => setState(() => _compartment = value),
              ),
              SizedBox(height: 20),
              // Type Dropdown using AppConstants.medicineTypes
              DropdownButtonFormField<String>(
                value: _type,
                items: AppConstants.medicineTypes
                    .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _type = value!),
                decoration: InputDecoration(labelText: 'Type'),
              ),
              SizedBox(height: 20),
              // Color Selection
              Text('Choose Color', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _colorOptions.map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = color;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: color,
                      radius: _selectedColor == color ? 20 : 15,
                      child: _selectedColor == color
                          ? Icon(Icons.check, color: Colors.white, size: 16)
                          : null,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              // Date Pickers
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Start Date: ${DateFormat('dd/MM/yyyy').format(_startDate)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, true),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(_endDate == null
                    ? 'Select End Date (Optional)'
                    : 'End Date: ${DateFormat('dd/MM/yyyy').format(_endDate!)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, false),
              ),
              SizedBox(height: 20),
              // Frequency Dropdown using AppConstants.frequencyOptions
              DropdownButtonFormField<String>(
                value: _frequency,
                items: AppConstants.frequencyOptions
                    .map((freq) => DropdownMenuItem(
                  value: freq,
                  child: Text(freq),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _frequency = value!),
                decoration: InputDecoration(labelText: 'Frequency'),
              ),
              SizedBox(height: 20),
              // Time Dropdown using AppConstants.timeSlots
              DropdownButtonFormField<String>(
                value: _time,
                items: AppConstants.timeSlots
                    .map((time) => DropdownMenuItem(
                  value: time,
                  child: Text(time),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _time = value!),
                decoration: InputDecoration(labelText: 'Time'),
              ),
              SizedBox(height: 20),
              // Quantity Selector
              Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() => _quantity--);
                      }
                    },
                  ),
                  Text('$_quantity', style: TextStyle(fontSize: 18)),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => setState(() => _quantity++),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Meal Timing Toggle
              Text('Meal Timing', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                isSelected: _mealTimings,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('Before Food'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('After Food'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('Before Sleep'),
                  ),
                ],
                onPressed: (index) {
                  setState(() {
                    for (int i = 0; i < _mealTimings.length; i++) {
                      _mealTimings[i] = i == index;
                    }
                  });
                },
              ),
              SizedBox(height: 30),
              // Add Medicine Button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final medicine = Medicine(
                        id: '', // Firestore will auto-generate an ID
                        name: _nameController.text,
                        type: _type,
                        compartment: _compartment,
                        startDate: _startDate,
                        endDate: _endDate,
                        frequency: _frequency,
                        time: _time,
                        status: _status,
                      );
                      await Provider.of<FirestoreService>(context, listen: false)
                          .addMedicine(medicine);
                      Navigator.pop(context);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Text('Add Medicine'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
