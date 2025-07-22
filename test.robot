*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary
Suite Teardown  Открыть отчет в браузере

*** Variables ***
${FILE_PATH}        ${CURDIR}${/}some_file${/}some_script.txt
${FILE_PATTERN}     HelloWorld!
${BROWSER}          chrome
${DRIVER_PATH}      ${CURDIR}${/}chromedriver-win64${/}chromedriver.exe

*** Keywords ***
Открыть отчет в браузере
    ${report_path}=    Set Variable    ${OUTPUT_DIR}${/}report.html
    ${file_url}=       Set Variable    file:///${report_path.replace('\\', '/')}

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --allow-file-access-from-files
    Create Webdriver    Chrome    options=${options}    executable_path=${DRIVER_PATH}
    Go To    ${file_url}
    Maximize Browser Window
    Wait Until Page Contains    All Tests    30s
    Sleep    10 minutes

Выполнить команду и проверить
    [Arguments]    ${command}    ${expected_rc}=0
    ${rc}    ${output}=    Run And Return Rc And Output    ${command}
    Should Be Equal As Integers    ${rc}    ${expected_rc}      msg=Команда: ${command} | Код: ${rc} (ожидалось ${expected_rc}) | Вывод: ${output}
    [Return]    ${output}

*** Test Cases ***

Проверить наличие конфигурационного файла
    [Tags]      Проверить наличие конфигурационного файла
    File Should Exist    ${FILE_PATH}   msg=Конфигурационный файл не найден по пути: ${FILE_PATH}

Проверить наличие обязательной строки в файле
    [Tags]      Проверить наличие строки в файле
    ${content}=    Get File    ${FILE_PATH}    encoding_errors=ignore
    Should Contain    ${content}    ${FILE_PATTERN}     msg=Строка '${FILE_PATTERN}' не найдена в файле!

Проверить код возврата Linux
    [Tags]      Проверить код возврата Linux
    Выполнить команду и проверить       ls -l /tmp