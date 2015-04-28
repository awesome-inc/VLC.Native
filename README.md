# VLC.Native

A utility script for building a VLC redistribution NuGet package.

## Build

On the command line, type

    build.bat [version=2.2.0]
    
where `version` defaults to `2.2.0` and refers to the VCL version you want to package.
The script then downloads, unzips and packages the VLC distribution from the official [VLC download site](http://download.videolan.org/pub/videolan/vlc).

## Prerequisites

You should have the following tools on the command line

- [curl](https://chocolatey.org/packages/curl)
- [7zip](https://chocolatey.org/packages/7zip.install)
- [NuGet](https://chocolatey.org/packages/NuGet.CommandLine)

