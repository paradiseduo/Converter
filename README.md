# Converter

## Convert IPA to Mac App (M1 SIP disabled)
requirements:
- decrypted app with [appdecrypt](https://github.com/paradiseduo/appdecrypt) or other tools
- An Apple Developer Account with "teamID.com.*" mobileprovision
- https://github.com/AloneMonkey/MonkeyDev or https://github.com/DanTheMan827/ios-app-signer

## How to use
```bash
> git clone https://github.com/paradiseduo/Converter.git
> chmod +x build-macOS_arm.sh.sh
> ./build-macOS_arm.sh
> ./converter
Version 1.0

converter is a tool to conver iOS application to macOS application and run with M1.

Examples:
    mac:
        converter Test.ipa

USAGE: converter ipa_path

ARGUMENTS:
  <ipa_path>        The ipa file path.

OPTIONS:
  -h, --help              Show help information.
```

### Example
You must use a Decrypted IPA with developer codesign
```bash
> ./converter ~/Desktop/KingsRaid.ipa
Start converter /Users/minim1/Desktop/KingsRaid.ipa
Finish converter, you can found it in Launchpad(启动台)
```
