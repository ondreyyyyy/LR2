#include <iostream>
#include <unordered_set>
#include <string>
#include <algorithm>

using namespace std;

// Проверяет, является ли символ допустимым в имени пользователя
bool is_valid_char(char c) {
    return (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9') || (c == '.');
}

// Проверяет, соответствует ли имя пользователя требованиям
bool is_valid_username(const string& username) {
    // Проверка длины (6–30 символов)
    if (username.length() < 6 || username.length() > 30) {
        cerr << "Ошибка: Имя пользователя должно быть от 6 до 30 символов." << endl;
        return false;
    }

    // Проверка первого и последнего символа (не точка)
    if (username.front() == '.' || username.back() == '.') {
        cerr << "Ошибка: Имя пользователя не может начинаться или заканчиваться точкой." << endl;
        return false;
    }

    // Проверка на запрещённые символы и двойные точки
    bool prev_is_dot = false;
    for (char c : username) {
        // Проверяем, что символ разрешён
        if (!is_valid_char(c)) {
            cerr << "Ошибка: Недопустимый символ '" << c << "' в имени пользователя." << endl;
            return false;
        }

        // Проверяем на несколько точек подряд
        if (c == '.') {
            if (prev_is_dot) {
                cerr << "Ошибка: Не может быть двух точек подряд." << endl;
                return false;
            }
            prev_is_dot = true;
        } else {
            prev_is_dot = false;
        }
    }

    return true;
}

// Приводит строку к нижнему регистру (без cctype)
void to_lower(string& s) {
    for (char& c : s) {
        if (c >= 'A' && c <= 'Z') {
            c = c - 'A' + 'a'; // Преобразуем в нижний регистр
        }
    }
}

// Обрабатывает email, возвращает пустую строку, если email некорректен
string process_email(const string& email) {
    size_t at_pos = email.find('@');
    if (at_pos == string::npos) {
        cerr << "Ошибка: Отсутствует символ '@' в email." << endl;
        return "";
    }

    string username = email.substr(0, at_pos);
    string domain = email.substr(at_pos);

    // Приводим username к нижнему регистру (без cctype)
    to_lower(username);

    // Удаляем всё после '+' (если такой символ есть)
    size_t plus_pos = username.find('+');
    if (plus_pos != string::npos) {
        username = username.substr(0, plus_pos);
    }

    // Проверяем валидность username
    if (!is_valid_username(username)) {
        return ""; // возвращаем пустую строку, если email некорректен
    }

    return username + domain;
}

int main() {
    setlocale(LC_ALL, "RU");
    unordered_set<string> unique_emails;
    string input;

    cout << "Введите email-адреса через запятую: ";
    getline(cin, input);

    size_t start = 0;
    size_t end = input.find(',');

    while (end != string::npos) {
        string email = input.substr(start, end - start);
        email.erase(remove_if(email.begin(), email.end(), ::isspace), email.end());

        if (!email.empty()) {
            string processed = process_email(email);
            if (!processed.empty()) {
                unique_emails.insert(processed);
            }
        }

        start = end + 1;
        end = input.find(',', start);
    }

    // Обработка последнего email
    string last_email = input.substr(start);
    last_email.erase(remove_if(last_email.begin(), last_email.end(), ::isspace), last_email.end());
    if (!last_email.empty()) {
        string processed = process_email(last_email);
        if (!processed.empty()) {
            unique_emails.insert(processed);
        }
    }

    cout << "Количество уникальных адресов: " << unique_emails.size() << endl;

    return 0;
}
