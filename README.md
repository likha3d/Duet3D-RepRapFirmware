RepRapFirmware CMake Build
===========================

Fork of [Duet3D RepRapFirmware](https://github.com/Duet3D/RepRapFirmware) that can be built using CMake. Instructions are in `CMakeBuildInstructions.md`.

## Build

This branch tracks stable releases of RepRapFirmware, currently at **3.1.1**. More specifically, the repositories (and the tag/branch) involved in the build are as follows:

- RepRapFirmware **3.1.1**
- CoreNG **3.1.0**
- CANlib **3.1.0**
- DuetWiFiSocketServer **master**
- FreeRTOS **3.1.0**
- RRFLibraries **3.1.0**

## Supported Boards

- Duet 2 Wifi/Ethernet
- Duet Maestro
- Duet 3 6HC

## Warning

The built firmware are not guaranteed to perform the same as official releases by Duet3D, so use them at your own risk.  This repository is used for a private (for now) development getting RepRapFirmware running on a new chip.