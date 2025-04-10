package main

import (
  "fmt"
)

func main() {
  var input string
  fmt.Scan(&input) // Получаем строку от пользователя
  
  n := len(input) // Длина строки
  operations := n // Изначально предполагаем худший случай - добавляем все символы по одному
  
  // Перебираем все возможные точки для удвоения
  for i := 1; i <= n/2; i++ {
    // Проверяем, можно ли удвоить первые i символов
    if input[:i] == input[i:2*i] {
      // Вычисляем общее количество операций
      totalOps := i + 1 + (n - 2*i)
      // Обновляем результат, если нашли лучший вариант
      if totalOps < operations {
        operations = totalOps
      }
    }
  }
  
  fmt.Printf("Минимальное количество операций: %d\n", operations)
}
