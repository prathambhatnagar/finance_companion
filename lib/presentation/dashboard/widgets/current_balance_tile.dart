import 'package:flutter/material.dart';

class CurrentBalanceTile extends StatefulWidget {
  const CurrentBalanceTile({super.key});

  @override
  State<CurrentBalanceTile> createState() => _CurrentBalanceTileState();
}

class _CurrentBalanceTileState extends State<CurrentBalanceTile> {
  bool isBalanceVisible = false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () => setState(() => isBalanceVisible = !isBalanceVisible),
      child: SizedBox(
        child: Container(
          color: Colors.amber,
          height: mediaQuery.size.height / 3,
          child: Center(
            child: Text(
              isBalanceVisible ? ' \$4,56,486' : 'XXX XXX XXX',
              style: TextStyle(fontSize: 24, letterSpacing: 1.6),
            ),
          ),
        ),
      ),
    );
  }
}
