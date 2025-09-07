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
