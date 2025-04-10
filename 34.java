import java.util.Scanner;

public class Main {

    // Функция вычисляет сумму и произведение цифр числа
    // Возвращает битовую маску (sum << 16) | product
    static int calculateSumAndProduct(int num) {
        int sum = 0;
        int product = 1;
        
        while (num != 0) {
            int digit = num % 10;
            sum += digit;
            product *= digit;
            num /= 10;
        }
        
        return (sum << 16) | (product & 0xFFFF);
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // Чтение количества чисел
        int n = scanner.nextInt();
        
        // Обработка каждого числа
        for (int i = 1; i <= n; i++) {
            int number = scanner.nextInt();
            
            int result = calculateSumAndProduct(number);
            int sum = (result >> 16) & 0xFFFF;
            int product = result & 0xFFFF;
            
            if (sum < product) {
                System.out.print(i + " ");
            }
        }
        
        System.out.println();
    }
}
