import 'package:expense_tracker/models/expense.dart';

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  final Category category;
  final List<Expense> expenses;

  // constructor แบบ named (named constructor)
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}

// void main() {
//   // ตัวอย่างรายการค่าใช้จ่ายทั้งหมด
//   final allExpenses = [
//     Expense(
//       title: 'Lunch',
//       amount: 10.5,
//       date: DateTime.now(),
//       category: Category.food,
//     ),
//     Expense(
//       title: 'Plane Ticket',
//       amount: 200,
//       date: DateTime.now(),
//       category: Category.travel,
//     ),
//     Expense(
//       title: 'Movie',
//       amount: 15,
//       date: DateTime.now(),
//       category: Category.leisure,
//     ),
//   ];

//   // กรองรายการเฉพาะหมวดหมู่ Food
//   final foodBucket = ExpenseBucket.forCategory(allExpenses, Category.food);
//   print(foodBucket.category.name);
//   print(foodBucket.expenses.length); // แสดงจำนวนรายการในหมวด Food
//   print(foodBucket.totalExpenses); // แสดงผลรวมค่าใช้จ่ายในหมวด Food
//   print("==========");
//   final x = ExpenseBucket(category: Category.food, expenses: allExpenses);
//   print(x.category);
//   print(x.expenses.first.formattedDate);
// }
