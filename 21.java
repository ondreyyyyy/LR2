import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<String> uniqueEmails = new HashSet<>();
        Scanner scanner = new Scanner(System.in);
        
        System.out.print("Введите email-адреса через запятую: ");
        String input = scanner.nextLine();
        
        for (String rawEmail : input.split(",")) {
            String email = rawEmail.trim();
            if (!email.isEmpty()) {
                String processed = processEmail(email);
                if (!processed.isEmpty()) {
                    uniqueEmails.add(processed);
                }
            }
        }
        
        System.out.println("Количество уникальных адресов: " + uniqueEmails.size());
    }
    
    private static boolean isValidChar(char c) {
        return (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9') || c == '.';
    }
    
    private static boolean isValidUsername(String username) {
        if (username.length() < 6 || username.length() > 30) {
            System.err.println("Ошибка: Имя пользователя должно быть от 6 до 30 символов.");
            return false;
        }
        
        if (username.charAt(0) == '.' || username.charAt(username.length() - 1) == '.') {
            System.err.println("Ошибка: Имя пользователя не может начинаться или заканчиваться точкой.");
            return false;
        }
        
        boolean prevIsDot = false;
        for (char c : username.toCharArray()) {
            if (!isValidChar(c)) {
                System.err.println("Ошибка: Недопустимый символ '" + c + "' в имени пользователя.");
                return false;
            }
            
            if (c == '.') {
                if (prevIsDot) {
                    System.err.println("Ошибка: Не может быть двух точек подряд.");
                    return false;
                }
                prevIsDot = true;
            } else {
                prevIsDot = false;
            }
        }
        
        return true;
    }
    
    private static String processEmail(String email) {
        int atPos = email.indexOf('@');
        if (atPos == -1) {
            System.err.println("Ошибка: Отсутствует символ '@' в email.");
            return "";
        }
        
        String username = email.substring(0, atPos).toLowerCase();
        String domain = email.substring(atPos);
        
        int plusPos = username.indexOf('+');
        if (plusPos != -1) {
            username = username.substring(0, plusPos);
        }
        
        if (!isValidUsername(username)) {
            return "";
        }
        
        return username + domain;
    }
}
