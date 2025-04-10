import Foundation

func is_valid_char(_ c: Character) -> Bool {
    return ("a"..."z").contains(c) || ("0"..."9").contains(c) || c == "."
}

func is_valid_username(_ username: String) -> Bool {
    if username.count < 6 || username.count > 30 {
        print("Ошибка: Имя пользователя должно быть от 6 до 30 символов.", to: &stderr)
        return false
    }
    
    if username.first == "." || username.last == "." {
        print("Ошибка: Имя пользователя не может начинаться или заканчиваться точкой.", to: &stderr)
        return false
    }
    
    var prev_is_dot = false
    for c in username {
        if !is_valid_char(c) {
            print("Ошибка: Недопустимый символ '\(c)' в имени пользователя.", to: &stderr)
            return false
        }
        
        if c == "." {
            if prev_is_dot {
                print("Ошибка: Не может быть двух точек подряд.", to: &stderr)
                return false
            }
            prev_is_dot = true
        } else {
            prev_is_dot = false
        }
    }
    
    return true
}

func process_email(_ email: String) -> String {
    guard let at_pos = email.firstIndex(of: "@") else {
        print("Ошибка: Отсутствует символ '@' в email.", to: &stderr)
        return ""
    }
    
    var username = String(email[..<at_pos]).lowercased()
    let domain = String(email[at_pos...])
    
    if let plus_pos = username.firstIndex(of: "+") {
        username = String(username[..<plus_pos])
    }
    
    if !is_valid_username(username) {
        return ""
    }
    
    return username + domain
}

func main() {
    var unique_emails = Set<String>()
    print("Введите email-адреса через запятую: ", terminator: "")
    
    guard let input = readLine() else { return }
    
    for raw_email in input.components(separatedBy: ",") {
        let email = raw_email.trimmingCharacters(in: .whitespaces)
        if !email.isEmpty {
            let processed = process_email(email)
            if !processed.isEmpty {
                unique_emails.insert(processed)
            }
        }
    }
    
    print("Количество уникальных адресов: \(unique_emails.count)")
}

var stderr = FileHandle.standardError
extension FileHandle: TextOutputStream {
    public func write(_ string: String) {
        write(Data(string.utf8))
    }
}

main()
