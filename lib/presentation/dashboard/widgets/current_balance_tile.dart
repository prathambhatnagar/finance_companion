import 'package:finance_companion/core/utility/currency_format.dart';
import 'package:finance_companion/domain/entities/account/account_entity.dart';
import 'package:flutter/material.dart';

class CurrentBalanceCard extends StatefulWidget {
  const CurrentBalanceCard({super.key, required this.account});

  final AccountEntity account;

  @override
  State<CurrentBalanceCard> createState() => _CurrentBalanceCardState();
}

class _CurrentBalanceCardState extends State<CurrentBalanceCard> {
  final ValueNotifier<bool> showBalance = ValueNotifier<bool>(false);

  Future<void> revealBalance() async {
    showBalance.value = true;
    await Future.delayed(Duration(seconds: 3));
    showBalance.value = false;
  }

  @override
  void dispose() {
    showBalance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final previous = widget.account.previous ?? widget.account.balance;
    final difference = widget.account.balance - previous;
    final isIncrease = difference >= 0;
    final percent = previous != 0 ? (difference / previous) * 100 : 0;

    return GestureDetector(
      onTap: () => revealBalance(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.all(20),
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF2C1A4D), Color(0xFF6A3DE8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            /// Subtle background pattern
            Positioned(
              right: -30,
              top: -20,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(10),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Top Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total balance',
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.account.name,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.chevron_right, color: Colors.white70),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                ValueListenableBuilder(
                  valueListenable: showBalance,
                  builder: (context, value, child) {
                    return Text(
                      showBalance.value
                          ? '\$${format.format(widget.account.balance)}'
                          : 'XXXXXXXX',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: showBalance.value
                            ? FontWeight.bold
                            : FontWeight.w400,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Text(
                      isIncrease ? 'Increase' : 'Decrease',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      isIncrease ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 16,
                      color: isIncrease ? Colors.greenAccent : Colors.redAccent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${percent.toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: isIncrease
                            ? Colors.greenAccent
                            : Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    if (!showBalance.value) ...[
                      Text(
                        'Tap to reveal',
                        style: const TextStyle(
                          color: Colors.white70,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
