`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/14 15:56:29
// Design Name: 
// Module Name: addr_gen
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


module addr_gen #(
    parameter ADDR_WIDTH = 16,
    parameter DATA_WIDTH = 16
    )
    (
    input                               iclk,
    input                               irst,
    input                          from_wval,
    input                          from_rval,
    input                         from_awval,
    input                         from_arval,
    input                           from_ren,
    input                           from_wen,
    input                            from_we,
    input       [ADDR_WIDTH-1:0] from_awaddr,
    input       [DATA_WIDTH-1:0]    from_din,
    input       [ADDR_WIDTH-1:0] from_araddr,
    input                         from_valid,
    input       [DATA_WIDTH-1:0]   from_dout,
    output reg                      to_wen_i,
    output reg                       to_we_i,
    output reg [ADDR_WIDTH-1:0]   to_waddr_i,
    output reg [DATA_WIDTH-1:0]     to_din_i,
    output reg                      to_wen_w,
    output reg                       to_we_w,
    output reg [ADDR_WIDTH-1:0]   to_waddr_w,
    output reg [DATA_WIDTH-1:0]     to_din_w,
    output reg                        to_ren,
    output reg [ADDR_WIDTH-1:0]     to_raddr,
    output reg [DATA_WIDTH-1:0]      to_dout
    );
    
    reg   [ADDR_WIDTH-1:0] s_axi_awaddr_latched;
    reg   [ADDR_WIDTH-1:0] s_axi_araddr_latched;
    wire  [ADDR_WIDTH-1:1] addra;
    // prevent unintended address from master------------//
    always @(posedge iclk, negedge irst) begin
        if(!irst)
            s_axi_awaddr_latched <= 16'b0;
        else if(from_awval)
            s_axi_awaddr_latched <= from_awaddr; 
    end
    
    always @(posedge iclk, negedge irst) begin
        if(!irst)
            s_axi_araddr_latched <= 16'b0;
        else if(from_arval)
            s_axi_araddr_latched <= from_araddr; 
    end
    //--------------------------------------------------//
    
    // write address muxing ----------------------------//
    always @(*) begin
        if(from_wval) begin
            if(s_axi_awaddr_latched [15:12] == 4'h1) begin
                to_wen_i   = from_wen;
                to_we_i    = from_we;
                to_waddr_i = s_axi_awaddr_latched[15:1];
                to_din_i   = from_din;
            end 
            else begin
                to_wen_i   = 0;
                to_we_i    = 0;
                to_waddr_i = 0;
                to_din_i   = 0;         
            end
        end
        else begin
            to_wen_i   = 0;
            to_we_i    = 0;
            to_waddr_i = 0;
            to_din_i   = 0;
        end          
    end
    
    always @(*) begin
        if(from_wval) begin
            if(s_axi_awaddr_latched [15:12] == 4'h2) begin
                to_wen_w   = from_wen;
                to_we_w    = from_we;
                to_waddr_w = s_axi_awaddr_latched[15:1];
                to_din_w   = from_din;
            end 
            else begin
                to_wen_w   = 0;
                to_we_w    = 0;
                to_waddr_w = 0;
                to_din_w   = 0;         
            end
        end
        else begin
            to_wen_w   = 0;
            to_we_w    = 0;
            to_waddr_w = 0;
            to_din_w   = 0;
        end          
    end       
    //--------------------------------------------------//
    
    // read address muxing------------------------------//
    always @(*) begin
        if(from_arval) begin
            if(s_axi_awaddr_latched [15:12] == 4'h3) begin
                to_ren   = from_arval;
                to_raddr = s_axi_awaddr_latched[15:1];
            end
            else begin
                to_ren   = 0;
                to_raddr = 0;
            end
        end
        else begin
            to_ren   = 0;
            to_raddr = 0;
        end
    end
    //--------------------------------------------------//
    
    // Data out control---------------------------------//
    always @(*) begin
        if(from_valid)
            to_dout = from_dout;
        else
            to_dout = 0;
    end
    //--------------------------------------------------//
    
endmodule
