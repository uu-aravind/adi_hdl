
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
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module axi_usb_fx3_core (

  clk,
  reset,

  // s2mm

  s_axis_tdata,
  s_axis_tkeep,
  s_axis_tlast,
  s_axis_tready,
  s_axis_tvalid,

  // mm2s

  m_axis_tdata,
  m_axis_tkeep,
  m_axis_tlast,
  m_axis_tready,
  m_axis_tvalid,

  // configuration

  fifo0_header_size,
  fifo0_buffer_size,

  fifo1_header_size,
  fifo1_buffer_size,

  fifo2_header_size,
  fifo2_buffer_size,

  fifo3_header_size,
  fifo3_buffer_size,

  fifo4_header_size,
  fifo4_buffer_size,

  fifo5_header_size,
  fifo5_buffer_size,

  fifo6_header_size,
  fifo6_buffer_size,

  fifo7_header_size,
  fifo7_buffer_size,

  fifo8_header_size,
  fifo8_buffer_size,

  fifo9_header_size,
  fifo9_buffer_size,

  fifoa_header_size,
  fifoa_buffer_size,

  fifob_header_size,
  fifob_buffer_size,

  fifoc_header_size,
  fifoc_buffer_size,

  fifod_header_size,
  fifod_buffer_size,

  fifoe_header_size,
  fifoe_buffer_size,

  fifof_header_size,
  fifof_buffer_size,

  // fx3 interface
  // IN -> TO HOST / FX3
  // OUT -> FROM HOST / FX3

  fx32dma_valid,
  fx32dma_ready,
  fx32dma_data,
  fx32dma_sop,
  fx32dma_eop,

  dma2fx3_ready,
  dma2fx3_valid,
  dma2fx3_data,
  dma2fx3_eop,

  error,
  eot_fx32dma,
  eot_dma2fx3,

  test_mode_tpm,
  test_mode_tpg,
  monitor_error,

  fifo_num);

  input           clk;
  input           reset;

  // s2mm

  input           m_axis_tready;
  output  [31:0]  m_axis_tdata;
  output  [ 3:0]  m_axis_tkeep;
  output          m_axis_tlast;
  output          m_axis_tvalid;

  // mm2s

  input   [31:0]  s_axis_tdata;
  input   [ 3:0]  s_axis_tkeep;
  input           s_axis_tlast;
  input           s_axis_tvalid;
  output          s_axis_tready;

  // configuration

  input   [ 7:0]  fifo0_header_size;
  input   [15:0]  fifo0_buffer_size;

  input   [ 7:0]  fifo1_header_size;
  input   [15:0]  fifo1_buffer_size;

  input   [ 7:0]  fifo2_header_size;
  input   [15:0]  fifo2_buffer_size;

  input   [ 7:0]  fifo3_header_size;
  input   [15:0]  fifo3_buffer_size;

  input   [ 7:0]  fifo4_header_size;
  input   [15:0]  fifo4_buffer_size;

  input   [ 7:0]  fifo5_header_size;
  input   [15:0]  fifo5_buffer_size;

  input   [ 7:0]  fifo6_header_size;
  input   [15:0]  fifo6_buffer_size;

  input   [ 7:0]  fifo7_header_size;
  input   [15:0]  fifo7_buffer_size;

  input   [ 7:0]  fifo8_header_size;
  input   [15:0]  fifo8_buffer_size;

  input   [ 7:0]  fifo9_header_size;
  input   [15:0]  fifo9_buffer_size;

  input   [ 7:0]  fifoa_header_size;
  input   [15:0]  fifoa_buffer_size;

  input   [ 7:0]  fifob_header_size;
  input   [15:0]  fifob_buffer_size;

  input   [ 7:0]  fifoc_header_size;
  input   [15:0]  fifoc_buffer_size;

  input   [ 7:0]  fifod_header_size;
  input   [15:0]  fifod_buffer_size;

  input   [ 7:0]  fifoe_header_size;
  input   [15:0]  fifoe_buffer_size;

  input   [ 7:0]  fifof_header_size;
  input   [15:0]  fifof_buffer_size;

  // FX3 interface
  // IN -> ZYNQ TO HOST / FX3
  // OUT -> ZYNQ FROM HOST / FX3

  input           fx32dma_valid;
  output          fx32dma_ready;
  input   [31:0]  fx32dma_data;
  input           fx32dma_sop;
  input           fx32dma_eop;

  input           dma2fx3_ready;
  output          dma2fx3_valid;
  output  [31:0]  dma2fx3_data;
  output          dma2fx3_eop;

  output          error;
  output          eot_fx32dma;
  output          eot_dma2fx3;

  input   [ 2:0]  test_mode_tpm;
  input   [ 2:0]  test_mode_tpg;
  output          monitor_error;

  input   [ 4:0]  fifo_num;

  // internal parameters

  localparam IDLE         = 3'b001;
  localparam READ_HEADER  = 3'b010;
  localparam ADD_FOOTER   = 3'b010;
  localparam READ_DATA    = 3'b100;

  // internal signals

  wire            test_mode_active_tpm;
  wire            test_mode_active_tpg;

  // internal registers

  reg     [31:0]  data_size_transaction = 32'h0;
  reg     [15:0]  buffer_size_current = 16'h0;
  reg     [ 7:0]  header_size_current = 8'h0;

  reg     [31:0]  m_axis_tdata = 32'h0;
  reg     [ 3:0]  m_axis_tkeep = 4'h0;
  reg             m_axis_tlast = 1'b0;
  reg             m_axis_tvalid = 1'b0;

  reg             eot_fx32dma = 1'b0;
  reg             eot_dma2fx3 = 1'b0;

  reg             error_fx32dma = 1'b0;
  reg             error_dma2fx3 = 1'b0;

  reg     [ 2:0]  state_fx32dma = 3'h0;
  reg     [ 2:0]  next_state_fx32dma = 3'h0;

  reg     [ 2:0]  state_dma2fx3 = 3'h0;
  reg     [ 2:0]  next_state_dma2fx3 = 3'h0;

  reg     [ 7:0]  header_pointer = 8'h0;
  reg             header_read = 1'b0;

  reg     [31:0]  dma2fx3_counter = 1'b0;
  reg     [31:0]  footer_pointer = 1'b0;

  reg             s_axis_tready = 1'b0;
  reg             dma2fx3_valid = 1'b0;
  reg     [31:0]  dma2fx3_data = 32'h0;
  reg             dma2fx3_eop = 1'b0;

  reg     [31:0]  expected_data = 32'h0;
  reg             monitor_error = 1'b0;
  reg             first_transfer = 1'b0;

  function [31:0] pn23;
    input [31:0] din;
    reg   [31:0] dout;
    begin
      dout[31] = din[22] ^ din[17];
      dout[30] = din[21] ^ din[16];
      dout[29] = din[20] ^ din[15];
      dout[28] = din[19] ^ din[14];
      dout[27] = din[18] ^ din[13];
      dout[26] = din[17] ^ din[12];
      dout[25] = din[16] ^ din[11];
      dout[24] = din[15] ^ din[10];
      dout[23] = din[14] ^ din[ 9];
      dout[22] = din[13] ^ din[ 8];
      dout[21] = din[12] ^ din[ 7];
      dout[20] = din[11] ^ din[ 6];
      dout[19] = din[10] ^ din[ 5];
      dout[18] = din[ 9] ^ din[ 4];
      dout[17] = din[ 8] ^ din[ 3];
      dout[16] = din[ 7] ^ din[ 2];
      dout[15] = din[ 6] ^ din[ 1];
      dout[14] = din[ 5] ^ din[ 0];
      dout[13] = din[ 4] ^ din[22] ^ din[17];
      dout[12] = din[ 3] ^ din[21] ^ din[16];
      dout[11] = din[ 2] ^ din[20] ^ din[15];
      dout[10] = din[ 1] ^ din[19] ^ din[14];
      dout[ 9] = din[ 0] ^ din[18] ^ din[13];
      dout[ 8] = din[22] ^ din[12];
      dout[ 7] = din[21] ^ din[11];
      dout[ 6] = din[20] ^ din[10];
      dout[ 5] = din[19] ^ din[ 9];
      dout[ 4] = din[18] ^ din[ 8];
      dout[ 3] = din[17] ^ din[ 7];
      dout[ 2] = din[16] ^ din[ 6];
      dout[ 1] = din[15] ^ din[ 5];
      dout[ 0] = din[14] ^ din[ 4];
      pn23 = dout;
    end
  endfunction

  function [31:0] pn9;
    input [31:0] din;
    reg   [31:0] dout;
    begin
      dout[31] = din[ 8] ^ din[ 4];
      dout[30] = din[ 7] ^ din[ 3];
      dout[29] = din[ 6] ^ din[ 2];
      dout[28] = din[ 5] ^ din[ 1];
      dout[27] = din[ 4] ^ din[ 0];
      dout[26] = din[ 3] ^ din[ 8] ^ din[ 4];
      dout[25] = din[ 2] ^ din[ 7] ^ din[ 3];
      dout[24] = din[ 1] ^ din[ 6] ^ din[ 2];
      dout[23] = din[ 0] ^ din[ 5] ^ din[ 1];
      dout[22] = din[ 8] ^ din[ 0];
      dout[21] = din[ 7] ^ din[ 8] ^ din[ 4];
      dout[20] = din[ 6] ^ din[ 7] ^ din[ 3];
      dout[19] = din[ 5] ^ din[ 6] ^ din[ 2];
      dout[18] = din[ 4] ^ din[ 5] ^ din[ 1];
      dout[17] = din[ 3] ^ din[ 4] ^ din[ 0];
      dout[16] = din[ 2] ^ din[ 3] ^ din[ 8] ^ din[ 4];
      dout[15] = din[ 1] ^ din[ 2] ^ din[ 7] ^ din[ 3];
      dout[14] = din[ 0] ^ din[ 1] ^ din[ 6] ^ din[ 2];
      dout[13] = din[ 8] ^ din[ 0] ^ din[ 4] ^ din[ 5] ^ din[ 1];
      dout[12] = din[ 7] ^ din[ 8] ^ din[ 3] ^ din[ 0];
      dout[11] = din[ 6] ^ din[ 7] ^ din[ 2] ^ din[ 8] ^ din[ 4];
      dout[10] = din[ 5] ^ din[ 6] ^ din[ 1] ^ din[ 7] ^ din[ 3];
      dout[ 9] = din[ 4] ^ din[ 5] ^ din[ 0] ^ din[ 6] ^ din[ 2];
      dout[ 8] = din[ 3] ^ din[ 8] ^ din[ 5] ^ din[ 1];
      dout[ 7] = din[ 2] ^ din[ 4] ^ din[ 7] ^ din[ 0];
      dout[ 6] = din[ 1] ^ din[ 3] ^ din[ 6] ^ din[ 8] ^ din[ 4];
      dout[ 5] = din[ 0] ^ din[ 2] ^ din[ 5] ^ din[ 7] ^ din[ 3];
      dout[ 4] = din[ 8] ^ din[ 1] ^ din[ 6] ^ din[ 2];
      dout[ 3] = din[ 7] ^ din[ 0] ^ din[ 5] ^ din[ 1];
      dout[ 2] = din[ 6] ^ din[ 8] ^ din[ 0];
      dout[ 1] = din[5] ^ din[7] ^ din[8] ^ din[4];
      dout[ 0] = din[4] ^ din[6] ^ din[7] ^ din[3];
      pn9 = dout;
    end
  endfunction

  assign error = error_fx32dma | error_dma2fx3;

  assign test_mode_active_tpm = |test_mode_tpm;
  assign test_mode_active_tpg = |test_mode_tpg;

  // fx32dma

  assign fx32dma_ready = m_axis_tready;

  // state machine

  always @(posedge clk) begin
    if (reset == 1'b1 || error_fx32dma == 1'b1) begin
      state_fx32dma <= IDLE;
    end else begin
      state_fx32dma <= next_state_fx32dma;
    end
  end

  always @(*) begin
    case(state_fx32dma)
      IDLE:
      if(fx32dma_sop == 1'b1) begin
        next_state_fx32dma = READ_HEADER;
      end else begin
        next_state_fx32dma = state_fx32dma;
      end
      READ_HEADER:
      if(header_read == 1'b1) begin
        next_state_fx32dma = READ_DATA;
      end else begin
        next_state_fx32dma = state_fx32dma;
      end
      READ_DATA:
      if(data_size_transaction <= 4) begin
        next_state_fx32dma = IDLE;
      end else begin
        next_state_fx32dma = state_fx32dma;
      end
      default: next_state_fx32dma = IDLE;
    endcase
  end

  always @(posedge clk) begin
    case(state_fx32dma)
      IDLE: begin
        m_axis_tvalid <= 1'b0;
        m_axis_tkeep <= 4'h0;
        m_axis_tlast <= 1'b0;
        error_fx32dma <= 1'b0;
        eot_fx32dma <= 1'b0;
        header_read <= 1'b0;
        header_pointer <= 8'h4;
        first_transfer <= 1'b1;
        monitor_error <= 1'b0;
        if (fx32dma_sop == 1'b1) begin
          if(fx32dma_valid == 1'b1) begin
            if(fx32dma_data != 32'hf00ff00f) begin
              error_fx32dma <= 1'b1;
            end else begin
              error_fx32dma <= 1'b0;
            end
          end
        end
        case (test_mode_tpm)
          4'h1: expected_data <= 32'haaaaaaaa;
          default:  expected_data <= 32'hffffffff;
        endcase
      end
      READ_HEADER: begin
        m_axis_tvalid <= 1'b0;
        m_axis_tkeep <= 4'h0;
        m_axis_tlast <= 1'b0;
        error_fx32dma <= 1'b0;
        eot_fx32dma <= 1'b0;
        first_transfer <= 1'b1;
        monitor_error <= 1'b0;
        if( fx32dma_valid == 1'b1) begin
          if(header_pointer < header_size_current - 8) begin
            header_pointer <= header_pointer + 4;
          end else begin
            header_read <= 1'b1;
          end
          if (header_pointer == 4) begin
            data_size_transaction <= fx32dma_data;
            if (fx32dma_data > buffer_size_current) begin
              error_fx32dma <= 1'b1;
            end
          end
        end
      end
      READ_DATA: begin
        m_axis_tvalid <= fx32dma_valid;
        m_axis_tdata <= fx32dma_data;
        if (fx32dma_valid == 1'b1) begin
          first_transfer <= 1'b0;
          if (data_size_transaction > 4) begin
            m_axis_tkeep <= 4'hf;
            m_axis_tlast <= 1'b0;
            data_size_transaction <= data_size_transaction - 4;
          end else begin
            m_axis_tlast <= 1'b1;
            eot_fx32dma <= 1'b1;
            case (data_size_transaction)
              1: m_axis_tkeep <= 4'h1;
              2: m_axis_tkeep <= 4'h3;
              3: m_axis_tkeep <= 4'h7;
              default: m_axis_tkeep <= 4'hf;
            endcase
          end
        end
        // monitor
        if (test_mode_active_tpm == 1'b1) begin
          if (first_transfer == 1) begin
            expected_data <= fx32dma_data;
          end else begin
            case (test_mode_tpm)
              4'h1: expected_data <= ~expected_data;
              4'h2: expected_data <= ~expected_data;
              4'h3: expected_data <= pn9(expected_data);
              4'h4: expected_data <= pn23(expected_data);
              4'h7: expected_data <= expected_data + 1;
              default:  expected_data <= 0;
            endcase
            if (expected_data != m_axis_tdata) begin
              monitor_error <= 1'b1;
            end else begin
              monitor_error <= 1'b0;
            end
          end
        end
      end
    endcase
  end

  always @(*) begin
    case (fifo_num)
      5'h0: buffer_size_current = fifo0_buffer_size;
      5'h1: buffer_size_current = fifo1_buffer_size;
      5'h2: buffer_size_current = fifo2_buffer_size;
      5'h3: buffer_size_current = fifo3_buffer_size;
      5'h4: buffer_size_current = fifo4_buffer_size;
      5'h5: buffer_size_current = fifo5_buffer_size;
      5'h6: buffer_size_current = fifo6_buffer_size;
      5'h7: buffer_size_current = fifo7_buffer_size;
      5'h8: buffer_size_current = fifo8_buffer_size;
      5'h9: buffer_size_current = fifo9_buffer_size;
      5'ha: buffer_size_current = fifoa_buffer_size;
      5'hb: buffer_size_current = fifob_buffer_size;
      5'hc: buffer_size_current = fifoc_buffer_size;
      5'hd: buffer_size_current = fifod_buffer_size;
      5'he: buffer_size_current = fifoe_buffer_size;
      5'hf: buffer_size_current = fifof_buffer_size;
      default: buffer_size_current = fifo0_buffer_size;
    endcase
    case (fifo_num)
      5'h0: header_size_current = fifo0_header_size;
      5'h1: header_size_current = fifo1_header_size;
      5'h2: header_size_current = fifo2_header_size;
      5'h3: header_size_current = fifo3_header_size;
      5'h4: header_size_current = fifo4_header_size;
      5'h5: header_size_current = fifo5_header_size;
      5'h6: header_size_current = fifo6_header_size;
      5'h7: header_size_current = fifo7_header_size;
      5'h8: header_size_current = fifo8_header_size;
      5'h9: header_size_current = fifo9_header_size;
      5'ha: header_size_current = fifoa_header_size;
      5'hb: header_size_current = fifob_header_size;
      5'hc: header_size_current = fifoc_header_size;
      5'hd: header_size_current = fifod_header_size;
      5'he: header_size_current = fifoe_header_size;
      5'hf: header_size_current = fifof_header_size;
      default: header_size_current = fifo0_header_size;
    endcase
  end

  // dma2fx3

  always @(posedge clk) begin
    if (reset == 1'b1 || error_dma2fx3 == 1'b1) begin
      state_dma2fx3 <= IDLE;
    end else begin
      state_dma2fx3 <= next_state_dma2fx3;
    end
  end

  always @(*) begin
    case(state_dma2fx3)
      IDLE:
        if(dma2fx3_ready == 1'b1) begin
          next_state_dma2fx3 = READ_DATA;
        end else begin
          next_state_dma2fx3 = state_dma2fx3;
        end
      READ_DATA:
        if(s_axis_tlast == 1'b1 || dma2fx3_counter >= buffer_size_current - 4) begin
          next_state_dma2fx3 = ADD_FOOTER;
        end else begin
          next_state_dma2fx3 = state_dma2fx3;
        end
      ADD_FOOTER:
        if(dma2fx3_eop == 1'b1) begin
          next_state_dma2fx3 = IDLE;
        end else begin
          next_state_dma2fx3 = state_dma2fx3;
        end
        default: next_state_dma2fx3 = IDLE;
    endcase
  end

  always @(posedge clk) begin
    case(state_dma2fx3)
      IDLE: begin
        dma2fx3_eop <= 1'b0;
        eot_dma2fx3 <= 1'b0;
        s_axis_tready <= 1'b0;
        footer_pointer <= 0;
        dma2fx3_counter <= 0;
        dma2fx3_valid <= 1'b0;
        case (test_mode_tpg)
          4'h1: dma2fx3_data <= 32'haaaaaaaa;
          default:  dma2fx3_data <= 32'hffffffff;
        endcase
      end
      READ_DATA: begin
        dma2fx3_eop <= 1'b0;
        eot_dma2fx3 <= 1'b0;
        footer_pointer <= 0;
        if (test_mode_active_tpg == 1'b1) begin
          s_axis_tready <= 1'b0;
          dma2fx3_valid <= 1'b1;
          if (dma2fx3_ready == 1'b1) begin
            dma2fx3_counter <= dma2fx3_counter + 4;
            case (test_mode_tpg)
              4'h1: dma2fx3_data <= ~dma2fx3_data;
              4'h2: dma2fx3_data <= ~dma2fx3_data;
              4'h3: dma2fx3_data <= pn9(dma2fx3_data);
              4'h4: dma2fx3_data <= pn23(dma2fx3_data);
              4'h7: dma2fx3_data <= dma2fx3_data + 1;
              default:  dma2fx3_data <= 0;
            endcase
          end
        end else begin
          dma2fx3_data <= s_axis_tdata;
          if (s_axis_tlast == 1'b0) begin
            s_axis_tready <= dma2fx3_ready;
          end else begin
            s_axis_tready <= 1'b0;
          end
          dma2fx3_valid <= s_axis_tvalid & s_axis_tready;
          if (s_axis_tvalid== 1'b1 && s_axis_tready == 1'b1) begin
            case (s_axis_tkeep)
              1: dma2fx3_counter <= dma2fx3_counter + 1;
              3: dma2fx3_counter <= dma2fx3_counter + 2;
              7: dma2fx3_counter <= dma2fx3_counter + 3;
              default: dma2fx3_counter <= dma2fx3_counter + 4;
            endcase
          end
        end
      end
      ADD_FOOTER: begin
        dma2fx3_valid <= ~eot_dma2fx3;
        dma2fx3_eop <= 1'b0;
        eot_dma2fx3 <= 1'b0;
        s_axis_tready <= 1'b0;
        footer_pointer <= footer_pointer + 4;
        case(footer_pointer)
          32'h0: dma2fx3_data <= 32'hf00ff00f;
          32'h4: dma2fx3_data <= dma2fx3_counter;
          32'h8: dma2fx3_data <= 32'h0;
          default: dma2fx3_data <= 32'h0;
        endcase
        if (footer_pointer == header_size_current - 4) begin
          dma2fx3_eop <= 1'b1;
          eot_dma2fx3 <= 1'b1;
        end
      end
    endcase
  end

endmodule
