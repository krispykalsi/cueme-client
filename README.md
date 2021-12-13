# Welcome to Cueme
![](https://i.imgur.com/gUw7ANz.jpg)

Cueme is a unified messaging application that lets you mail, message, WhatsApp, contacts, everything on the same platform. It makes life easy, right? Wait, it's not all our app is being integrated with Alan voice SDK means you do not need to type at all; say Hello! to our app and go for it. On over that, it's not just an android app; our users have total liberty to use our android or web application.

## Inspiration

This is for the lazy people, who are not able to keep up with their existing reminders and would like personal attention from their friends and family or even, themselves. Although we have got our good ol'reminders, the impact of a personal message makes a difference. Having to be reminded on our daily-use social media platforms, in our opinion, would be a safer bet than our usual reminder apps. For instance, we are likely to pay more attention to a Whatsapp (or your choice of social-app) message than a reminder that we snoozed ten times already.

## What it does

Sends a message to your desired contact via (currently) three platforms - WhatsApp, SMS, Email. Can be scheduled for later too). This sounds simple but, imagine what it could do as a full-blown API. 

# Demo!
![](https://i.imgur.com/haximPI.gif) 

## Instructions

Cueme's interface is straightforward. You will be providing Email, Contact, and body(message), and if required to send a post message, you will be specifying the date and time. That's all; select your mode from SMS, Whatsapp, Email and hit Cue. A popup will acknowledge you, and you are all done.

## How to install
1. Install your flutter from https://docs.flutter.dev/get-started/install.
2. Get your Alan auth. Key from https://alan.app/ and save it in a file named ".env.secret" in the project folder.
3. Run in shell.
```shell
flutter pub get
flutter run main.dart
```

## How to use Alan

Alan offers SDKs to embed a voice assistant to our app.
1. Just press the alan button at the bottom and say "send a message/whatsapp/email to [Contact info] on [date] at [time]" 
2. Alan will as for the message and any missing information he failed to catch.
3. Provide him with the required information and he'll cue the message successfully
