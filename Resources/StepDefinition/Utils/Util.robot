*** Settings ***
Documentation   This step file contains the reusable keywords for e.g. set download directory etc


*** Keywords ***
set download directory path suite variable
    [Arguments]  ${downloadPath}
    [Documentation]  This keyword will set the temporary download directory
    ${fullPath}=  create absolute folder directory path  ${downloadPath}
    Set Suite Variable  ${downloadDirectoryPath}  ${fullPath}
    RETURN  ${downloadDirectoryPath}

create absolute folder directory path
    [Arguments]  ${filePath}
    [Documentation]  This keyword will set the final download directory
    ${basePath}=  get file path
    ${fullPath}=  Set Variable  ${basePath}${filePath}
    RETURN  ${fullPath}
