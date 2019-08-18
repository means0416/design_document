`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/15 16:19:06
// Design Name: 
// Module Name: filter
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


module filter #(
    parameter DATA_WIDTH = 16
    )
    (
    input                              ivalid,
    input  signed [DATA_WIDTH-1:0]     ivalue,
    output signed [(DATA_WIDTH/2)-1:0] ovalue
    );
    
    assign ovalue = (ivalid)?ivalue:0;
    
endmodule
