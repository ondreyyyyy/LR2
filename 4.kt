fun main() {
    val input = readLine()!! // Получаем строку от пользователя
    
    val n = input.length // Длина строки
    var operations = n // Изначально предполагаем худший случай - добавляем все символы по одному
    
    // Перебираем все возможные точки для удвоения
    for (i in 1..n/2) {
        // Проверяем, можно ли удвоить первые i символов
        if (input.substring(0, i) == input.substring(i, i*2)) {
            // Вычисляем общее количество операций
            val totalOps = i + 1 + (n - 2 * i)
            // Обновляем результат, если нашли лучший вариант
            if (totalOps < operations) {
                operations = totalOps
            }
        }
    }
    
    println("Минимальное количество операций: $operations")
}
