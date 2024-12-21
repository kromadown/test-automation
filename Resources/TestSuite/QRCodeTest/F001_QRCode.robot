*** Settings ***
Documentation   QR Code Generator and Decoder
Library         OperatingSystem
Library         Process
Library         Collections
Library         SeleniumLibrary
Library         ../../Lib/browserOptions.py
Library         ../../Lib/findFilePath.py
Resource        ../../StepDefinition/Authentication/Successful Login.robot
Resource        ../../POM/POM_All_ID_Params.robot
Resource        ../../StepDefinition/Utils/Util.robot
Resource        ../../StepDefinition/QRCode/QRCodeKeywords.robot
Suite Teardown  Close All Browsers


*** Variables ***
${textValue}                Text
${barcodeLargeValue}        350
${barcodeMediumValue}       230
${barcodeSmallValue}        120


*** Keywords ***
Download Setup
    [Documentation]  This keyword contains the pre-requisite (setup) step definition of the test scenario
    ${fullPath}=  create absolute folder directory path  ${filePath_final}
    Set Suite Variable  ${folderFilePath}  ${fullPath}
    Open Browser Page  ${qrGeneratorURL}  downloadPath=${folderFilePath}
    Set Selenium Speed	0.2 seconds


*** Test Cases ***
[TS01-TC01] Fill in the form
    [Documentation]  TS01  Generate QR Code
    [Setup]  Download Setup
    Given that user has navigate to the QR Code Generator page
    And select the contents  ${textValue}
    And fill in the form for Text contents  Test
    When click on the Generate button
    Then the QR Code should be generated
    Capture Page Screenshot

[TS01-TC02] Download QR Code
    [Documentation]  TS01  Generate QR Code
    Given that user has generated the QR Code
    When click on the Download button  ${folderFilePath}QRCode.png  ${qrCodeGeneratedURL}
    Then the QR Code should be downloaded  ${folderFilePath}  QRCode.png

[TS02-TC01] Upload QR Code
    [Documentation]  TS02  Decode the QR Code
    Given that user has navigate to the QR Decoder page
    And upload the QR Code  ${folderFilePath}QRCode.png
    When click on the Submit button
    Then the QR Code will be decoded  Test
