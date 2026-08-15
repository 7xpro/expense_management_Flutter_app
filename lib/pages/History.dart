import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/HistoryPageComponents.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() =>
      _HistoryPageState();
}

class _HistoryPageState
    extends State<HistoryPage> {

  List<String> history = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    final prefs =
        await SharedPreferences.getInstance();

    setState(() {

      history =
          prefs.getStringList(
              'expenses')
          ?? [];

    });

  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(

      itemCount: history.length,

      itemBuilder:
          (context, index) {

        final expense =
            jsonDecode(
                history[index]);

        final expenseDate =
            DateTime.parse(
                expense['date']);

        final formattedDate =
            "${expenseDate.day}/"
            "${expenseDate.month}/"
            "${expenseDate.year}";

        return HistoryCard(

          title:
              expense['category'],

          amount:
              expense['amount']
                  .toString(),

          date:
              formattedDate,

          notes:
              expense['note'],

        );

      },

    );

  }

}