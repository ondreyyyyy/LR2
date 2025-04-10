function minOperations(input: string): number {
    const n = input.length;
    let operations = n;
    
    for (let i = 1; i <= Math.floor(n / 2); i++) {
        if (input.substr(0, i) === input.substr(i, i)) {
            const totalOps = i + 1 + (n - 2 * i);
            if (totalOps < operations) {
                operations = totalOps;
            }
        }
    }
    
    return operations;
}

// В браузере используем prompt() для ввода
const userInput = prompt('Введите строку для вычисления минимальных операций:') || "";
console.log('Результат: ${minOperations(userInput)}');
