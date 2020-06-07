# stm32-freertos-mac
Instructions and examples for cross-compiling FreeRTOS on an STM32 on macOS


# Prerequisites 

1. This tutorial assumes you have installed a recent Xcode Command Line Tools (Make, Git, etc.)
```
$ xcode-select --install
```

2. Install the Homebrew package manager - brew.sh

1. Install the GNU Arm Embedded Toolchain
The GNU Embedded Toolchain for Arm is a ready-to-use, open-source suite of tools for C, C++ and assembly programming targeting 32-bit Arm Cortex-A, Arm Cortex-M and Cortex-R family of processors.

```
$ brew install homebrew/cask/gcc-arm-embedded
```

NOTE: you make have to run:
```$ sudo spctl --master-disable```
To allow unsigned apps downloaded from anywhere run on macOS 10.15+

Install OpenOCD (on-chip debugger)
```
$ brew install openocd
```

Install STLink for USB <--> JTAG debugging with a Nucleo
```
$ brew install stlink
```

Install STM32CubeMX
http://www.st.com/en/development-tools/stm32cubemx.html
You'll have to register unfortunately

After Downloading the installer, use the following commands to manually launch the install.
```
$ cd en.stm32cubemx # <-- the path to the package you just downloaded
$ java -jar SetupSTM32CubeMX-5.6.1.exe # or whatever version you have -- you may install the JDK here if you haven't already :(
```

Install STM32CubeProgrammer
https://www.st.com/en/development-tools/stm32cubeprog.html
After Downloading the installer, use the following commands to manually launch the install.
```
$ cd en.stm32cubemx # <-- the path to the package you just downloaded
$ java -jar SetupSTM32CubeProgrammer-2.3.0.exe # or whatever version you have
```

Create a symbolic link to one of the binary directory searched by your $PATH variable:
```
$ ln -sv /Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin/STM32_Programmer_CLI /usr/local/bin/
```

```
$ brew install autoconf
```
```
$ brew install automake
```
```
$ brew install pkg-config
```
```
$ brew install dfu-util
```
```
$ brew install coreutils
```

Open up STM32CubeMX application you just installed.
Go to Help > Select your STM target(s) > Install the latest MCU Package(s)

Under New Project select "ACCESS TO BOARD SELECTOR"
If you're using a Nucleo Select "BOARD SELECTOR"
Select your board, and then click on "Start Project" in the top right
In the Pinout & Configuration menu, select Middleware
Select FreeRTOS, and choose the CMSIS_V2 Interface

Go to the Project Manager menu, select "Makefile" for Toolchain/IDE
Select Generate Code and navigate to the project tree generated

```
$ make
```

Program the device:

Erase the SoC:
```
$ STM32_Programmer_CLI -c port=SWD -e all
```
```
$ STM32_Programmer_CLI -c port=SWD mode=UR reset=HWrst -e all # hold reset button then release when connecting
```

Flash the SoC:
```
$ STM32_Programmer_CLI -c port=SWD -w build/example.elf
```

Exercise for the programmer:
Make a new FreeRTOS thread that blinks User LEDS 1,2,3 every 0.5 seconds, and program the board

TODO: get ARM linker script and FreeRTOS to work with C++
