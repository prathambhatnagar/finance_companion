import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  late TabController tabController;

  @override
  void initState() {
    // tabController = TabController(length: 2, vsync: true);
    super.initState();
  }

  @override
  void dispose() {
    // tabController.dispose();
    super.dispose();
  }

  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Transaction'), centerTitle: true),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(10),
                  isSelected: isSelected,
                  onPressed: (index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                    });
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text('Income', style: TextStyle(fontSize: 16)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text('Expense', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              _title('Date'),
              SizedBox(height: 10),

              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 20),
              _title('Amount'),
              SizedBox(height: 10),

              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 20),
              _title('Category'),
              SizedBox(height: 10),

              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 150, vertical: 8),
                    ),
                    backgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 20),
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

Widget _title(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  );
}
