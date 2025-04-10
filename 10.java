import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String input = scanner.next(); // Получаем строку от пользователя
        
        int n = input.length(); // Длина строки
        int operations = n; // Изначально предполагаем худший случай - добавляем все символы по одному
        
        // Перебираем все возможные точки для удвоения
        for (int i = 1; i <= n / 2; ++i) {
            // Проверяем, можно ли удвоить первые i символов
            if (input.substring(0, i).equals(input.substring(i, 2*i))) {
                // Вычисляем общее количество операций
                int totalOps = i + 1 + (n - 2 * i);
                // Обновляем результат, если нашли лучший вариант
                if (totalOps < operations) {
                    operations = totalOps;
                }
            }
        }
        
        System.out.println("Минимальное количество операций: " + operations);
    }
}
