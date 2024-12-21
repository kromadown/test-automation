*** Settings ***
Documentation  This file contains all the element IDs that are shared across multiple test scripts


*** Variables ***
##QR Code Generator
${QRCodeGeneratorHeader}      //div[@id="header"]
${ddlContents}                //td[text()='Contents']/following-sibling::td/select[@class="gwt-ListBox"]
${textContentsInputArea}      //textarea[@class="gwt-TextArea required"]
${ddlBarcodeSize}             //td[text()='Barcode size']/following-sibling::td/select[@class="gwt-ListBox"]
${ddlErrorCorrection}         //td[text()='Error correction']/following-sibling::td/select[@class="gwt-ListBox"]
${ddlCharEncoding}            //td[text()='Character encoding']/following-sibling::td/select[@class="gwt-ListBox"]
${buttonGenerate}             //button[@class="gwt-Button"]
${qrCodeImage}                //div[@id="innerresult"]/img

##QR Code Decoder
${btnChooseFile}              //input[@id="qrcode"]
${btnSubmitFile}              //button[contains(.,"Submit")]
${txtDecodedArea}             //textarea[@id="decoded"]

## File Directories
${filePath_final}  ${/}TestSuite${/}QRCodeTest${/}File${/}