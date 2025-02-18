# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.reset.value = 1
    await ClockCycles(dut.clk, 5)
    dut.reset.value = 0

    dut._log.info("Test project behavior")

    # Set if the counter is 5 after counting up 10 times and counting down 5 times
    await ClockCycles(dut.clk, 1)

    dut.enable.value = 1
    # Do 10 clock cycles
    for i in range(10):
        await ClockCycles(dut.clk, 1)
    # Count down 5 times
    dut.enable.value = 0
    for i in range(5):
        await ClockCycles(dut.clk, 1)

    # Assert that the counter is 5
    asset dut.count.value == 5
