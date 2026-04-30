import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:finance_companion/core/utility/id_generator.dart';
import 'package:finance_companion/core/widgets/loader.dart';
import 'package:finance_companion/domain/entities/account/account_entity.dart';
import 'package:finance_companion/domain/entities/transaction/category_entity.dart';
import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_event.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_state.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  GlobalKey<FormState> formeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  List<bool> isSelected = [true, false];
  DateTime? selectedDate = DateTime.now();
  TransactionCategoryEntity? selectedCategory;
  AccountEntity? selectedAccount;

  TextEditingController amountController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Transaction'), centerTitle: true),
      body: Form(
        key: formeKey,
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
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter amount';
                  if (double.tryParse(value) == null) return 'Invalid amount';
                  return null;
                },
              ),

              SizedBox(height: 20),
              _title('Category'),
              SizedBox(height: 10),

              DropdownSearch<TransactionCategoryEntity>(
                items: (filter, _) => spendingCategories
                    .where(
                      (item) => item.name.toLowerCase().contains(
                        filter.toLowerCase(),
                      ),
                    )
                    .toList(),

                selectedItem: selectedCategory,

                itemAsString: (item) => item.name,

                compareFn: (item, selectedItem) => item.id == selectedItem.id,

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

              // Flexible(
              //   child: Stack(
              //     children: [
              //       Align(
              //         alignment: Alignment.center,
              //         child: Container(
              //           height: 55,
              //           decoration: BoxDecoration(
              //             border: Border.all(
              //               width: 2,
              //               color: Colors.deepPurple,
              //             ),
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //         ),
              //       ),

              //       Align(
              //         alignment: Alignment.center,

              //         child: ListWheelScrollView.useDelegate(
              //           physics: FixedExtentScrollPhysics(),

              //           diameterRatio: 1,
              //           itemExtent: 35,
              //           childDelegate: ListWheelChildLoopingListDelegate(
              //             children: [
              //               Text('Card', style: TextStyle(fontSize: 28)),
              //               Text('Cash', style: TextStyle(fontSize: 28)),
              //               Text('Savings', style: TextStyle(fontSize: 28)),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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

                    if (accounts.isEmpty) return Text('No Accounts Found');

                    selectedAccount ??= accounts.first;

                    // return Flexible(
                    //   child: Stack(
                    //     children: [
                    //       Align(
                    //         alignment: Alignment.center,
                    //         child: Container(
                    //           height: 55,
                    //           decoration: BoxDecoration(
                    //             border: Border.all(
                    //               width: 2,
                    //               color: Colors.deepPurple,
                    //             ),
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //         ),
                    //       ),

                    //       Align(
                    //         alignment: Alignment.center,

                    //         child: ListWheelScrollView.useDelegate(
                    //           physics: FixedExtentScrollPhysics(),

                    //           diameterRatio: 1,
                    //           itemExtent: 35,
                    //           childDelegate: ListWheelChildLoopingListDelegate(
                    //             children: [
                    //               Text('Card', style: TextStyle(fontSize: 28)),
                    //               Text('Cash', style: TextStyle(fontSize: 28)),
                    //               Text(
                    //                 'Savings',
                    //                 style: TextStyle(fontSize: 28),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );

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

              SizedBox(height: 20),
              _title('Note'),
              SizedBox(height: 10),

              TextFormField(
                controller: noteController,
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
                  onPressed: () {
                    if (!formeKey.currentState!.validate()) return;

                    if (selectedAccount == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select an account')),
                      );
                      return;
                    }

                    final transaction = TransactionEntity(
                      id: generateId(),
                      note: noteController.text,
                      amount: double.parse(amountController.text),
                      type: isSelected[0]
                          ? TransactionTypeEntity.income
                          : TransactionTypeEntity.expense,
                      timeStamp: selectedDate ?? DateTime.now(),
                      category: selectedCategory,
                      account: selectedAccount!,
                    );

                    context.read<TransactionBloc>().add(
                      AddTransactionEvent(transaction: transaction),
                    );

                    context.read<AccountBloc>().add(GetAccountsEvent());

                    Navigator.pop(context);
                  },
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
