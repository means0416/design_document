`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/15 14:43:50
// Design Name: 
// Module Name: out_mux
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


module out_mux #(
    parameter DATA_WIDTH = 16
    )
    (
    input iclk,
    input irst,
    input signed [DATA_WIDTH-1:0] y,
    input valid,
    output reg ena,
    output reg wea,
    output reg [10:0] addr_cnt, // out Q'ty
    output reg signed [DATA_WIDTH-1:0] dout
    );
    
    // address_couter ---------------------------//
    always @(posedge iclk, negedge irst) begin
        if(!irst)
            addr_cnt <= 0;
        else
        if(valid) begin 
            if(addr_cnt == 11'd1567) // feature Q'ty 28x28x2 = 1,568
                addr_cnt <= 0;
            else 
                addr_cnt <= addr_cnt + 1;   
        end
    end
    //------------------------------------------//
    
    always @(*) begin
        if(valid) begin
            ena = 1;
            wea = 1;
            dout = y;
        end
        else begin
            ena = 0;
            wea = 0;
            dout = 0;
        end        
    end
    
endmodule
