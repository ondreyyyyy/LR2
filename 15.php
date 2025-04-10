<?php
function is_valid_char($c) {
    return ($c >= 'a' && $c <= 'z') || ($c >= '0' && $c <= '9') || $c == '.';
}

function is_valid_username($username) {
    if (strlen($username) < 6 || strlen($username) > 30) {
        fwrite(STDERR, "Ошибка: Имя пользователя должно быть от 6 до 30 символов.\n");
        return false;
    }
    
    if ($username[0] == '.' || $username[strlen($username)-1] == '.') {
        fwrite(STDERR, "Ошибка: Имя пользователя не может начинаться или заканчиваться точкой.\n");
        return false;
    }
    
    $prevIsDot = false;
    for ($i = 0; $i < strlen($username); $i++) {
        $c = $username[$i];
        if (!is_valid_char($c)) {
            fwrite(STDERR, "Ошибка: Недопустимый символ '$c' в имени пользователя.\n");
            return false;
        }
        
        if ($c == '.') {
            if ($prevIsDot) {
                fwrite(STDERR, "Ошибка: Не может быть двух точек подряд.\n");
                return false;
            }
            $prevIsDot = true;
        } else {
            $prevIsDot = false;
        }
    }
    
    return true;
}

function process_email($email) {
    $atPos = strpos($email, '@');
    if ($atPos === false) {
        fwrite(STDERR, "Ошибка: Отсутствует символ '@' в email.\n");
        return "";
    }
    
    $username = substr($email, 0, $atPos);
    $domain = substr($email, $atPos);
    
    $username = strtolower($username);
    
    $plusPos = strpos($username, '+');
    if ($plusPos !== false) {
        $username = substr($username, 0, $plusPos);
    }
    
    if (!is_valid_username($username)) {
        return "";
    }
    
    return $username . $domain;
}

$uniqueEmails = [];
echo "Введите email-адреса через запятую: ";
$input = trim(fgets(STDIN));

$emails = explode(',', $input);
foreach ($emails as $rawEmail) {
    $email = trim($rawEmail);
    if (!empty($email)) {
        $processed = process_email($email);
        if (!empty($processed)) {
            $uniqueEmails[$processed] = true;
        }
    }
}

echo "Количество уникальных адресов: " . count($uniqueEmails) . "\n";
?>
