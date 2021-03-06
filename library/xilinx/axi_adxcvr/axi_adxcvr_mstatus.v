// ***************************************************************************
// ***************************************************************************
// Copyright 2011(c) Analog Devices, Inc.
// 
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//     - Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     - Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in
//       the documentation and/or other materials provided with the
//       distribution.
//     - Neither the name of Analog Devices, Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//     - The use of this software may or may not infringe the patent rights
//       of one or more patent holders.  This license does not release you
//       from the requirement that you obtain separate licenses from these
//       patent holders to use this software.
//     - Use of the software either in source or binary form, must be run
//       on or directly connected to an Analog Devices Inc. component.
//    
// THIS SOFTWARE IS PROVIDED BY ANALOG DEVICES "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED.
//
// IN NO EVENT SHALL ANALOG DEVICES BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, INTELLECTUAL PROPERTY
// RIGHTS, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/1ps

module axi_adxcvr_mstatus (

  input           up_rstn,
  input           up_clk,

  input           up_pll_locked_in,
  input           up_rst_done_in,
  input           up_pll_locked,
  input           up_rst_done,
  output          up_pll_locked_out,
  output          up_rst_done_out);

  // parameters

  parameter   integer XCVR_ID = 0;
  parameter   integer NUM_OF_LANES = 8;

  // internal registers

  reg             up_pll_locked_int = 'd0;
  reg             up_rst_done_int = 'd0;

  // internal signals

  wire            up_pll_locked_s;
  wire            up_rst_done_s;

  // daisy-chain the signals

  assign up_pll_locked_out = up_pll_locked_int;
  assign up_rst_done_out = up_rst_done_int;

  assign up_pll_locked_s = (XCVR_ID < NUM_OF_LANES) ? up_pll_locked : 1'b1;
  assign up_rst_done_s = (XCVR_ID < NUM_OF_LANES) ? up_rst_done : 1'b1;

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 1'b0) begin
      up_pll_locked_int <= 1'd0;
      up_rst_done_int <= 1'd0;
    end else begin
      up_pll_locked_int <= up_pll_locked_in & up_pll_locked_s;
      up_rst_done_int <= up_rst_done_in & up_rst_done_s;
    end
  end

endmodule     

// ***************************************************************************
// ***************************************************************************

