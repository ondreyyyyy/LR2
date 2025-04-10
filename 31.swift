import Foundation

// Функция вычисления суммы и произведения цифр числа
// Принимает:
//   num - число для обработки
// Возвращает кортеж (sum, product)
func calculateSumAndProduct(_ num: Int) -> (sum: Int, product: Int) {
    var sum = 0         // Инициализируем сумму нулем
    var product = 1     // Инициализируем произведение единицей (1 * a = a)
    var n = num         // Копия числа для обработки
    
    // Цикл пока число не станет нулевым (пока есть цифры)
    while n != 0 {
        let digit = n % 10  // Получаем последнюю цифру (остаток от деления на 10)
        sum += digit        // Добавляем цифру к сумме
        product *= digit    // Умножаем произведение на цифру
        n /= 10             // Удаляем последнюю цифру (целочисленное деление на 10)
    }
    
    return (sum, product)
}

let n = Int(readLine()!)!  // Считываем количество чисел

// Цикл по всем числам от 1 до n
for i in 1...n {
    let number = Int(readLine()!)!  // Считываем текущее число
    
    let result = calculateSumAndProduct(number)
    
    // Если сумма цифр меньше произведения
    if result.sum < result.product {
        print("\(i) ", terminator: "")  // Выводим номер числа (позицию)
    }
}

print()  // Переводим строку после вывода всех номеров
