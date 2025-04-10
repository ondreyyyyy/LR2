using System;

class Program {
    static void Main() {
        string input = Console.ReadLine(); // Получаем строку от пользователя
        
        int n = input.Length; // Длина строки
        int operations = n; // Изначально предполагаем худший случай - добавляем все символы по одному
        
        // Перебираем все возможные точки для удвоения
        for (int i = 1; i <= n / 2; ++i) {
            // Проверяем, можно ли удвоить первые i символов
            if (input.Substring(0, i) == input.Substring(i, i)) {
                // Вычисляем общее количество операций
                int totalOps = i + 1 + (n - 2 * i);
                // Обновляем результат, если нашли лучший вариант
                if (totalOps < operations) {
                    operations = totalOps;
                }
            }
        }
        
        Console.WriteLine($"Минимальное количество операций: {operations}");
    }
}
