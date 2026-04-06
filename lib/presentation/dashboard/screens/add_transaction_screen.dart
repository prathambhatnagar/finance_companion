import 'package:dropdown_search/dropdown_search.dart';
import 'package:finance_companion/core/widgets/loader.dart';
import 'package:finance_companion/domain/entities/account/account_entity.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_event.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<bool> isSelected = [true, false];
  DateTime? selectedDate = DateTime.now();
  String? selectedCategory;
  AccountEntity? selectedAccount;

  final List<String> spendingCategories = [
    'Housing',
    'Utilities',
    'Groceries',
    'Transportation',
    'Entertainment',
    'Shopping',
    'Travel',
    'Health',
    'Education',
    'Savings',
    'Miscellaneous',
  ];

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

              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    selectedDate == null
                        ? 'Select Date'
                        : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    style: TextStyle(fontSize: 16),
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

              DropdownSearch<String>(
                items: (filter, _) => spendingCategories
                    .where(
                      (item) =>
                          item.toLowerCase().contains(filter.toLowerCase()),
                    )
                    .toList(),
                selectedItem: selectedCategory,

                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    hintText: "Select Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                ),

                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  menuProps: MenuProps(borderRadius: BorderRadius.circular(12)),
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: "Search category...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),

              SizedBox(height: 20),
              _title('Account'),
              SizedBox(height: 10),
              BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  if (state is AccountLoadingState) {
                    return Loader();
                  } else if (state is AccountErrorgState) {
                    return Text(state.message);
                  } else if (state is AccountLoadedState) {
                    final accounts = state.accounts;
                    if (accounts.isEmpty) return Text('No Accouts Found');
                    return DropdownButtonFormField<AccountEntity>(
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(10),
                      value: selectedAccount,
                      decoration: InputDecoration(
                        hintText: "Select Account",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),

                      items: accounts.map((account) {
                        return DropdownMenuItem<AccountEntity>(
                          value: account,
                          child: Text(account.name),
                        );
                      }).toList(),

                      onChanged: (value) {
                        setState(() {
                          selectedAccount = value;
                        });
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
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
