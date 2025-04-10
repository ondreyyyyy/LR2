fun main() {
    val uniqueEmails = mutableSetOf<String>()
    println("Введите email-адреса через запятую: ")
    val input = readLine() ?: ""
    
    input.split(",").forEach { rawEmail ->
        val email = rawEmail.trim()
        if (email.isNotEmpty()) {
            val processed = processEmail(email)
            if (processed.isNotEmpty()) {
                uniqueEmails.add(processed)
            }
        }
    }
    
    println("Количество уникальных адресов: ${uniqueEmails.size}")
}

fun is_valid_char(c: Char): Boolean = c in 'a'..'z' || c in '0'..'9' || c == '.'

fun is_valid_username(username: String): Boolean {
    if (username.length < 6 || username.length > 30) {
        System.err.println("Ошибка: Имя пользователя должно быть от 6 до 30 символов.")
        return false
    }
    
    if (username.first() == '.' || username.last() == '.') {
        System.err.println("Ошибка: Имя пользователя не может начинаться или заканчиваться точкой.")
        return false
    }
    
    var prevIsDot = false
    for (c in username) {
        if (!is_valid_char(c)) {
            System.err.println("Ошибка: Недопустимый символ '$c' в имени пользователя.")
            return false
        }
        
        if (c == '.') {
            if (prevIsDot) {
                System.err.println("Ошибка: Не может быть двух точек подряд.")
                return false
            }
            prevIsDot = true
        } else {
            prevIsDot = false
        }
    }
    
    return true
}

fun processEmail(email: String): String {
    val atPos = email.indexOf('@')
    if (atPos == -1) {
        System.err.println("Ошибка: Отсутствует символ '@' в email.")
        return ""
    }
    
    var username = email.substring(0, atPos).lowercase()
    val domain = email.substring(atPos)
    
    val plusPos = username.indexOf('+')
    if (plusPos != -1) {
        username = username.substring(0, plusPos)
    }
    
    if (!is_valid_username(username)) {
        return ""
    }
    
    return username + domain
}
