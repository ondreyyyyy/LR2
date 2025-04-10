using System;
using System.Collections.Generic;
using System.Linq;

class Program {
    static void Main() {
        var uniqueEmails = new HashSet<string>();
        Console.WriteLine("Введите email-адреса через запятую: ");
        var input = Console.ReadLine();
        
        foreach (var email in input.Split(',').Select(e => e.Trim()).Where(e => !string.IsNullOrEmpty(e))) {
            var processed = ProcessEmail(email);
            if (!string.IsNullOrEmpty(processed)) {
                uniqueEmails.Add(processed);
            }
        }
        
        Console.WriteLine($"Количество уникальных адресов: {uniqueEmails.Count}");
    }
    
    static bool IsValidChar(char c) {
        return (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9') || c == '.';
    }
    
    static bool IsValidUsername(string username) {
        if (username.Length < 6 || username.Length > 30) {
            Console.Error.WriteLine("Ошибка: Имя пользователя должно быть от 6 до 30 символов.");
            return false;
        }
        
        if (username[0] == '.' || username[username.Length - 1] == '.') {
            Console.Error.WriteLine("Ошибка: Имя пользователя не может начинаться или заканчиваться точкой.");
            return false;
        }
        
        bool prevIsDot = false;
        foreach (var c in username) {
            if (!IsValidChar(c)) {
                Console.Error.WriteLine($"Ошибка: Недопустимый символ '{c}' в имени пользователя.");
                return false;
            }
            
            if (c == '.') {
                if (prevIsDot) {
                    Console.Error.WriteLine("Ошибка: Не может быть двух точек подряд.");
                    return false;
                }
                prevIsDot = true;
            } else {
                prevIsDot = false;
            }
        }
        
        return true;
    }
    
    static string ProcessEmail(string email) {
        var atPos = email.IndexOf('@');
        if (atPos == -1) {
            Console.Error.WriteLine("Ошибка: Отсутствует символ '@' в email.");
            return "";
        }
        
        var username = email.Substring(0, atPos).ToLower();
        var domain = email.Substring(atPos);
        
        var plusPos = username.IndexOf('+');
        if (plusPos != -1) {
            username = username.Substring(0, plusPos);
        }
        
        if (!IsValidUsername(username)) {
            return "";
        }
        
        return username + domain;
    }
}
