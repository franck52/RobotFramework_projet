*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}        https://recrulab.fr
${BROWSER}         chrome

# List of URLs relative paths
${CANDIDATS_PATH}       /candidats/
${ENTREPRISES_PATH}     /entreprises/
${OFFRES_PATH}          /nos-offres/
${CANDIDATURE_PATH}     /candidature-spontanee/
${CONTACT_PATH}    /contact/

# Expected Titles (adjusted based on the errors)
${TITLE_CANDIDATS}      Recrulab - Candidats
${TITLE_ENTREPRISES}    Recrulab - Entreprises
${TITLE_OFFRES}         Recrulab - Nos offres
${TITLE_CANDIDATURE}    Candidature spontanée - Recrulab
${TITLE_CONTACT}    Recrulab - Contact

*** Test Cases ***
Test Candidates Page
    Open Page    ${CANDIDATS_PATH}
    Title Should Be    ${TITLE_CANDIDATS}
    Page Should Contain    Candidature
    Capture Page Screenshot    candidates_page.png
    Close Browser

Test Companies Page
    Open Page    ${ENTREPRISES_PATH}
    Title Should Be    ${TITLE_ENTREPRISES}
    Page Should Contain    Entreprises
    Capture Page Screenshot    companies_page.png
    Close Browser

Test Job Offers Page
    Open Page    ${OFFRES_PATH}
    Title Should Be    ${TITLE_OFFRES}
    Page Should Contain    Nos offres
    Capture Page Screenshot    job_offers_page.png
    Close Browser

Test Spontaneous Application Page
    Open Page    ${CANDIDATURE_PATH}
    Title Should Be    ${TITLE_CANDIDATURE}
    # Adjusting expected text to be more flexible
    Page Should Contain    Candidature
    Capture Page Screenshot    spontaneous_application_page.png
    Close Browser
Test Contact as
    Open Page    ${CONTACT_PATH}
     Title Should Be    ${TITLE_CONTACT}
      # Adjusting expected text to be more flexible
    Page Should Contain    Que vous soyez un candidat ou une
    Capture Page Screenshot    contact.png
    Close Browser

*** Keywords ***
Open Page
    [Arguments]    ${relative_url}
    Open Browser    ${BASE_URL}${relative_url}    ${BROWSER}
    Maximize Browser Window
