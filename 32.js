const readline = require('readline');

// Функция вычисления суммы и произведения цифр числа
function calculateSumAndProduct(num, result) {
    result.sum = 0;         // Инициализируем сумму нулем
    result.product = 1;     // Инициализируем произведение единицей
    let n = num;            // Копия числа для обработки
    
    // Обрабатываем случай, когда число 0
    if (n === 0) {
        result.sum = 0;
        result.product = 0;
        return;
    }
    
    // Цикл пока число не станет нулевым
    while (n !== 0) {
        const digit = n % 10;  // Получаем последнюю цифру
        result.sum += digit;   // Добавляем цифру к сумме
        result.product *= digit; // Умножаем произведение на цифру
        n = Math.floor(n / 10); // Удаляем последнюю цифру
    }
}

async function main() {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

        const readLine = () => new Promise(resolve => {
        rl.once('line', resolve);
    });

    // Чтение количества чисел
    const n = parseInt(await readLine());
    let output = '';
    let isFirst = true;

    // Чтение и обработка n чисел
    for (let i = 1; i <= n; i++) {
        const number = parseInt(await readLine());
        const result = {};
        
        calculateSumAndProduct(number, result);
        
        // Если сумма меньше произведения
        if (result.sum < result.product) {
            if (!isFirst) {
                output += ' ';
            }
            output += i;
            isFirst = false;
        }
    }

    console.log(output); // Вывод всех результатов
    rl.close();
}

main().catch(console.error);
