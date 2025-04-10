#include <iostream>
#include <string>
using namespace std;
int main() {
  setlocale(LC_ALL, "RU");
  cout << "Введите строку: "; // Пользователь вводит строку для анализа
  string input;
  cin >> input; 
    int n = input.size(); // Длина введенной строки
    int operations = n; // Изначально предполагается, что все символы в строке - уникальны
for (int i = 1; i <= n / 2; ++i) { // Перебор всех возможных точек удвоения (до половины строки)
if (input.substr(0, i) == input.substr(i, i)) { // Сравниваем первую часть строки со второй
int total_ops = i + 1 + (n - 2 * i); // Формула для вычисления минимального количества операций
if (total_ops < operations) { // В случае, если найдено меньшее число операций, записываем результат в финальную переменную
                operations = total_ops;
            }
        }
    }
    cout << "Минимальное количество операций: " << operations << endl; // Вывод результата
    return 0;
}
