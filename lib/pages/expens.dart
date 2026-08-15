import 'package:flutter/material.dart';
import '../components/ExpensePageComponents.dart';

class ExpensPage extends StatefulWidget {
  const ExpensPage({super.key});

  @override                                          // ✅ added
  State<ExpensPage> createState() => _ExpensPageState();
}

class _ExpensPageState extends State<ExpensPage> {

  int      amount   = 0;                            // ✅ typo fixed
  String   category = '';
  String   note     = '';
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpensePageInput(
              onAmountChanged: (val) => setState(() => amount = val),   // ✅ typed
            ),
            const SizedBox(height: 20),
            ExpenseOptions(
              onCategoryChanged: (val) => setState(() => category = val), // ✅ typed
            ),
            const SizedBox(height: 20),
            ExpensePageDatePicker(
              onDateChanged: (val) => setState(() => dateTime = val),   // ✅ typed
            ),
            const SizedBox(height: 20),
            ExpensePageNote(
              onNoteChanged: (val) => setState(() => note = val),       // ✅ typed
            ),
            const SizedBox(height: 20),

           

            ExpensePageSaveButton(
              amount:   amount,
              category: category,
              note:     note,
              date:     dateTime,
            ),
          ],
        ),
      ),
    );
  }
}