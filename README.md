# Flutter Kit

This kit is a boilerplate for Flutter projects. It comes with a set of preconfigured features and utilities to help you get started with your project.

## Get started

### 1. Clone the repository

```bash
git clone https://github.com/afesohromeo/flutter_bloc_kit.git
```

### 2. Customize the project

Install the Rename CLI Tool by executing the following command:

````bash
flutter pub global activate rename
````

Run the following commands:

````bash
_rename setAppName --targets ios,android --value "YourAppName"
````

- This will set the AppName for the iOS and Android platforms to "YourAppName".

````bash
rename setBundleId --targets ios,android --value "com.example.bundleId"
````
- This will set the BundleId for the Android and Ios platform to "com.example.bundleId".

If you are building for other platforms other than android and ios make sure to specify in "--targets" parameter.
For more info on Rename Cli tool checkout [https://pub.dev/packages/rename]

## Features

This kit comes with a set of preconfigured features and utilities:

- I18n
- Navigation (using go_router)
- State management (using BLoc)
- Extensions (on context, iterable)
- Utility widgets
- Default Theming using Material 3 and google font

    ## 🗺️ I18n
This kit uses packages flutter_localizations and [intl](https://pub.dev/packages/intl) for internationalization. To add a new language, add a new file to the `src/core/l10n` folder. The file name should be the language code prefixed with app_ (e.g. `intl_fr.arb`).

To generate the code for the new language, run the following command:

```bash
flutter pub get
```

Alternatively, you can install the [flutter_intl](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl) package in VSCode to automatically generate the code when you save the file.

## 🛣️ Navigation
This kit uses [go_router](https://pub.dev/packages/go_router) for navigation. To add a new route, add a new route to the file `src/core/routing/route_manager.dart`. 

See the [go_router documentation](https://pub.dev/packages/go_router) for more information.

## 🧱 State Management
This kit uses [BLoC](https://pub.dev/packages/flutter_bloc) for state management. 
See the [BLoC documentation](https://bloclibrary.dev/#/gettingstarted) for more information.

An example of a BLoC can be found in the `src/features/home_screen/bloc` folder.

## 🗼 Extensions
This kit comes with a few extensions on the `BuildContext` and `Iterable` classes. See the `src/shared/extensions` folder for more information.

## 📌 Utils
### Widgets
This kit comes with a few utility widgets. See the `src/shared/components` folder for more information.

### Assets
Assets paths are automaticalle generated when using build_runnner thanks to the [flutter_gen](https://pub.dev/packages/https://pub.dev/packages/flutter_gen) package.


## 🖌️ Theming
This kit uses the new Material 3 theming system. See the `src/core/theme` folder for more information.

The default color scheme is generated using https://m3.material.io/theme-builder#/custom. You can use this tool to generate your own color scheme.

## 💼 Need a new feature?
If you need a new feature, please open an issue on the [GitHub repository](https://github.com/stevenosse/flutter_boilerplate/issues/new)

## 📇 Get in touch
If you have any questions, feel free to contact me on [Twitter](https://twitter.com/nossesteve) 