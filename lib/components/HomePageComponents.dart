import 'package:fl_chart/fl_chart.dart';
import "package:flutter_svg/flutter_svg.dart";
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final log = Logger();

class HomeHeader extends StatelessWidget {
  final String username;

  const HomeHeader({
    super.key,
    this.username = "User",
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: height * 0.25,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(height * 0.1),
          bottomRight: Radius.circular(height * 0.1),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Top Row: Title + Notification ──
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Row(
                  children: [
                    const SizedBox(width: 48),
                    Expanded(
                      child: Text(                        // ← removed const (username is dynamic)
                        'CashVibe',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications, color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ── Bottom Row: User Info + Avatar ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Hi, $username ",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 24,
                          ),
                        ],
                      ),
                      const Text(
                        "Your Money at a Glance",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class BalanceCard extends StatefulWidget {
  final double totalBalance, income, expenses;

  const BalanceCard({
    super.key,
    this.totalBalance = 0,
    this.income = 0,
    this.expenses = 0,
  });


  

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 228, 228, 228),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(122, 83, 83, 83),
            blurRadius: 20,
            spreadRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Blue Balance Container ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Balance",
                      style: TextStyle(
                        color: Color.fromARGB(235, 240, 240, 240),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.currency_rupee, color: Colors.white, size: 18),
                        Text(
                          "${widget.totalBalance}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SvgPicture.asset(
                  "resource/icons/coin-stack-money-svgrepo-com.svg",
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── White Income/Expense Container ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Income
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      const Text(
                        "Income",
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.arrow_upward, color: Colors.green, size: 16),
                          Text(
                            "₹${widget.income}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(width: 1, height: 40, color: Colors.grey[300]),

                // Expenses
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      const Text(                       // ← added const
                        "Expenses",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.arrow_downward, color: Colors.red, size: 16),
                          Text(
                            "₹${widget.expenses}",
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class SpendingBreakDownCard extends StatelessWidget {
  final double food, transport, entertainment, bills, others;

  const SpendingBreakDownCard({
    super.key,
    this.food = 0,
    this.transport = 0,
    this.entertainment = 0,
    this.bills = 0,
    this.others = 0,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final double total = food + transport + entertainment + bills + others;

    // ── Fixed: parameter is now double, no .toInt() cast needed ──
    double pct(double val) {
      if (total == 0) return 0;
      return val / total * 100;
    }

    return Container(
      margin: const EdgeInsets.all(16),
      width: width,
      height: height * 0.32,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(122, 83, 83, 83),
            blurRadius: 20,
            spreadRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Spending Breakdown",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // ── Pie Chart ──
              SizedBox(
                width: width * 0.4,
                height: height * 0.2,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 30,
                    sections: [
                      PieChartSectionData(
                        value: food,
                        color: Colors.orange,
                        title: 'F\n${pct(food).toStringAsFixed(1)}%',
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      PieChartSectionData(
                        value: transport,
                        color: Colors.blue,
                        title: 'T\n${pct(transport).toStringAsFixed(1)}%',
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      PieChartSectionData(
                        value: entertainment,
                        color: Colors.green,
                        title: 'E\n${pct(entertainment).toStringAsFixed(1)}%',
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      PieChartSectionData(
                        value: bills,
                        color: Colors.red,
                        title: 'B\n${pct(bills).toStringAsFixed(1)}%',
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      PieChartSectionData(
                        value: others,
                        color: Colors.purple,
                        title: 'O\n${pct(others).toStringAsFixed(1)}%',
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // ── Legend ──
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _legendItem(Colors.orange, 'Food', food),
                    const SizedBox(height: 6),           // ← added gaps to prevent overflow
                    _legendItem(Colors.blue, 'Travel', transport),
                    const SizedBox(height: 6),
                    _legendItem(Colors.green, 'Entmt', entertainment),
                    const SizedBox(height: 6),
                    _legendItem(Colors.red, 'Bills', bills),
                    const SizedBox(height: 6),
                    _legendItem(Colors.purple, 'Others', others),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label, double amount) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 8),


        Text('$label :  ₹${amount.toStringAsFixed(0)}',overflow: TextOverflow.ellipsis,maxLines: 1,style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}