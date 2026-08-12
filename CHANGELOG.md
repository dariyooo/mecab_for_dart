# Mecab for dart

## 2.0.4

* Fixed: `libc++_shared.so` was not bundled for armeabi-v7a
* `hooks: ^2.0.2`, `native_toolchain_c: ^0.19.2`

## 2.0.3

* Fixed: native_toolchain_c: ^0.17.2 breaks this package

## 2.0.2

* Fixed: hooks
* Fixed: default options

## 2.0.1

* Provide default values in `MecabTransferableState`

## 2.0.0

* Complete refactor of the library
* No ugly `.init()` API anymore
  * Use the `await Mecab.create(...)` factory
* MeCab can now safely be shared across isolates
  * Use `.transferableState` and `.fromTransferableState(...)` to safely share across isolates
  * Dictionary memory will only be consumed once per `library + dictionary + options` combination
* Use hooks on native platforms (currently no web support)
  * The flutter package is now basically deprecated (only used for the example)

## 1.3.0

* Transferable is now a class
* Made transferable state factory async

## 1.2.0

* Unified flutter and dart package: no `init_flutter` anymore
* Added isolate serialization method

## 1.1.7

* Fixed: `libmecabPath` not correctly set

## 1.1.6

* Bump package versions
* Expose: `libmecabPath`, `mecabDictDirPath`

## 1.1.5

* Export `TokeNode`

## 1.1.4

* Updated
  * CHANGELOG
  * README
* Added example

## 1.1.3

* Updated REDAME

## 1.1.2

* Added linux makefile and updated build instructions

## 1.1.1

* Do not include large assets in pub package

## 1.1.0

* Split mecab packge into flutter and dart packages
  * This package can now run in dart standalone
  * Flutter package with bundled libraries is [here](https://pub.dev/packages/mecab_for_flutter)

## 1.0.7

* Updated plugin for new AGP

## 1.0.6

* Fixed plugin on Linux

## 1.0.5

* Fixed plugin on Windows

## 1.0.4

* Fixed plugin on Android

## 1.0.3

* Fixed plugin on Mac and iOS

## 1.0.2

* Fixed dictionary loading on web

## 1.0.1

* Added link to web app
* Fixed example

## 1.0.0

* Initial release
* Support for: android, ios, macos, linux, windows, web (js only)
