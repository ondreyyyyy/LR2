section .data
    nums    dd  123, 90, 44
    nums_len equ ($ - nums) / 4
    newline db 10

section .bss
    buffer resb 12

section .text
    global _start

_start:
    mov     esi, nums            ; Указатель на массив
    mov     ecx, nums_len        ; Счетчик чисел
    mov     ebp, 1               ; Номер текущего числа (начинаем с 1)

process_number:
    push    rcx                  ; Сохраняем счетчик цикла
    push    rbp                  ; Сохраняем номер числа
    lodsd                        ; Загружаем число в eax
    push    rax                  ; Сохраняем исходное число
    
    ; Вычисляем модуль числа
    test    eax, eax
    jns     calc_sum_prod
    neg     eax

calc_sum_prod:
    xor     ebx, ebx             ; Сумма цифр
    mov     edi, 1               ; Произведение цифр (начальное значение 1)
    xor     edx, edx             ; Счетчик цифр (для случая 0)
    test    eax, eax
    jnz     digit_loop           ; Если не ноль, обрабатываем цифры
    
    ; Обработка нуля
    xor     ebx, ebx             ; Сумма = 0
    xor     edi, edi             ; Произведение = 0
    jmp     compare

digit_loop:
    xor     edx, edx
    mov     ecx, 10
    div     ecx                  ; eax = eax / 10, edx = остаток (цифра)
    
    add     ebx, edx             ; Добавляем цифру к сумме
    
    test    edi, edi             ; Проверяем, чтобы произведение не было 0
    jz      skip_mult            ; Если уже 0, не умножаем
    imul    edi, edx             ; Умножаем на цифру
skip_mult:
    
    test    eax, eax
    jnz     digit_loop           ; Повторяем, пока не 0

compare:
    cmp     ebx, edi
    jge     next_number          ; Пропускаем если сумма >= произведения
    
    ; Выводим номер числа
    pop     rax                  ; Убираем сохраненное число со стека
    pop     rbp                  ; Восстанавливаем номер числа
    push    rbp                  ; Сохраняем номер числа снова
    mov     eax, ebp             ; Загружаем номер числа для печати
    call    print_number
    jmp     next_number_clean

next_number:
    pop     rax                  ; Убираем сохраненное число со стека
    pop     rbp                  ; Восстанавливаем номер числа

next_number_clean:
    inc     ebp                  ; Увеличиваем номер числа
    pop     rcx                  ; Восстанавливаем счетчик
    loop    process_number       ; Переходим к следующему числу

exit:
    mov     eax, 60              ; sys_exit
    xor     edi, edi             ; Возвращаем 0
    syscall

; Функция для печати числа из eax
 print_number:
    ; 1. Подготовка буфера
    mov     edi, buffer + 11    ; Указатель на конец буфера (12 байт)
    mov     byte [edi], 0       ; Записываем нуль-терминатор ('\0')
    mov     ecx, 10             ; Основание системы (десятичная)

    ; 2. Обработка знака (если число отрицательное)
    test    eax, eax            ; Проверяем знак числа
    jns     convert_loop        ; Если положительное, пропускаем
    neg     eax                 ; Делаем число положительным
    push    rax                 ; Сохраняем число
    mov     al, '-'             ; Загружаем символ '-'
    call    print_char          ; Печатаем минус
    pop     rax                 ; Восстанавливаем число

    ; 3. Преобразование числа в строку (по цифрам)
convert_loop:
    xor     edx, edx            ; Обнуляем edx перед делением
    div     ecx                 ; Делим eax на 10: eax = частное, edx = остаток (цифра)
    add     dl, '0'             ; Преобразуем цифру в символ (ASCII)
    dec     edi                 ; Двигаем указатель буфера назад
    mov     [edi], dl           ; Сохраняем символ в буфер
    test    eax, eax            ; Осталось ли что-то?
    jnz     convert_loop        ; Если да, продолжаем

    ; 4. Вычисление длины строки
    mov     esi, edi            ; esi = начало строки (после преобразования)
    mov     edx, buffer + 12    ; edx = конец буфера
    sub     edx, esi            ; edx = длина строки (edx - esi)
    ; 5. Вывод строки
    mov     eax, 1              ; sys_write (код 1)
    mov     edi, 1              ; stdout (дескриптор 1)
    syscall                     ; Вызываем ядро

    ; 6. Вывод перевода строки ('\n')
    mov     eax, 1              ; sys_write
    mov     edi, 1              ; stdout
    mov     rsi, newline        ; Указатель на символ '\n'
    mov     edx, 1              ; Длина 1 байт
    syscall

    ret                         ; Возврат из функции
