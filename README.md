# VLC.Native

[![NuGet](https://badge.fury.io/nu/VLC.Native.svg)](https://www.nuget.org/packages/VLC.Native/)
[![NuGet](https://img.shields.io/nuget/dt/VLC.Native.svg?style=flat-square)](https://www.nuget.org/packages/VLC.Native/)

A utility script for building a VLC redistribution NuGet package.

## Build

On the command line, type

```console
build.bat [version=3.0.5]
```

where `version` defaults to `3.0.5` and refers to the VCL version you want to package.
The script then downloads, unzips and packages the VLC distribution from the official [VLC download site](http://download.videolan.org/pub/videolan/vlc).

## Prerequisites

You should have the following tools on the command line

- [curl](https://chocolatey.org/packages/curl)
- [7zip](https://chocolatey.org/packages/7zip.install)
- [NuGet](https://chocolatey.org/packages/NuGet.CommandLine)

## Example Usage with C\#

Installing the package using

```powershell
Install-Package VLC.Native
```

adds the file `VlcConfiguration.cs` to your project.

## Where to go from here

Have a look at

- [nVLC](https://www.nuget.org/packages/nVLC/), one of the few good managed wrappers for VLC
- [hello.nVLC](https://github.com/mkoertgen/hello.nVLC), a minimal WPF player application  
