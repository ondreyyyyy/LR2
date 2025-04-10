using System;

class Program {
    // Функция вычисления суммы и произведения цифр числа
    // Принимает:
    //   num - число для обработки
    //   sum - out параметр для суммы цифр
    //   product - out параметр для произведения цифр
    static void CalculateSumAndProduct(int num, out int sum, out int product) {
        sum = 0;         // Инициализируем сумму нулем
        product = 1;     // Инициализируем произведение единицей (1 * a = a)
        int digit;       // Переменная для хранения текущей цифры
        
        // Цикл пока число не станет нулевым (пока есть цифры)
        while (num != 0) {
            digit = num % 10;  // Получаем последнюю цифру (остаток от деления на 10)
            sum += digit;      // Добавляем цифру к сумме
            product *= digit;  // Умножаем произведение на цифру
            num /= 10;         // Удаляем последнюю цифру (целочисленное деление на 10)
        }
    }

    static void Main() {
        int n = int.Parse(Console.ReadLine());  // Считываем количество чисел
        
        // Цикл по всем числам от 1 до n
        for (int i = 1; i <= n; i++) {
            int number = int.Parse(Console.ReadLine());  // Считываем текущее число
            
            int sum, product;
            CalculateSumAndProduct(number, out sum, out product);
            
            // Если сумма цифр меньше произведения
            if (sum < product) {
                Console.Write($"{i} ");  // Выводим номер числа (позицию)
            }
        }
        
        Console.WriteLine();  // Переводим строку после вывода всех номеров
    }
}
