*** Settings ***
Library  SeleniumLibrary

*** Variables  ***
${PAGE} =   YOUR-BUNDLE-URL  # Bundle redeem URL, i.e. https://itch.io/bundle/download/YOUR-UNIQUE-URL
${BROWSER} =  BROWSER-OF-CHOICE  # Any supported by SeleniumLibrary, see https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Open%20Browser; you'll need the selenium browser driver in your PATH
${AUTH} =  AUTH-METHOD  # Either github or itchio, github won't work with 2FA
${USERNAME} =  YOUR-USERNAME
${PASSWORD} =  YOUR-PASSWORD


*** Test Case ***
Redeem Bundle
    Open Browser  ${PAGE}  ${BROWSER}
    Click Element  //a[.="Log in"]
    IF    "${AUTH}" == "github"
        Click Button  //button[@class='button outline github_login_btn']
        Input Text  //input[@id='login_field']  ${USERNAME}
        Input Text  //input[@id='password']  ${PASSWORD}
        Click Element  //input[@name='commit']
    ELSE IF    "${AUTH}" == "itchio"
        Input Text  //input[@name='username']  ${USERNAME}
        Input Text  //input[@name='password']  ${PASSWORD}
        Click Button  //button[.='Log in']
    END
    Wait Until Page Contains  My feed
    Go To  ${PAGE}
    ${pages} =  Get Text  //span[@class="pager_label"]/a
    FOR    ${counter}    IN RANGE    1    ${pages}+1
        Go To  ${PAGE}?page=${counter}
        FOR    ${index}    IN RANGE    0    30
            ${status}  ${webelements} =  Run Keyword And Ignore Error  Get WebElement  //button[@value="claim"]
            Exit For Loop IF    "${status}" == "FAIL"
            Run Keyword And Continue on Failure  Click Element    ${webelements}
            Wait Until Page Contains  Downloads not starting?
            Go Back
        END
    END
    Close Browser