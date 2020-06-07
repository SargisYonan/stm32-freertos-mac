#!/bin/sh

# @file flash.sh

STM32_Programmer_CLI -c port=SWD -e all
STM32_Programmer_CLI -c port=SWD -w build/example.elf
