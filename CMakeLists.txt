cmake_minimum_required(VERSION 3.10)
project(RepRapFirmware)

set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
set(CMAKE_EXECUTABLE_SUFFIX ".elf")

# Get information needed about the build such as the board
# and the path to needed external libraries.
set(BOARD "DuetNG" CACHE STRING "RepRapFirmware target board")

set(supported "Duet3Mini"
              "DuetNG"
              "DuetM"
              "Pccb"
              "Duet3_V06")
set_property(CACHE BOARD PROPERTY STRINGS ${supported})

if(NOT BOARD IN_LIST supported)
    message(FATAL_ERROR "Chosen unsupported board '${BOARD}'")
endif()

# Set required external libraries. If not set, it is assumed that these libraries are
# on the same parent directory as RepRapFirmware.
get_filename_component(parent_dir ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)

if (BOARD STREQUAL "Duet3Mini")
    find_package(CoreNG REQUIRED NAMES CoreN2G HINTS "${parent_dir}/CoreN2G")
else()
    find_package(CoreNG REQUIRED HINTS "${parent_dir}/CoreNG")
endif()

find_package(FreeRTOS REQUIRED HINTS "${parent_dir}/FreeRTOS")
find_package(RRFLibraries REQUIRED HINTS "${parent_dir}/RRFLibraries")

# Optional libraries
find_package(DuetWiFiSocketServer HINTS "${parent_dir}/DuetWiFiSocketServer")
find_package(CANlib HINTS "${parent_dir}/CANlib")

# Set build specifications
add_compile_options(
    "-c"
    "-ffunction-sections"
    "-fdata-sections"
    "-Wundef"
    "-Wdouble-promotion"
    "-fsingle-precision-constant"
    "-Wall"
    "-O2"
    "-nostdlib"
    "$<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>"
    "$<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>"
)

add_link_options(
    "-Wl,--check-sections"
    "-Wl,--gc-sections"
    "-Wl,--warn-unresolved-symbols"
    "-Wl,--fatal-warnings"
    "-Wl,--unresolved-symbols=report-all"
    "-Wl,--warn-common"
    "-Wl,--warn-section-align"
    "-Wl,--warn-unresolved-symbols"
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 99)

# Common, project-specific build specifications
add_compile_options("-DRTOS" "$<$<COMPILE_LANGUAGE:C>:-Dnoexcept=>")

set(SRCS
    "src/Tools/Filament.cpp"
    "src/Tools/Spindle.cpp"
    "src/Storage/CRC32.cpp"
    "src/Tools/Tool.cpp"
    "src/Storage/CRC16.cpp"
    "src/Storage/CRC16.h"
    "src/Stream.cpp"
    "src/Storage/FileInfoParser.cpp"
    "src/Storage/FileStore.cpp"
    "src/Storage/MassStorage.cpp"
    "src/ObjectModel/ObjectModel.cpp"
    "src/Networking/FtpResponder.cpp"
    "src/Networking/HttpResponder.cpp"
    "src/Networking/Network.cpp"
    "src/Networking/NetworkBuffer.cpp"
    "src/Networking/NetworkInterface.cpp"
    "src/Networking/NetworkResponder.cpp"
    "src/Networking/TelnetResponder.cpp"
    "src/Networking/UploadingNetworkResponder.cpp"
    "src/Movement/StepperDrivers/DriverMode.cpp"
    "src/Movement/StepperDrivers/TMC22xx.cpp"
    "src/Movement/StepperDrivers/TMC2660.cpp"
    "src/Movement/StepperDrivers/TMC51xx.cpp"
    "src/Movement/Kinematics/CoreKinematics.cpp"
    "src/Movement/Kinematics/FiveBarScaraKinematics.cpp"
    "src/Movement/Kinematics/HangprinterKinematics.cpp"
    "src/Movement/Kinematics/Kinematics.cpp"
    "src/Movement/Kinematics/PolarKinematics.cpp"
    "src/Movement/Kinematics/LinearDeltaKinematics.cpp"
    "src/Movement/Kinematics/RotaryDeltaKinematics.cpp"
    "src/Movement/Kinematics/ScaraKinematics.cpp"
    "src/Movement/Kinematics/ZLeadscrewKinematics.cpp"
    "src/Movement/HeightControl/HeightController.cpp"
    "src/Movement/BedProbing/Grid.cpp"
    "src/Movement/BedProbing/RandomProbePointSet.cpp"
    "src/Movement/DDA.cpp"
    "src/Movement/DDARing.cpp"
    "src/Movement/DriveMovement.cpp"
    "src/Movement/Move.cpp"
    "src/Movement/RawMove.cpp"
    "src/Movement/StepTimer.cpp"
    "src/Movement/StraightProbeSettings.cpp"
    "src/Libraries/sha1/sha1.c"
    "src/Libraries/Fatfs/diskio.cpp"
    "src/Libraries/Fatfs/fattime_rtc.cpp"
    "src/Libraries/Fatfs/ff.c"
    "src/Libraries/Fatfs/ffunicode.c"
    "src/Heating/Sensors/AdditionalOutputSensor.cpp"
    "src/Heating/Sensors/CpuTemperatureSensor.cpp"
    "src/Heating/Sensors/CurrentLoopTemperatureSensor.cpp"
    "src/Heating/Sensors/DhtSensor.cpp"
    "src/Heating/Sensors/LinearAnalogSensor.cpp"
    "src/Heating/Sensors/RemoteSensor.cpp"
    "src/Heating/Sensors/RtdSensor31865.cpp"
    "src/Heating/Sensors/SensorWithPort.cpp"
    "src/Heating/Sensors/SpiTemperatureSensor.cpp"
    "src/Heating/Sensors/TemperatureSensor.cpp"
    "src/Heating/Sensors/Thermistor.cpp"
    "src/Heating/Sensors/ThermocoupleSensor31855.cpp"
    "src/Heating/Sensors/ThermocoupleSensor31856.cpp"
    "src/Heating/Sensors/TmcDriverTemperatureSensor.cpp"
    "src/Heating/FOPDT.cpp"
    "src/Heating/Heat.cpp"
    "src/Heating/Heater.cpp"
    "src/Heating/HeaterMonitor.cpp"
    "src/Heating/LocalHeater.cpp"
    "src/Heating/RemoteHeater.cpp"
    "src/Heating/TemperatureError.cpp"
    "src/Hardware/I2C.cpp"
    "src/Hardware/IoPorts.cpp"
    "src/Hardware/ExceptionHandlers.cpp"
    "src/Hardware/IoPorts.cpp"
    "src/Hardware/NonVolatileMemory.cpp"
    "src/Hardware/SoftwareReset.cpp"
    "src/GPIO/GpInPort.cpp"
    "src/GPIO/GpOutPort.cpp"
    "src/GCodes/GCodeBuffer/BinaryParser.cpp"
    "src/GCodes/GCodeBuffer/ExpressionParser.cpp"
    "src/GCodes/GCodeBuffer/GCodeBuffer.cpp"
    "src/GCodes/GCodeBuffer/StringParser.cpp"
    "src/GCodes/GCodeException.cpp"
    "src/GCodes/GCodeFileInfo.cpp"
    "src/GCodes/GCodeInput.cpp"
    "src/GCodes/GCodeMachineState.cpp"
    "src/GCodes/GCodeQueue.cpp"
    "src/GCodes/GCodes.cpp"
    "src/GCodes/GCodes2.cpp"
    "src/GCodes/GCodes3.cpp"
    "src/GCodes/GCodes4.cpp"
    "src/GCodes/ObjectTracker.cpp"
    "src/GCodes/RestorePoint.cpp"
    "src/GCodes/Trigger.cpp"
    "src/FilamentMonitors/Duet3DFilamentMonitor.cpp"
    "src/FilamentMonitors/FilamentMonitor.cpp"
    "src/FilamentMonitors/LaserFilamentMonitor.cpp"
    "src/FilamentMonitors/PulsedFilamentMonitor.cpp"
    "src/FilamentMonitors/RotatingMagnetFilamentMonitor.cpp"
    "src/FilamentMonitors/SimpleFilamentMonitor.cpp"
    "src/Fans/LedStripDriver.cpp"
    "src/Fans/Fan.cpp"
    "src/Fans/FansManager.cpp"
    "src/Fans/LocalFan.cpp"
    "src/Fans/RemoteFan.cpp"
    "src/Endstops/Endstop.cpp"
    "src/Endstops/EndstopsManager.cpp"
    "src/Endstops/LocalZProbe.cpp"
    "src/Endstops/RemoteZProbe.cpp"
    "src/Endstops/StallDetectionEndstop.cpp"
    "src/Endstops/SwitchEndstop.cpp"
    "src/Endstops/ZProbe.cpp"
    "src/Endstops/ZProbeEndstop.cpp"
    "src/Display/Lcd/Fonts/LcdFont.h"
    "src/Display/Lcd/Fonts/glcd11x14.cpp"
    "src/Display/Lcd/Fonts/glcd7x11.cpp"
    "src/Display/Lcd/Lcd.cpp"
    "src/Display/Lcd/Lcd.h"
    "src/Display/Lcd/ST7567/Lcd7567.cpp"
    "src/Display/Lcd/ST7567/Lcd7567.h"
    "src/Display/Lcd/ST7920/Lcd7920.cpp"
    "src/Display/Lcd/ST7920/Lcd7920.h"
    "src/Display/Display.cpp"
    "src/Display/Menu.cpp"
    "src/Display/MenuItem.cpp"
    "src/Display/RotaryEncoder.cpp"
    "src/Comms/AuxDevice.cpp"
    "src/Comms/AuxDevice.h"
    "src/Comms/FirmwareUpdater.cpp"
    "src/Comms/FirmwareUpdater.h"
    "src/Comms/PanelDueUpdater.cpp"
    "src/Comms/PanelDueUpdater.h"
    "src/CAN/CanInterface.cpp"
    "src/CAN/CanMessageGenericConstructor.cpp"
    "src/CAN/CanMotion.cpp"
    "src/CAN/CommandProcessor.cpp"
    "src/CAN/ExpansionManager.cpp"

    "src/Hardware/SharedSpi/SharedSpiClient.cpp"
    "src/Hardware/SharedSpi/SharedSpiDevice.cpp"

    "src/bossa/Applet.cpp"
    "src/bossa/Device.cpp"
    "src/bossa/EefcFlash.cpp"
    "src/bossa/Flash.cpp"
    "src/bossa/Flasher.cpp"
    "src/bossa/Samba.cpp"
    "src/bossa/WordCopyApplet.cpp"
    "src/bossa/WordCopyArm.asm"
    "src/bossa/WordCopyArm.cpp"

    "src/Logger.cpp"
    "src/OutputMemory.cpp"
    "src/Platform.cpp"
    "src/PortControl.cpp"
    "src/PrintMonitor.cpp"
    "src/RepRap.cpp"
    "src/RepRapFirmware.cpp"
    "src/Roland.cpp"
    "src/Scanner.cpp"
    "src/Tasks.cpp"

    "src/libcpp/eh_alloc.cpp"
    "src/libcpp/vterminate.cc"
    "src/libc/memcmp.c"
    "src/libc/memcpy.c"
    "src/libc/memmove.c"
    "src/libc/memset.c"
    "src/libc/strptime.cpp"

    "src/Libraries/sd_mmc/sd_mmc.c"
    "src/Libraries/sd_mmc/sd_mmc_mem.c"
    "src/Libraries/sd_mmc/ctrl_access.c"
    "src/Libraries/sd_mmc/sd_mmc_spi.cpp"
)

set(INCLUDE_DIRS
    "src"
    "src/Networking"
)

# Pull in board-specific sources, include dirs and build-specifications.
# Source files and include dirs are appended to SRCS and INCLUDE_DIRS,
# respectively. Must set BOARD_SOC as well.
include("src/${BOARD}/board.cmake")

add_subdirectory(${FreeRTOS_DIR} FreeRTOS)
add_subdirectory(${RRFLibraries_DIR} RRFLibraries)
add_subdirectory(${CoreNG_DIR} CoreNG)

add_executable(RepRapFirmware ${SRCS})
target_include_directories(RepRapFirmware PRIVATE ${INCLUDE_DIRS})

# ReprapFirmware-specific build specifications
target_compile_definitions(RepRapFirmware PRIVATE "$<$<COMPILE_LANGUAGE:CXX>:_XOPEN_SOURCE>")
target_link_libraries(RepRapFirmware CoreNG RRFLibraries FreeRTOS supc++ m)

# Hard-coded map file name - ideally should use TARGET_FILE_BASE_NAME. Update once minimum
# supported version is at least 3.13 and use target_link_options(). Workaround is for a POST_BUILD
# command to rename the file.
target_link_libraries(RepRapFirmware "-Wl,--cref -Wl,--Map=${CMAKE_BINARY_DIR}/RepRapFirmware.map" "-Os")

if(EXECUTABLE_NAME) # optionally set by board.cmake
    set_target_properties(RepRapFirmware PROPERTIES OUTPUT_NAME "${EXECUTABLE_NAME}")
endif()

# Generate binary file from executable
if(CMAKE_HOST_WIN32)    
    set(host "win-x86_64")
elseif(CMAKE_HOST_APPLE)
    set(host "macos-x86_64")
else() # assumes on Linux
    set(host "linux-x86_64")
endif()

set(crc32appender "${CMAKE_CURRENT_LIST_DIR}/Tools/crc32appender/${host}/crc32appender")
add_custom_command(TARGET RepRapFirmware POST_BUILD
            COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:RepRapFirmware>
                    "$<TARGET_FILE_BASE_NAME:RepRapFirmware>.bin"
            COMMAND ${crc32appender} "$<TARGET_FILE_BASE_NAME:RepRapFirmware>.bin"
            # Workaround inability to set map file name using TARGET_FILE_BASE_NAME that works
            # on minimum supported CMake version.
            COMMAND ${CMAKE_COMMAND} -E rename "RepRapFirmware.map" "$<TARGET_FILE_BASE_NAME:RepRapFirmware>.map")