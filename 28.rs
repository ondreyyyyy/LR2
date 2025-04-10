use std::io;

// Функция вычисления суммы и произведения цифр числа
// Принимает:
//   num - число для обработки
// Возвращает кортеж (sum, product)
fn calculate_sum_and_product(num: i32) -> (i32, i32) {
    let mut sum = 0;         // Инициализируем сумму нулем
    let mut product = 1;     // Инициализируем произведение единицей (1 * a = a)
    let mut n = num;         // Копия числа для обработки
    
    // Цикл пока число не станет нулевым (пока есть цифры)
    while n != 0 {
        let digit = n % 10;  // Получаем последнюю цифру (остаток от деления на 10)
        sum += digit;        // Добавляем цифру к сумме
        product *= digit;    // Умножаем произведение на цифру
        n /= 10;            // Удаляем последнюю цифру (целочисленное деление на 10)
    }
    
    (sum, product)
}

fn main() {
    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();
    let n: i32 = input.trim().parse().unwrap();  // Считываем количество чисел
    
    // Цикл по всем числам от 1 до n
    for i in 1..=n {
        let mut number_input = String::new();
        io::stdin().read_line(&mut number_input).unwrap();
        let number: i32 = number_input.trim().parse().unwrap();  // Считываем текущее число
        
        let (sum, product) = calculate_sum_and_product(number);
        
        // Если сумма цифр меньше произведения
        if sum < product {
            print!("{} ", i);  // Выводим номер числа (позицию)
        }
    }
    
    println!();  // Переводим строку после вывода всех номеров
}
