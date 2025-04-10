import Foundation

print("", terminator: "")
guard let input = readLine() else { exit(0) } // Получаем строку от пользователя

let n = input.count // Длина строки
var operations = n // Изначально предполагаем худший случай - добавляем все символы по одному

// Перебираем все возможные точки для удвоения
for i in 1...n/2 {
    let start = input.startIndex
    let first = input[start..<input.index(start, offsetBy: i)]
    let second = input[input.index(start, offsetBy: i)..<input.index(start, offsetBy: 2*i)]
    
    // Проверяем, можно ли удвоить первые i символов
    if first == second {
        // Вычисляем общее количество операций
        let totalOps = i + 1 + (n - 2 * i)
        // Обновляем результат, если нашли лучший вариант
        if totalOps < operations {
            operations = totalOps
        }
    }
}

print("Минимальное количество операций: \(operations)")
