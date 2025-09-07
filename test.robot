*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary
Suite Teardown  Открыть отчет в браузере

*** Variables ***
${FILE_PATH}        ${CURDIR}${/}some_file${/}some_script.txt
${FILE_PATTERN}     HelloWorld!
${BROWSER}          firefox
${REPORT_PATH}      ${OUTPUT_DIR}${/}report.html

*** Keywords ***
Открыть отчет в браузере
    Wait Until Keyword Succeeds    30s    1s    File Should Exist    ${REPORT_PATH}

    ${file_url}=    Set Variable    file://${REPORT_PATH.replace('\\', '/')}

    Run Keyword If    os.path.exists($REPORT_PATH)    Run Keywords
    ...    Open Browser    ${file_url}    ${BROWSER}    AND
    ...    Wait Until Page Contains    All Tests    30s    AND
    ...    Sleep    3s
    ...    ELSE
    ...    Log    Отчет не найден: ${REPORT_PATH}

Выполнить команду и проверить
    [Arguments]    ${command}=    ${expected_rc}=0
    ${rc}    ${output}=    Run And Return Rc And Output    ${command}
    Should Be Equal As Integers    ${rc}    ${expected_rc}
    ...    msg=Команда: ${command} | Код: ${rc} (ожидалось ${expected_rc}) | Вывод: ${output}
    [RETURN]    ${output}

*** Test Cases ***
Проверить наличие конфигурационного файла
    [Tags]      Проверить наличие конфигурационного файла
    File Should Exist    ${FILE_PATH}   msg=Конфигурационный файл не найден по пути: ${FILE_PATH}

Проверить наличие обязательной строки в файле
    [Tags]      Проверить наличие строки в файле
    ${content}=    Get File    ${FILE_PATH}    encoding_errors=ignore
    Should Contain    ${content}    ${FILE_PATTERN}     msg=Строка '${FILE_PATTERN}' не найдена в файле!

Проверить ОС
    [Tags]      Проверить ОС
    ${os}=    Evaluate    os.name    os
    Run Keyword If    '${os}' == 'nt'    Log    Windows
    ...     ELSE IF    '${os}' == 'posix'    Log    Linux/Unix

Пример выполнения команды Linux
    ${result}=    Выполнить команду и проверить    echo "Hello"    0
    Log    Результат: ${result}