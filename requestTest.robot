*** Settings ***
Documentation    Suite description
Library    RequestsLibrary

*** Test Cases ***
Get requests
    Create Session    jenkins-session    https://www.jenkins.io    disable_warnings=True
    ${response}=    Get Request    jenkins-session    /site.webmanifest
    Request Should Be Successful     ${response}
    ${response_json}=    to json    ${response.content}
    log to console    ${response_json}
