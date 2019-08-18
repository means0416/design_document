`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/14 15:56:29
// Design Name: 
// Module Name: conv_ctrlr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module conv_ctrlr #(
    parameter DATA_WIDTH = 16,
    parameter ADDR_WIDTH = 16
    )
    (
    input                            iclk,
    input                            irst,
    input                    valid_i_read,
    input  [DATA_WIDTH-1:0]  value_i_read,
    input                    valid_w_read,
    input  [DATA_WIDTH-1:0]  value_w_read,
    output                     enb_i_read,
    output [ADDR_WIDTH-1:0]  addrb_i_read,
    output                     enb_w_read,
    output [ADDR_WIDTH-1:0]  addrb_w_read,
    output                    ena_f_write,
    output                    wea_f_write,
    output [ADDR_WIDTH-1:0] addra_f_write,
    output [DATA_WIDTH-1:0]  dina_f_write
    );
    
    
    
    
endmodule
