function is_valid_char(c: string): boolean {
    return (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9') || c === '.';
}

function is_valid_username(username: string): boolean {
    if (username.length < 6 || username.length > 30) {
        console.error("Ошибка: Имя пользователя должно быть от 6 до 30 символов.");
        return false;
    }
    
    if (username[0] === '.' || username[username.length - 1] === '.') {
        console.error("Ошибка: Имя пользователя не может начинаться или заканчиваться точкой.");
        return false;
    }
    
    let prev_is_dot = false;
    for (const c of username) {
        if (!is_valid_char(c)) {
            console.error(`Ошибка: Недопустимый символ '${c}' в имени пользователя.`);
            return false;
        }
        
        if (c === '.') {
            if (prev_is_dot) {
                console.error("Ошибка: Не может быть двух точек подряд.");
                return false;
            }
            prev_is_dot = true;
        } else {
            prev_is_dot = false;
        }
    }
    
    return true;
}

function process_email(email: string): string {
    const at_pos = email.indexOf('@');
    if (at_pos === -1) {
        console.error("Ошибка: Отсутствует символ '@' в email.");
        return "";
    }
    
    let username = email.substring(0, at_pos).toLowerCase();
    const domain = email.substring(at_pos);
    
    const plus_pos = username.indexOf('+');
    if (plus_pos !== -1) {
        username = username.substring(0, plus_pos);
    }
    
    if (!is_valid_username(username)) {
        return "";
    }
    
    return username + domain;
}

function main() {
    const unique_emails = new Set<string>();
    const input = prompt("Введите email-адреса через запятую:") || "";
    
    input.split(',').forEach(raw_email => {
        const email = raw_email.trim();
        if (email) {
            const processed = process_email(email);
            if (processed) {
                unique_emails.add(processed);
            }
        }
    });
    
    console.log(`Количество уникальных адресов: ${unique_emails.size}`);
}

main();
