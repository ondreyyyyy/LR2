use std::collections::HashSet;
use std::io;

fn is_valid_char(c: char) -> bool {
    c.is_ascii_lowercase() || c.is_ascii_digit() || c == '.'
}

fn is_valid_username(username: &str) -> bool {
    if username.len() < 6 || username.len() > 30 {
        eprintln!("Ошибка: Имя пользователя должно быть от 6 до 30 символов.");
        return false;
    }
    
    if username.starts_with('.') || username.ends_with('.') {
        eprintln!("Ошибка: Имя пользователя не может начинаться или заканчиваться точкой.");
        return false;
    }
    
    let mut prev_is_dot = false;
    for c in username.chars() {
        if !is_valid_char(c) {
            eprintln!("Ошибка: Недопустимый символ '{}' в имени пользователя.", c);
            return false;
        }
        
        if c == '.' {
            if prev_is_dot {
                eprintln!("Ошибка: Не может быть двух точек подряд.");
                return false;
            }
            prev_is_dot = true;
        } else {
            prev_is_dot = false;
        }
    }
    
    true
}

fn process_email(email: &str) -> String {
    let at_pos = match email.find('@') {
        Some(pos) => pos,
        None => {
            eprintln!("Ошибка: Отсутствует символ '@' в email.");
            return String::new();
        }
    };
    
    let (username, domain) = email.split_at(at_pos);
    let mut username = username.to_lowercase();
    
    if let Some(plus_pos) = username.find('+') {
        username.truncate(plus_pos);
    }
    
    if !is_valid_username(&username) {
        return String::new();
    }
    
    username + domain
}

fn main() {
    let mut unique_emails = HashSet::new();
    println!("Введите email-адреса через запятую: ");
    
    let mut input = String::new();
    io::stdin().read_line(&mut input).expect("Ошибка чтения ввода");
    
    for raw_email in input.trim().split(',') {
        let email = raw_email.trim();
        if !email.is_empty() {
            let processed = process_email(email);
            if !processed.is_empty() {
                unique_emails.insert(processed);
            }
        }
    }
    
    println!("Количество уникальных адресов: {}", unique_emails.len());
}
