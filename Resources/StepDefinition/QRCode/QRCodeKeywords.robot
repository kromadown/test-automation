*** Settings ***
Documentation   This file contains the step definition for all search-related keywords
Resource        ../../StepDefinition/Utils/ScenarioLogs.robot
Resource        ../../POM/POM_All_ID_Params.robot
Variables       ../../POM/POM_Variables.yaml
Variables       ../../POM/POM_Pages.yaml


*** Keywords ***
that user has navigate to the QR Code Generator page
    [Arguments]  ${element}=${QRCodeGeneratorHeader}
    Log To Console  that user has navigate to the QR Code Generator page
    Wait Until Page Contains Element  ${element}  timeout=${expectedTimeout}
    Wait Until Element Is Visible  ${element}  timeout=${expectedTimeout}

select the contents
    [Arguments]  ${contentsValue}
    Log To Console  select the contents
    Select From List By Value  ${ddlContents}  ${contentsValue}

fill in the form for Text contents
    [Arguments]  ${textContent}
    Wait Until Page Contains Element  ${textContentsInputArea}  timeout=${expectedTimeout}
    Wait Until Element Is Visible  ${textContentsInputArea}  timeout=${expectedTimeout}
    Input Text  ${textContentsInputArea}  ${textContent}

select the Barcode size
    [Arguments]  ${barcodeSize}
    Log To Console  select the barcode size
    Select From List By Value  ${ddlBarcodeSize}  ${barcodeSize}

select the Error correction
    [Arguments]  ${errorCorrection}
    Log To Console  select the error correction
    Select From List By Value  ${ddlErrorCorrection}  ${errorCorrection}

select the Character encoding
    [Arguments]  ${charEncoding}
    Log To Console  select the Character encoding
    Select From List By Value  ${ddlCharEncoding}  ${charEncoding}

click on the Generate button
    Log To Console  click on the Generate button
    Click Element  ${buttonGenerate}

the QR Code should be generated
    Log To Console  the QR Code should be generated
    Wait Until Page Contains Element  ${qrCodeImage}  timeout=${expectedTimeout}
    Wait Until Element Is Visible  ${qrCodeImage}  timeout=${expectedTimeout}
    ${isGenerated}=  Get Element Attribute  ${qrCodeImage}  src
    Should Not Be Empty  ${isGenerated}
    Set Suite Variable  ${qrCodeGeneratedURL}  ${isGenerated}

click on the Download button
    [Arguments]  ${fileName}  ${qrCodeGeneratedURL}
    Run Process  curl  -o  ${fileName}  ${qrCodeGeneratedURL}

the QR Code should be downloaded
    [Arguments]  ${filePath}  ${fileName}
    Log To Console  the QR Code should be downloaded
    ${fileList}=  List Files In Directory  ${filePath}
    List Should Contain Value  ${fileList}  ${fileName}

that user has navigate to the QR Decoder page
    Log To Console  that user has navigate to the QR Decoder page
    Go To  ${qrDecoderURL}
    Wait Until Page Contains Element  ${btnChooseFile}  timeout=${expectedTimeout}
    Wait Until Element Is Visible  ${btnChooseFile}  timeout=${expectedTimeout}

upload the QR Code
    [Arguments]  ${filePath}
    Log To Console  upload the QR Code
    Choose File  ${btnChooseFile}  ${filePath}

click on the Submit button
    Log To Console  click on the Submit button
    Click Element  ${btnSubmitFile}

the QR Code will be decoded
    [Arguments]  ${expected}
    Log To Console  the QR Code will be decoded
    ${result}=  Run Keyword And Return Status  Wait Until Element Does Not Contain  ${txtDecodedArea}  ${loading}  timeout=5 min
    IF  ${result}
        ${getDecoded}=  Get Text  ${txtDecodedArea}
        Should Be Equal As Strings  ${getDecoded}  ${expected}
    END
