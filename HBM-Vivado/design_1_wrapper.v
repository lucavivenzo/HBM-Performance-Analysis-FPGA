//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
//Date        : Mon Jan 31 17:36:48 2022
//Host        : CeRICT-RECIPE-1 running 64-bit Ubuntu 18.04.4 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (pci_express_x16_rxn,
    pci_express_x16_rxp,
    pci_express_x16_txn,
    pci_express_x16_txp,
    pcie_perstn,
    pcie_refclk_clk_n,
    pcie_refclk_clk_p,
    resetn,
    sysclk0_clk_n,
    sysclk0_clk_p);
  input [15:0]pci_express_x16_rxn;
  input [15:0]pci_express_x16_rxp;
  output [15:0]pci_express_x16_txn;
  output [15:0]pci_express_x16_txp;
  input pcie_perstn;
  input pcie_refclk_clk_n;
  input pcie_refclk_clk_p;
  input resetn;
  input sysclk0_clk_n;
  input sysclk0_clk_p;

  wire [15:0]pci_express_x16_rxn;
  wire [15:0]pci_express_x16_rxp;
  wire [15:0]pci_express_x16_txn;
  wire [15:0]pci_express_x16_txp;
  wire pcie_perstn;
  wire pcie_refclk_clk_n;
  wire pcie_refclk_clk_p;
  wire resetn;
  wire sysclk0_clk_n;
  wire sysclk0_clk_p;

  design_1 design_1_i
       (.pci_express_x16_rxn(pci_express_x16_rxn),
        .pci_express_x16_rxp(pci_express_x16_rxp),
        .pci_express_x16_txn(pci_express_x16_txn),
        .pci_express_x16_txp(pci_express_x16_txp),
        .pcie_perstn(pcie_perstn),
        .pcie_refclk_clk_n(pcie_refclk_clk_n),
        .pcie_refclk_clk_p(pcie_refclk_clk_p),
        .resetn(resetn),
        .sysclk0_clk_n(sysclk0_clk_n),
        .sysclk0_clk_p(sysclk0_clk_p));
endmodule
