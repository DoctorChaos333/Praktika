# Praktika

Написание сценариев на robot-framework.

# Установка библиотек

Создадим и активируем виртуальное окружение командами. Делать это нужно в директории, где хранится сам файл test.robot.
Для этого откроем эту папку в терминале:

<img width="1276" height="799" alt="image" src="https://github.com/user-attachments/assets/da21400d-37fa-4051-a8d9-e587c237f7c7" />


И введем туда данные команды:

1) Создание виртуального окружения "venv":

```
python3 -m venv venv
```

2) Активация виртуального окружения:
```
source venv/bin/activate
```
*Виртуальное окружение нужно создавать для того, чтобы не забивать корневую папку Python лишними библиотеками, а хранить их в самом проекте.*

Надпись `(venv)` говорит нам о том, что виртуальное окружение активировалось:

<img width="641" height="432" alt="image" src="https://github.com/user-attachments/assets/1514a336-bbb2-4002-b946-845e71e26ee3" />

Теперь установим необходимые зависимости с помощью команды:
```
pip install -r requirements.txt
```
Запуск программы:
```
robot test.robot
```


# Работа с результатами тестов

Вся информация хранится в файлах `report.html` и `log.html`, которые можно открыть в браузере. Пример `log.html`:

<img width="1284" height="882" alt="image" src="https://github.com/user-attachments/assets/0afb66d7-39d1-46eb-835a-f79a82e2cce0" />



## Тест №1 - проверка конфигурационного файла
<details>
<summary> 🔧 Описание работы теста</summary>

```
Проверить наличие конфигурационного файла
    [Tags]      Проверить наличие конфигурационного файла
    File Should Exist    ${FILE_PATH}   msg=Конфигурационный файл не найден по пути: ${FILE_PATH}
```
`Tags` - это строка, которая будет выводиться в логах `log.html` и `report.html`.

`msg` - сообщение, если файл не найден.

`File Should Exist` - ключевое выражение фреймворка `robotframework`, которая показывает, существует ли файл по пути `FILE_PATH`.

В данном случае `FILE_PATH` указывает на файл `some_script.txt` в папке `some_file`:
```
${FILE_PATH}        ${CURDIR}${/}some_file${/}some_script.txt
```
</details>

<details>
<summary>✅ Успех</summary>

Если файл существует, то в `log.html` мы увидим результат выполнения теста: 
```
Status: PASS
```

<img width="1245" height="248" alt="image" src="https://github.com/user-attachments/assets/3f4cb11a-1ecf-448f-b770-72d3e641797b" />

    
</details>

<details>
<summary>❌ Провал</summary>

В ином случае мы увидим:
```
Status: Fail
Message: Конфигурационный файл не найден
```

<img width="1228" height="220" alt="image" src="https://github.com/user-attachments/assets/af7650f4-c255-4d3b-bce9-b82418c7126b" />


</details>

## Тест №2 - проверка обязательной строки в конфигурационном файле
<details>
<summary> 🔧 Описание работы теста</summary>

```
Проверить наличие обязательной строки в файле
    [Tags]      Проверить наличие строки в файле
    ${content}=    Get File    ${FILE_PATH}    encoding_errors=ignore
    Should Contain    ${content}    ${FILE_PATTERN}     msg=Строка '${FILE_PATTERN}' не найдена в файле!
```

Программа читает файл `FILE_PATH` с помощью функции `Get File` и записывает в переменную `content`. 

`Should Contain` - функция `robotframework`, которая показывает, присутствует ли строка `FILE_PATTERN` в `content`. 

`msg` - сообщение, если данная строка отсутствует в файле.
</details>

<details>
<summary>✅ Успех</summary>

Если строка существует, то мы увидим:

```
Status: PASS
```
<img width="1215" height="158" alt="image" src="https://github.com/user-attachments/assets/bf67bf11-d593-4469-80ac-7ee14187fd01" />

</details>

<details>
<summary>❌ Провал</summary>

В ином случае:

```
Status: Fail
Message: Строка не найдена в файле!
```
<img width="1225" height="254" alt="image" src="https://github.com/user-attachments/assets/d9e199a1-1195-4448-8ceb-8f1f96229f69" />

</details>

## Тест №3 - проверка операционной системы
<details>
<summary>🔧 Описание работы теста</summary>

```
Проверить ОС
    [Tags]      Проверить ОС
    ${os}=    Evaluate    os.name    os
    Run Keyword If    '${os}' == 'nt'    Log    Windows
    ...     ELSE IF    '${os}' == 'posix'    Log    Linux/Unix
```

С помощью ключевого слова `Evaluate` мы можем использовать выражение `os.name` из языка `Python`, чтобы получить значение системной переменной `os`. Значение `nt` - присуще ОС Windows, а `posix` - ОС Linux или Unix. 

`Run Keyword If ... ELSE IF ...` - выражение для проверки условий в `robotframework`.
</details>

<details>
<summary>✅ Результат</summary>

Пример работы теста:

<img width="1224" height="226" alt="image" src="https://github.com/user-attachments/assets/64506915-2421-42f6-9ed5-69e4762dae28" />

</details>

## Тест №4 - проверка выполнения команды Linux
<details>
<summary>🔧 Описание работы теста</summary>

```
Пример выполнения команды Linux
    ${result}=    Выполнить команду и проверить    echo "Hello"    0
    Log    Результат: ${result}
```
Здесь мы вызываем функцию `Выполнить команду и проверить`. Аргументы функции:
1) Функция `echo` с аргументом `"Hello"`
2) `0` - стандартный вывод выполнения функции в Linux


Реализация функции `Выполнить команду и проверить`:
```
Выполнить команду и проверить
    [Arguments]    ${command}=    ${expected_rc}=0
    ${rc}    ${output}=    Run And Return Rc And Output    ${command}
    Should Be Equal As Integers    ${rc}    ${expected_rc}
    ...    msg=Команда: ${command} | Код: ${rc} (ожидалось ${expected_rc}) | Вывод: ${output}
    [RETURN]    ${output}
```
В качестве аргументов `Arguments` выступает команда `command` и ожидаемое значение `expected_rc` - результат выполнения этой команды. `expected_rc` по умолчанию равно `0`.

С помощью ключевого выражения `Run And Return Rc And Output` мы выполняем команду `command` и записывает возвращенный код и вывод работы функции в переменные `rc` и `output` соответственно.

Ключевое выражение `Should Be Equal As Integers` сравнивает возвращенный код `rc` с ожидаемым `expected_rc` и возвращает сообщение `msg`, если они не равны между собой.

</details>

<details>
<summary>✅ Успех</summary>

Подадим в тест команду `echo "Hello` и ожидаемый код `0`:


Мы видим, что в логе вывело:

```
Результат: Hello
```

<img width="1223" height="220" alt="image" src="https://github.com/user-attachments/assets/42ccdfc6-13cd-4811-b100-a86d3b818107" />
</details>

<details>
<summary>❌ Провал</summary>

Если же мы подадим в качестве `expected_rc` = `1`, то увидим:

```
Status: FAIL
Message: Команда: echo "Hello" | Код: 0 (ожидалось 1) | Вывод: "Hello" : 0 != 1
```

<img width="1218" height="406" alt="image" src="https://github.com/user-attachments/assets/eb0ae6fe-fc48-4aa0-9fab-6ad370dfcafe" />

</details>
