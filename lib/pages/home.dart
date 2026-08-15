import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../components/HomePageComponents.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {

  double monthlyIncome = 0.0;
  String name = '';

  double Income = 0.0;

  List<double> categories =
      [0.0, 0.0, 0.0, 0.0, 0.0];

  double expenses = 0.0;

  @override
  void initState() {

    super.initState();

    loadData();

  }

  Future<void> loadData() async {

    final sharedPreferences =
        await SharedPreferences.getInstance();

    final savedIncome =
        sharedPreferences.getDouble(
            'monthlyIncome') ?? 0.0;

    final savedName =
        sharedPreferences.getString(
            'name') ?? '';

    final otherIncome =
      sharedPreferences.getDouble(
        'otherIncome') ?? 0.0;

    List<String> expenseList =
        sharedPreferences.getStringList(
            'expenses') ?? [];

    double totalExpenses = 0.0;

    List<double> tempCategories =
        [0, 0, 0, 0, 0];

    for (var item in expenseList) {

      final expense =
          jsonDecode(item);

      double amount =
          (expense['amount']
              as num)
              .toDouble();

      totalExpenses += amount;

      if (expense["category"] ==
          "Food") {

        tempCategories[0] +=
            amount;

      } else if
      (expense["category"] ==
          "Shopping") {

        tempCategories[1] +=
            amount;

      } else if
      (expense["category"] ==
          "Travel") {

        tempCategories[2] +=
            amount;

      } else if
      (expense["category"] ==
          "Entmt") {

        tempCategories[3] +=
            amount;

      } else {

        tempCategories[4] +=
            amount;

      }

    }

    setState(() {

      name = savedName;

      expenses =
          totalExpenses;

      categories =
          tempCategories;

      Income = otherIncome;

      monthlyIncome =
        savedIncome +
        Income -
        totalExpenses;

    });

  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      body: RefreshIndicator(

        onRefresh: loadData,

        child:
        SingleChildScrollView(

          physics:
          const AlwaysScrollableScrollPhysics(),

          child: Column(

            children: [

              Stack(

                clipBehavior:
                    Clip.none,

                children: [

                  HomeHeader(
                      username:
                      name),

                  Positioned(

                    bottom: -150,

                    left: 16,

                    right: 16,

                    top: 160,

                    child:
                    BalanceCard(

                      totalBalance:
                      monthlyIncome,

                      income: Income,

                      expenses:
                      expenses,

                    ),

                  ),

                ],

              ),

              const SizedBox(
                  height: 180),

              SpendingBreakDownCard(

                food:
                categories[0],

                transport:
                categories[2],

                entertainment:
                categories[3],

                bills:
                categories[1],

                others:
                categories[4],

              ),

              const SizedBox(
                  height: 50),

            ],

          ),

        ),

      ),

    );

  }

}