use std::io;

fn main() {
    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap(); // Получаем строку от пользователя
    let input = input.trim();
    
    let n = input.len(); // Длина строки
    let mut operations = n; // Изначально предполагаем худший случай - добавляем все символы по одному
    
    // Перебираем все возможные точки для удвоения
    for i in 1..=n/2 {
        // Проверяем, можно ли удвоить первые i символов
        if input[0..i] == input[i..2*i] {
            // Вычисляем общее количество операций
            let total_ops = i + 1 + (n - 2 * i);
            // Обновляем результат, если нашли лучший вариант
            if total_ops < operations {
                operations = total_ops;
            }
        }
    }
    
    println!("Минимальное количество операций: {}", operations);
}
