# Praktika

Написание сценариев на robot-framework.

# Установка библиотек

Создадим и активируем виртуальное окружение командами. Делать это нужно в директории, где хранится сам файл test.robot.
Для этого откроем эту папку в терминале:
<img width="1280" height="797" alt="image" src="https://github.com/user-attachments/assets/a582e248-ec5f-4b96-a8db-296573dfc7e7" />
И введем туда данные команды:
1) Создание виртуального окружения "venv":
```
python3 -m venv venv
```
2) Активируем виртуальное окружение:
```
source venv/bin/activate
```
*Виртуальное окружение нужно создавать для того, чтобы не забивать корневую папку Python лишними библиотеками, а хранить в самом проекте*

Теперь установим необходимые зависимости с помощью команды:
```
pip install -r requirements.txt
```
Запуск программы
```
robot --outputdir results --log report.html test.robot
```

# Работа с результатами тестов

Вся информация хранится в файлах `report.html` и `log.html`, которые можно открыть в браузере. Пример `log.html`:

<img width="1911" height="631" alt="image" src="https://github.com/user-attachments/assets/277c7be8-bea1-490f-ab4a-4a21fe33bbf9" />

## Тест №1 - проверка конфигурационного файла

```
Проверить наличие конфигурационного файла
    [Tags]      Проверить наличие конфигурационного файла
    File Should Exist    ${FILE_PATH}   msg=Конфигурационный файл не найден по пути: ${FILE_PATH}
```
`Tags` - это строка, которая будет выводиться в логах `log.html` и `report.html`.

`msg` - сообщение, если файл не найден.

`File Should Exist` - функция фреймворка `robotframework`, которая показывает, существует ли файл по пути `FILE_PATH`.

В данном случае `FILE_PATH` указывает на файл `some_script.txt` в папке `some_file`:
```
${FILE_PATH}        ${CURDIR}${/}some_file${/}some_script.txt
```
Если файл существует, то в `log.html` мы увидим результат выполнения программы: 
```
Status: PASS
```

<img width="1817" height="120" alt="image" src="https://github.com/user-attachments/assets/59aebfa5-6513-4b0f-849d-8073216a5ef0" />

В ином случае мы увидим:
```
Status: Fail
Message: Конфигурационный файл не найден
```

<img width="1861" height="193" alt="image" src="https://github.com/user-attachments/assets/5e6628ce-006a-4cda-8a46-46d4c7ce9683" />


## Тест №2 - проверка обязательной строки в конфигурационном файле

```
Проверить наличие обязательной строки в файле
    [Tags]      Проверить наличие строки в файле
    ${content}=    Get File    ${FILE_PATH}    encoding_errors=ignore
    Should Contain    ${content}    ${FILE_PATTERN}     msg=Строка '${FILE_PATTERN}' не найдена в файле!
```

Программа читает файл `FILE_PATH` с помощью функции `Get File` и записывает в переменную `content`. 

`Should Contain` - функция `robotframework`, которая показывает, присутствует ли строка `FILE_PATTERN` в `content`. 

`msg` - сообщение, если данная строка отсутствует в файле.

Если строка существует, то мы увидим:
```
Status: PASS
```
<img width="1872" height="139" alt="image" src="https://github.com/user-attachments/assets/0c32a499-1018-4338-a5d8-040e154babac" />

В ином случае:
```
Status: Fail
Message: Строка не найдена в файле!
```
<img width="1872" height="210" alt="image" src="https://github.com/user-attachments/assets/68dacda5-6471-45d6-87d8-3596f0470f3a" />
