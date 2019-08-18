`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/14 15:56:29
// Design Name: 
// Module Name: bramwrapper_feature
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


module bramwrapper_feature #(
    parameter DATA_WIDTH = 16,
    parameter ADDR_WIDTH = 16,
    parameter READ_LATENCY = 2
    )
    (
    input                    iclk,
    input                    irst,
    input                     ena,
    input                     wea,
    input  [ADDR_WIDTH-1:0] addra,
    input  [DATA_WIDTH-1:0]  dina,
    input                     enb,
    input  [ADDR_WIDTH-1:0] addrb,
    output                  valid,
    output [DATA_WIDTH-1:0] doutb
    );
    
    wire [10:0] addra_cut;
    wire [10:0] addrb_cut;
    reg [1:0] cstate, nstate; // cState : Current State, nState : next State
    reg en_to_blkmem;
    reg valid_to_ext;
    reg [1:0] wait_counter;
    wire tr_condition0;
    wire tr_condition1;      
    
    // address generation -----------------------//
    assign addra_cut = addra[10:0];
    assign addrb_cut = addrb[10:0];
    //-------------------------------------------//
    
blk_mem_gen_feature b0 (
  .clka(iclk),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra_cut),  // input wire [10 : 0] addra
  .dina(dina),    // input wire [15 : 0] dina
  .clkb(iclk),    // input wire clkb
  .enb(enb),      // input wire enb
  .addrb(addrb_cut),  // input wire [10 : 0] addrb
  .doutb(doutb)  // output wire [15 : 0] doutb
);
    // state definition---------------------------//
    localparam IDLE  = 2'b00,
                WAIT = 2'b01,
                READ = 2'b10;
    //-------------------------------------------// 
    
    // transition condition definition-----------//
    assign tr_condition0 = (ena == 1'b1 && wea == 1'b0)? 1: 0;
    assign tr_condition1 = (wait_counter == (READ_LATENCY-1))? 1: 0;
    //-------------------------------------------//
    
    // valid definition--------------------------//
    assign valid = valid_to_ext;
    //-------------------------------------------//
     
    always @(posedge iclk, negedge irst) begin
        if(!irst)
            cstate <= IDLE;
        else
            cstate <= nstate;
    end
    
    always @(*) begin
        nstate = cstate;
        case(cstate)
            IDLE : begin
                if(tr_condition0) begin
                    if(READ_LATENCY == 1) 
                        nstate = READ;
                    else
                        nstate = WAIT;
                end
            end    
            WAIT : begin
                if (tr_condition1)
                    nstate = READ;
            end
            READ : begin
                nstate = IDLE;
            end
         endcase                
    end

    //Output signals
    always @(*) begin
        nstate = cstate;
        case(cstate)
            IDLE : begin
                en_to_blkmem = ena;
                valid_to_ext = 0;                
            end
            WAIT : begin
                en_to_blkmem = 1;
                valid_to_ext = 0;
            end
            READ : begin
                en_to_blkmem = 0;
                valid_to_ext = 1;
            end
        endcase    
     end
     
     //Clock count for WAIT state
     always @(posedge iclk, negedge irst)begin
        if(!irst)
            wait_counter <= 0;
        else
            if(cstate == WAIT)begin
                if(wait_counter == READ_LATENCY)
                    wait_counter <= 0;
                else 
                    wait_counter <= wait_counter + 1'b1;
            end
            else wait_counter <= 0;
     end
             
endmodule
