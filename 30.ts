// Функция вычисления суммы и произведения цифр числа
function calculateSumAndProduct(num: number): [number, number] {
    let sum = 0;
    let product = 1;
    let n = Math.abs(num);
    
    while (n > 0) {
        const digit = n % 10;
        sum += digit;
        product *= digit;
        n = Math.floor(n / 10);
    }
    
    return [sum, product];
}

// Основная функция программы
async function processNumbers() {
    // Ввод количества чисел
    const countInput = prompt("Введите количество чисел:") || "0";
    const count = parseInt(countInput);
    
    if (isNaN(count) || count <= 0) {
        console.log("Некорректный ввод количества чисел");
        return;
    }

    let resultOutput = "";
    
    // Обработка каждого числа по очереди
    for (let i = 1; i <= count; i++) {
        const numInput = prompt(`Введите число ${i}:`) || "0";
        const num = parseInt(numInput);
        
        if (isNaN(num)) {
            console.log(`Ошибка в числе ${i}`);
            continue;
        }
        
        const [sum, product] = calculateSumAndProduct(num);
        
        if (sum < product) {
            if (resultOutput !== "") {
                resultOutput += " ";
            }
            resultOutput += i.toString();
        }
    }
    
    // Вывод результатов
    console.log(resultOutput || "Нет чисел, удовлетворяющих условию");
}

// Вызываем основную функцию
processNumbers().catch(console.error);
