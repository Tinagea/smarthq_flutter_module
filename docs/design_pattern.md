# Design Pattern for SmartHQ Flutter Module Project

## Introduce
SmartHQ Home app started the project with Native (Android, iOS), and later, Flutter was added to gradually expand its functions.</br>So SmartHQ Home app has a Flutter Module type project, not a Flutter Application type project.

Basically, when the app runs, it starts in Native (Android, iOS), and then loads the Flutter Engine to use the Flutter Module.

## Patterns & technique
The patterns and techniques used in the Flutter Module are as follows.
- Cubit(Bloc) Pattern
- Repository Pattern
  - NativeRepository
  - ApiServiceRepository
  - ApplianceServiceRepository
  - DialogRepository
- FlutterChannel
  - NativeChannel
  - ApiServiceChannel
  - ApplianceServiceChannel
- Dependancy Injection
  - [GetIt](https://pub.dev/packages/get_it) package
- Managers
  - LocalDataManager
  - SharedDataManager
  - CertificateManager
- Flutter Engine
  - EntryPoint (Main, Dialog)


### Cubit(Bloc) Pattern
This project uses the Bloc Pattern. However, we use **Cubit** instead of using **Bloc**.<br/>
For this, we use the [flutter_bloc](https://pub.dev/packages/flutter_bloc) Package.<br/>
The [bloc_library](https://bloclibrary.dev/#/gettingstarted) webpage provides a detailed guide on Bloc and Cubit.
</br>It is highly recommended to read this page.

<img width="853" alt="pattern" src="https://user-images.githubusercontent.com/32116640/217201061-e11b6f28-9963-498e-8a24-4fca4e1826c5.png">

In the diagram above, the direction of the arrow must be followed.</br>
To help you understand, I will briefly explain the flow of the app.</br>
- When a button on the View is pressed, it notifies Cubit by calling a function of Cubit that the button was pressed.
- Cubit recognizes that the View button is pressed through the function and executes the business logic related to View.
- At this time, Cubit requests resources by accessing Remote Data(WebSocket or RestAPI) or Local Data (data stored by the Flutter Module), or Native Data (iOS/Android) through the Repository.
- These resources can be obtained through Channels and Providers.</br>
Data can be exchanged between Native and Flutter through Channel, and there is a Provider for each URI of the server.

Cubit sequentially processes resources received through the Repository according to the business logic, and emits State. Since the View is bound to State, the screen can be updated through State.

Again, it is important to emphasize that the View should only update the screen through State. Do not update the screen directly by receiving the return value when calling the Cubit function. This means that the arrow direction between View and Cubit becomes bidirectional.

Sometimes, there are cases where the screen needs to be updated from the View itself without requesting Cubit. For example, when a checkbox is checked and the color of a widget needs to be changed. In such cases, using setState() to allow the View to update its own state is permissible. Except for this case, the View must update itself through State.

The View cannot directly call other elements (Repository, Channel, Provider) instead of Cubit.

### Repository Pattern
The app uses the repository pattern to access resources.</br>
The project has multiple repositories, and the main repositories are described as follows:

- NativeRepository: Purpose is to access Native Resources, and exchange the most basic information commonly used between Native and Flutter.
- ApiServiceRepository: Communicates with the server via REST API calls.
- ApplianceServiceRepository: Communicates with the server via WebSocket connections.
- DialogRepository: It is used to display dialogs and popups from Native to Flutter, and this is only used in the Dialog Engine.

### FlutterChannel
Due to its structural characteristics, Flutter Modules require close communication with the native side. To achieve this, various Flutter Channels exist, including:

- NativeChannel: a channel that connects to the Native Repository and exchanges information with Native that can be commonly used without depending on specific appliances.
- ApiServiceChannel: a channel used by Native to request RestAPI through Flutter.
- ApplianceServiceChannel: a channel used by Native to connect WebSocket through Flutter.

### Dependancy Injection
Using the [GetIt](https://pub.dev/packages/get_it) package, you can define and inject all major components and necessary resources when a Flutter module starts. However, it is not recommended to excessively use GetIt to directly get resources within the code.</br>
Instead, necessary elements should be passed as member variables through the constructor, and accessed through these member variables, when the Flutter module starts.

### Managers
The manager manages the feature required to support the app.
  - LocalDataManager: Volatile data - data does not persist when the app is closed
    - xxxxStorage (Inherit Storage and create and use Storage for each purpose.)
  - SharedDataManager: Non-volatile data - Data persists even after the app is closed
    - [SharedPreferences](https://pub.dev/packages/shared_preferences) package 
    - Data is stored encrypted
  - CertificateManager: The SmartHQ Home app uses Pinning technique to maintain security while communicating with the server. For this, 4 AWS Root CAs and 1 AWS Intermediate Certificate are being used.


### Flutter Engine
According to the Flutter guide, it is recommended to create a separate Flutter Engine for each screen for rendering. When the app is structured in this way, multiple Flutter Engines need to be managed. Since each Flutter Engine has independent memory, they cannot read or write to each other. Native plays the role of a hub to enable data exchange between multiple engines. This structure requires additional work to transition to a Flutter application in the future. To make it easier to transition to a Flutter application in the future, the app is designed to use a single Flutter Main Engine.

Recently, Flutter Dialog Engine was added for displaying dialogs and popups.</br>
So, currently, two Flutter Engines are being used:
- Main Flutter Engine: An engine that has all screens and business logic.
- Dialog Flutter Engine: An engine for push notifications and dialog popups.

EntryPoint (Main, Dialog):</br>
To optimize the use of two Flutter engines, there are two entry points.
- Main: The main entry point loads and uses everything except the dialog-related parts.
- Dialog: The dialog entry point only loads the dialog-related parts.


## README in Flutter Module Project
Finally, if there are important updates to the FlutterModule, a guide will be added to the [Flutter Module's README](https://github.com/geappliances/mobile.connected.smarthq.flutter/tree/develop/smarthq_flutter_module/README.md). Referring to this file can also be helpful in understanding the project.
