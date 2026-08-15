import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ExpensePageInput extends StatefulWidget {
  final Function(int) onAmountChanged;
  const ExpensePageInput({super.key, required this.onAmountChanged});
  @override
  State<ExpensePageInput> createState() => _ExpensePageInputState();
}

class _ExpensePageInputState extends State<ExpensePageInput> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void onSend(List<dynamic> args) {
    // Handle sending expense data
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.1,
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 233, 233, 233),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            Icon(Icons.currency_rupee, size: 40, color: Colors.green),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  widget.onAmountChanged((double.tryParse(value) ?? 0).toInt());
                },
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  hintText: 'Enter amount',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseOptions extends StatefulWidget {
  final Function(String) onCategoryChanged;
  const ExpenseOptions({super.key, required this.onCategoryChanged});

  @override
  State<ExpenseOptions> createState() => _ExpenseOptionsState();
}

class _ExpenseOptionsState extends State<ExpenseOptions> {
  int selectedIndex = -1;
  String selectedOption = '';

  final List<Map<String, dynamic>> options = [
    {"icon": Icons.food_bank, "title": "Food"},
    {"icon": Icons.shopping_cart, "title": "Shopping"},
    {"icon": Icons.emoji_transportation, "title": "Travel"},
    {"icon": Icons.movie, "title": "Entmt"},
    {"icon": Icons.other_houses, "title": "Other"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(options.length, (index) {
          bool selected = selectedIndex == index;

          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
                selectedOption = options[index]["title"];
              });
              widget.onCategoryChanged(selectedOption);
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: selected ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    options[index]["icon"],
                    size: 40,
                    color: selected ? Colors.white : Colors.blue,
                  ),
                  Text(
                    options[index]["title"],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ExpensePageDatePicker extends StatefulWidget {
  final Function(DateTime) onDateChanged;
  const ExpensePageDatePicker({super.key, required this.onDateChanged});

  @override
  State<ExpensePageDatePicker> createState() => _ExpensePageDatePickerState();
}

class _ExpensePageDatePickerState extends State<ExpensePageDatePicker> {
  DateTime selectedDate = DateTime.now();

  String get buttonText => selectedDate.toString().split(' ')[0];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      DateTime today = DateTime.now();

      if (picked.isAfter(DateTime(today.year, today.month, today.day))) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Future dates are not allowed")),
        );
        return;
      }

      setState(() {
        selectedDate = picked;
      });
      widget.onDateChanged(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _selectDate(context),
      icon: const Icon(Icons.calendar_month_outlined),
      label: Text(
        buttonText,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ExpensePageNote extends StatefulWidget {
  final Function(String) onNoteChanged;
  const ExpensePageNote({super.key, required this.onNoteChanged});
  @override
  State<ExpensePageNote> createState() => _ExpensePageNoteState();
}

class _ExpensePageNoteState extends State<ExpensePageNote> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: _noteController,
        onChanged: (value) {
          widget.onNoteChanged(value);
        },
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Add a note...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

class ExpensePageSaveButton extends StatelessWidget {
  final int amount;
  final String category;
  final String note;
  final DateTime date;

  const ExpensePageSaveButton({
    super.key,
    required this.amount,
    required this.category,
    required this.note,
    required this.date,
  });

  Future<void> _saveExpense(BuildContext context) async {
    if (amount == 0 || category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields!')),
      );
      return;
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Get existing expenses list
      List<String>? expenses = prefs.getStringList('expenses') ?? [];

      // Create a new expense entry as JSON
      final expenseData = {
        'amount': amount,
        'category': category,
        'note': note,
        'date': date.toIso8601String(),
      };

      // Add to list and save
      expenses.add(jsonEncode(expenseData));
      await prefs.setStringList('expenses', expenses);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Expense saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saving expense: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 165, 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () => _saveExpense(context),
      child: const Text(
        'Save Expense',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
