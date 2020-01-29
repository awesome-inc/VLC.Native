# VLC.Native

[![NuGet](https://badge.fury.io/nu/VLC.Native.svg)](https://www.nuget.org/packages/VLC.Native/)
[![NuGet](https://img.shields.io/nuget/dt/VLC.Native.svg?style=flat-square)](https://www.nuget.org/packages/VLC.Native/)

A utility script for building a VLC redistribution NuGet package.

## Build

On the command line, type

```console
build.bat [version=3.0.8]
```

where `version` defaults to `3.0.8` and refers to the VCL version you want to package.
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

**NOTE:** The VLC dependency package is quite big (~320MB, 166 MB each for x86/x64), so when using `VLC.Native` together with [Continuous Testing](https://en.wikipedia.org/wiki/Continuous_testing) Tools (e.g. [NCrunch](https://www.ncrunch.net/)) you may consider disabling the large footprint of the native VLC dependencies by setting

```xml
<PropertyGroup>
  <!-- set to anything different than '', e.g. 1 -->
  <DisableVlcNative>$(NCrunch)</DisableVlcNative>
</PropertyGroup>
```

Here we used NCrunch-specific build properties but any value other than `''` will cause `VLC.Native` to skip including
the native dependencies as content to your build, c.f.

- [NCrunch-Specific Overrides](https://www.ncrunch.net/documentation/troubleshooting_ncrunch-specific-overrides)
- [NCrunch Build Properties](https://www.ncrunch.net/documentation/troubleshooting_ncrunch-build-properties)

## Where to go from here

Have a look at

- [nVLC](https://www.nuget.org/packages/nVLC/), one of the few good managed wrappers for VLC
- [hello.nVLC](https://github.com/mkoertgen/hello.nVLC), a minimal WPF player application  
