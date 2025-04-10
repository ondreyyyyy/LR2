const readline = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
});

readline.question('Введите строку: ', (input) => {
    const n = input.length; // Длина строки
    let operations = n; // Изначально предполагаем худший случай - добавляем все символы по одному
    
    // Перебираем все возможные точки для удвоения
    for (let i = 1; i <= n / 2; ++i) {
        // Проверяем, можно ли удвоить первые i символов
        if (input.substring(0, i) === input.substring(i, 2*i)) {
            // Вычисляем общее количество операций
            const totalOps = i + 1 + (n - 2 * i);
            // Обновляем результат, если нашли лучший вариант
            if (totalOps < operations) {
                operations = totalOps;
            }
        }
    }
    
    console.log('Минимальное количество операций: ${operations}');
    readline.close();
});
