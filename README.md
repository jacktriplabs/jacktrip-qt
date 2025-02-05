# Scripts to Build Qt for JackTrip

Copyright (c) 2023-2024 JackTrip Labs, Inc.
See [MIT License](LICENSE)

These are opinionated scripts to build Qt with only the features required by [JackTrip](https://github.com/jacktrip/jacktrip).

Projects that use these artifacts must adhere to the terms & conditions of the [Qt License](https://www.qt.io/licensing/).

## Download Links

Mac OS X (Universal)
* [Qt 6.8.2 Dynamic](https://files.jacktrip.org/contrib/qt/qt-6.8.2-dynamic-osx.tar.gz)
* [Qt 6.8.2 Static](https://files.jacktrip.org/contrib/qt/qt-6.8.2-static-osx.tar.gz)
* [Qt 6.2.11 Dynamic](https://files.jacktrip.org/contrib/qt/qt-6.2.11-dynamic-osx.tar.gz)
* [Qt 6.2.11 Static](https://files.jacktrip.org/contrib/qt/qt-6.2.11-static-osx.tar.gz)
* [Qt 6.2.6 Dynamic](https://files.jacktrip.org/contrib/qt/qt-6.2.6-dynamic-osx.tar.gz)
* [Qt 6.2.6 Static](https://files.jacktrip.org/contrib/qt/qt-6.2.6-static-osx.tar.gz)
* [Qt 5.15.13 Static](https://files.jacktrip.org/contrib/qt/qt-5.15.13-static-osx.tar.gz)

Windows MSVC (64-bit)
* [Qt 6.8.2 Dynamic](https://files.jacktrip.org/contrib/qt/qt-6.8.2-dynamic-win.zip)
* [Qt 6.8.2 Static](https://files.jacktrip.org/contrib/qt/qt-6.8.2-static-win.zip)
* [Qt 6.5.3 Dynamic](https://files.jacktrip.org/contrib/qt/qt-6.5.3-dynamic-win.zip)
* [Qt 6.5.3 Static](https://files.jacktrip.org/contrib/qt/qt-6.5.3-static-win.zip)
* [Qt 5.15.13 Static](https://files.jacktrip.org/contrib/qt/qt-5.15.13-static-win.zip)

Linux (AMD64)
* [Qt 6.8.2 Static](https://files.jacktrip.org/contrib/qt/qt-6.8.2-static-linux-amd64.tar.gz)
* [Qt 6.5.3 Static](https://files.jacktrip.org/contrib/qt/qt-6.5.3-static-linux-amd64.tar.gz)
* [Qt 5.15.13 Static](https://files.jacktrip.org/contrib/qt/qt-5.15.13-static-linux-amd64.tar.gz)

Linux (ARM64)
* [Qt 6.8.2 Static](https://files.jacktrip.org/contrib/qt/qt-6.8.2-static-linux-arm64.tar.gz)
* [Qt 6.5.3 Static](https://files.jacktrip.org/contrib/qt/qt-6.5.3-static-linux-arm64.tar.gz)
* [Qt 5.15.13 Static](https://files.jacktrip.org/contrib/qt/qt-5.15.13-static-linux-arm64.tar.gz)


## Linux Docker

To build for Linux using Docker:

amd64:
```
docker buildx build --platform linux/amd64 --target=artifact --output type=local,dest=./ --build-arg QT_VERSION=6.8.2 .
```

arm64
```
docker buildx build --platform linux/arm64 --target=artifact --output type=local,dest=./ --build-arg QT_VERSION=6.8.2 .
```

arm32:
```
docker buildx build --platform linux/arm/v7 --target=artifact --output type=local,dest=./ --build-arg BUILD_CONTAINER=debian:buster --build-arg QT_VERSION=5.15.13 .
```


## qtbuild.sh

For Linux, Mac OS X, Windows MinGW (WIP)

`./qtbuild.sh <VERSION>`

Creates static build of Qt in `/opt/qt-<VERSION>-static`

`./qtbuild.sh -dynamic <VERSION>`

Creates dynamic build of Qt in `/opt/qt-<VERSION>-dynamic`

For OS X, use environment variable `QT_BUILD_ARCH` to specify Intel or ARM architecture:

* Intel: 'x86_64'
* Arm: 'arm64'
* Universal (Qt5): 'x86_64 arm64'
* Universal (Qt6): 'x86_64;arm64'


## qtbuild.bat

For Microsoft Windows (MSVC)

`qtbuild.bat <VERSION>`

Creates static build of Qt in `c:\qt\qt-<VERSION>-static`

`qtbuild.bat -dynamic <VERSION>`

Creates dynamic build of Qt in `c:\qt\qt-<VERSION>-dynamic`

### Before you build...

_Ensure that you checkout this repository in a path that is close to your drive's top-level
directory. Otherwise, you will run into obscure errors due to Windows path size limitations!_

Install Visual Studio (from [here](https://learn.microsoft.com/en-us/windows/apps/windows-app-sdk/set-up-your-development-environment?tabs=cs-vs-community%2Ccpp-vs-community%2Cvs-2022-17-1-a%2Cvs-2022-17-1-b)):

```
winget install "Visual Studio Community 2022"  --override "--add Microsoft.VisualStudio.Workload.NativeDesktop Microsoft.VisualStudio.ComponentGroup.WindowsAppSDK.Cpp"  -s msstore
```

Install python3 using winget since chocolately packages seem to be broken:

```
winget install python3
```

Install chocolately:

[Chocolatey Software | Installing Chocolatey](https://chocolatey.org/install)

Install some tasty packages (meson 1.2.0 is broken):

```
choco install -y meson --version 1.1.1
choco install -y git jom zip unzip cmake ninja pkgconfiglite winflexbison3 gperf nodejs-lts python nasm StrawberryPerl
```

Go to Windows Search, type "Envir" and choose "Edit the system environment variables"

Click "Advanced" tab, then "Environment Variables..." at the bottom

Add these to your Path variable:

```
C:\Program Files\CMake\bin
C:\Program Files\NASM
```

(restart terminal to pick up changes)

Install html5lib (required for 6.2.5+):
```
pip3 install html5lib
```

Install importlib-metadata (required for WebEngine in 6.5+):
```
pip3 install importlib-metadata
```

Load Visual Studio paths ([from here](https://learn.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=msvc-160)):
```
"%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
```
