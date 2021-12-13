<img src="https://i.imgur.com/haximPI.gif" alt="Leetscrape logo" align="right"/>

# Cueme

![](https://img.shields.io/badge/flutter-2.8-blue) ![](https://img.shields.io/badge/dart-2.15-blue)

An app to send a message to your desired contact via (currently) three platforms - WhatsApp, SMS, Email. Can be scheduled for later too). This is built on top of the [Cueme API](https://github.com/krispykalsi/cueme.git)

## ⚙ Installation
1. Make sure you have [Flutter](https://docs.flutter.dev/get-started/install) installed and configured properly. Verify by running the following command in shell.

    ```shell
    flutter doctor
    ```
2. Create a file named `.env.secret` in the project folder and copy the following data. Replace it with your key from [Alan AI](https://alan.app/)
    ```shell
    ALAN_SDK_AUTH_KEY=2bdb68d921cc2e956eca572e1d8b807a3e2338fdd0dc/stage
    ```
3. Download dependencies
    ```shell
    flutter pub get
    ```
3. Run the app
    ```shell
    flutter run main.dart
    ```

## 🗣 How to use Alan
1. Just press the alan button at the bottom and say "send a message/whatsapp/email to `<contact info>` on `<date>` at `<time>` 
2. Alan will ask for the message and any missing information he failed to catch.
3. Provide him with the required information and he'll cue the message for you.

**NOTE:** *There's more ways that Alan can take your input, try figuring them all out using the [script](https://github.com/krispykalsi/cueme-client/blob/main/alan_script.txt) we wrote for it as a challenge :D*
