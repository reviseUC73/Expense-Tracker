import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) =>
          // Dismissible: widget that have ปัดขวาเพื่อลบ
      Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.75),
        // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal/2,
            vertical: Theme.of(context).cardTheme.margin!.vertical/2,
          ),
        ),
        onDismissed: (directionItem) {
          // onDismissed: manage index that u clear
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}








    // print("horizontal : ${Theme.of(context).cardTheme.margin!.horizontal}");
    // print("vertical : ${Theme.of(context).cardTheme.margin!.vertical}");