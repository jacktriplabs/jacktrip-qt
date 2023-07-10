# Scripts to Build Qt for JackTrip

Copyright (c) 2023 JackTrip Labs, Inc.
See [MIT License](LICENSE)

These are opinionated scripts to build Qt with only the features required by [JackTrip](https://github.com/jacktrip/jacktrip).

## qtbuild.sh (for Unix)

`./qtbuild.sh <VERSION>`

Creates static build of Qt in `/opt/qt-<VERSION>-static`

Supports:
* Qt5
* Qt6
* Linux
* OSX
* Windows MinGW (WIP)

`./qtbuild.sh -dynamic <VERSION>`

Creates dynamic build of Qt in `/opt/qt-<VERSION>-dynamic`

Supports:
* Qt5
* Qt6
* Linux
* OSX
* Windows MinGW (WIP)

For OSX, use environment variable `QT_BUILD_ARCH` to specify Intel or ARM architecture:

* Intel: 'x86_64'
* Arm: 'arm64'
* Universal (Qt5): 'x86_64 arm64'
* Universal (Qt6): 'x86_64;arm64'


## qtbuild.bat (for Windows MSVC x64)

`qtbuild.bat <VERSION>`

Creates static build of Qt in `c:\qt\qt-<VERSION>-static`

`qtbuild.bat <VERSION>`

Creates dynamic build of Qt in `c:\qt\qt-<VERSION>-dynamic`

### Before you build...

Install Visual Studio (from [here](https://learn.microsoft.com/en-us/windows/apps/windows-app-sdk/set-up-your-development-environment?tabs=cs-vs-community%2Ccpp-vs-community%2Cvs-2022-17-1-a%2Cvs-2022-17-1-b)):

```
winget install "Visual Studio Community 2022"  --override "--add Microsoft.VisualStudio.Workload.NativeDesktop Microsoft.VisualStudio.ComponentGroup.WindowsAppSDK.Cpp"  -s msstore
```

Install chocolately:

[Chocolatey Software | Installing Chocolatey](https://chocolatey.org/install)

Install a few tasty packages:

```
choco install -y git jom zip unzip cmake ninja meson pkgconfiglite
```

Go to Windows Search, type "Envir" and choose "Edit the system environment variables"

Click "Advanced" tab, then "Environment Variables..." at the bottom

Add these to your Path variable:

```
C:\Program Files\CMake\bin
C:\Program Files\NASM
```

(restart terminal to pick up changes)

Load Visual Studio paths ([from here](https://learn.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=msvc-160)):
```
"%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
```