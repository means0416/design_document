`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/14 15:56:29
// Design Name: 
// Module Name: enwe_gen
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


module enwe_gen(
    input iwval,
    input irval,
    
    output wen,
    output we,
    output oawval
    );
    
    assign we  = iwval ? 1 : 0;
    assign wen = iwval ? 1 : 0;

endmodule
