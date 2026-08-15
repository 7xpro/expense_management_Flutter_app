import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsightPage extends StatefulWidget {

  const InsightPage({super.key});

  @override
  State<InsightPage> createState() =>
      _InsightPageState();

}

class _InsightPageState
    extends State<InsightPage> {

  final TextEditingController
      incomeController =
      TextEditingController();

  Future<void> saveIncome()
  async {

    final prefs =
        await SharedPreferences
            .getInstance();

    double income =
        double.tryParse(
            incomeController.text)
        ?? 0.0;


    final double preIncome =
        prefs.getDouble(
            'otherIncome') ?? 0.0;


    await prefs.setDouble(
      'otherIncome',
      income + preIncome,
    );

    ScaffoldMessenger.of(
        context)
        .showSnackBar(

      const SnackBar(
        content:
        Text("Income Saved"),
      ),

    );

    incomeController.clear();

  }

  @override
  void dispose() {

    incomeController.dispose();

    super.dispose();

  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title:
        const Text('Income'),

      ),

      body: Center(

        child: Padding(

          padding:
          const EdgeInsets.all(
              10),

          child: Column(

            mainAxisSize:
            MainAxisSize.min,

            children: [

              TextField(

                controller:
                incomeController,

                decoration:
                const InputDecoration(

                  labelText:
                  'Other Income',

                  border:
                  OutlineInputBorder(),

                ),

                keyboardType:
                TextInputType.number,

              ),

              const SizedBox(
                  height: 20),

              ElevatedButton(

                onPressed:
                saveIncome,

                child:
                const Text(
                    "Save Income"),

              ),

            ],

          ),

        ),

      ),

    );

  }

}