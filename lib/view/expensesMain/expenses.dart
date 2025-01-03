import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/bottomSheet/expenses_bottom_sheet.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpenses = [
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Flutter Food",
      amount: 1200.23,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Flutter leisure",
      amount: 130.74,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true, // FullScreen: BottomSheetModel
      context: context,
      constraints: BoxConstraints(
        minWidth: 0,
        maxWidth: MediaQuery.of(context).size.width,
        ),
      builder: (ctx) => ExpensesBottomSheet(
        onAddExpense: _addExpense,
      ),
    );
  }


  void _addExpense(Expense expense) {
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  // void _onRemoveExpense({required Expense expense}) {
  //   setState(() {
  //     _registerExpenses.remove(expense);
  //   });
  // }

  void _onRemoveExpense(Expense expense) {
    final expenseIndex = _registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registerExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    // print("width : $width");
    // print("height : $height");
    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding some !"),
    );

    if (_registerExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerExpenses,
        // onRemoveExpense: (direction) {
        //   _onRemoveExpense(expense: direction);
        // },
        onRemoveExpense: _onRemoveExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(
                  expenses: _registerExpenses,
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(
                    expenses: _registerExpenses,
                  ),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}


// Note: 
/// Col(^) -> height not limit more *^ 
///        -> width equal parent(Scaffold)
/// 
/// Row(>) -> height equal parent(Scaffold)
///        -> width not limit more *>
///
/// incase use: double.infinity set on width then row boom -> fix by expanded
///
///
///
///
///