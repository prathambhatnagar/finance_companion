import 'package:flutter/material.dart';

class ErrorTile extends StatelessWidget {
  const ErrorTile({super.key, this.error});
  final String? error;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded, size: 40, color: Colors.red),
          SizedBox(height: 10),
          Text(
            error ?? 'Something Went Wrong',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
