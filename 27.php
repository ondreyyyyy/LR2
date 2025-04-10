<?php
// Функция вычисления суммы и произведения цифр числа
// Принимает число и возвращает результат через параметры по ссылке
function calculateSumAndProduct($num, &$sum, &$product) {
    $sum = 0;
    $product = 1;
    $n = abs($num); // Работаем с абсолютным значением
    
    while ($n != 0) {
        $digit = $n % 10;
        $sum += $digit;
        $product *= $digit;
        $n = (int)($n / 10);
    }
}

// Чтение количества чисел
$n = (int)fgets(STDIN);

// Обработка каждого числа
for ($i = 1; $i <= $n; $i++) {
    $number = (int)fgets(STDIN);
    
    $sum = 0;
    $product = 0;
    calculateSumAndProduct($number, $sum, $product);
    
    if ($sum < $product) {
        echo $i, ' ';
    }
}

echo "\n";
?>
