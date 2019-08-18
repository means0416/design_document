
`timescale 1 ns / 1 ps

	module ip_conv_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 16
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
	wire slv_register0_lsb;
	wire slv_register1_lsb;
	wire [C_S00_AXI_DATA_WIDTH-1:0] s_axi_rdata;
	reg  [C_S00_AXI_DATA_WIDTH-1:0] axi_rdata;
	
// Instantiation of Axi Bus Interface S00_AXI
	ip_conv_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) ip_conv_v1_0_S00_AXI_inst (
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready),
		.slv_register0_lsb(slv_register0_lsb)
	);
	
	wire from_wen;
	wire from_we;
	wire ena_i;
	wire wea_i;
	wire [C_S00_AXI_ADDR_WIDTH-1:1] addra_i;
    wire [(C_S00_AXI_DATA_WIDTH/2)-1:0] dina_i;	
	wire ena_w;
	wire wea_w;
	wire [C_S00_AXI_ADDR_WIDTH-1:1] addra_w;
    wire [(C_S00_AXI_DATA_WIDTH/2)-1:0] dina_w;
    wire enb_f;
    wire [C_S00_AXI_ADDR_WIDTH-1:1] addrb_f;
    wire valid_f;
    wire [(C_S00_AXI_DATA_WIDTH/2)-1:0] doutb_f;	 
    wire valid_i;
    wire enb_i;
    wire [C_S00_AXI_ADDR_WIDTH-1:1] addrb_i;
    wire [(C_S00_AXI_DATA_WIDTH/2)-1:0] doutb_i;
    wire valid_w;
    wire enb_w;
    wire [C_S00_AXI_ADDR_WIDTH-1:1] addrb_w;
    wire [(C_S00_AXI_DATA_WIDTH/2)-1:0] doutb_w;
    wire ena_f;
    wire wea_f;
    wire [C_S00_AXI_ADDR_WIDTH-1:1] addra_f;
    wire [(C_S00_AXI_DATA_WIDTH/2)-1:0] dina_f;
    wire start;
    wire done;
    wire [C_S00_AXI_DATA_WIDTH-1:0] data_out; 
    reg [C_S00_AXI_ADDR_WIDTH-1:0] ext_axi_araddr_latched;   
	
	enwe_gen s00(
	   .iwval(s00_axi_wvalid),
       .wen(from_wen),
       .we(from_we)
       );
    
	addr_gen #(
	   .DATA_WIDTH(C_S00_AXI_DATA_WIDTH/2),
	   .ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	   )
	   s10(
	      .iclk(s00_axi_aclk),
	      .irst(s00_axi_aresetn),
	      .from_awval(s00_axi_awvalid),
	      .from_arval(s00_axi_arvalid),
	      .from_wval(s00_axi_wvalid),
	      .from_rval(s00_axi_rvalid),
	      .from_wen(from_wen),
	      .from_we(from_we),
	      .from_awaddr(s00_axi_awaddr),
	      .from_din(s00_axi_wdata[15:0]),
	      .from_araddr(s00_axi_araddr),
	      .from_valid(valid_f),
	      .from_dout(doutb_f),
	      .to_dout(data_out),
	      .to_wen_i(ena_i),
	      .to_we_i(wea_i),
	      .to_waddr_i(addra_i),
	      .to_din_i(dina_i),
	      .to_wen_w(ena_w),
	      .to_we_w(wea_w),
	      .to_waddr_w(addra_w),
	      .to_din_w(dina_w),
	      .to_ren(enb_f),
	      .to_raddr(addrb_f)
        );
        
	bramwrapper_input #(
	   .DATA_WIDTH(C_S00_AXI_DATA_WIDTH/2),
	   .ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	   )
	   s20(
	      .iclk(s00_axi_aclk),
	      .irst(s00_axi_aresetn),
	      .ena(ena_i),
	      .wea(wea_i),
	      .addra(addra_i),
	      .dina(dina_i),
	      .valid(valid_i),
	      .enb(enb_i),
	      .addrb(addrb_i),
	      .doutb(doutb_i)
          );             

	bramwrapper_weight #(
	   .DATA_WIDTH(C_S00_AXI_DATA_WIDTH/2),
	   .ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	   )
	   s21(
	      .iclk(s00_axi_aclk),
	      .irst(s00_axi_aresetn),
	      .ena(ena_w),
	      .wea(wea_w),
	      .addra(addra_w),
	      .dina(dina_w),
	      .valid(valid_w),
	      .enb(enb_w),
	      .addrb(addrb_w),
	      .doutb(doutb_w)
          );
     
 	bramwrapper_feature #(
	   .DATA_WIDTH(C_S00_AXI_DATA_WIDTH/2),
	   .ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	   )
	   s22(
	      .iclk(s00_axi_aclk),
	      .irst(s00_axi_aresetn),
	      .ena(ena_f),
	      .wea(wea_f),
	      .addra(addra_f),
	      .dina(dina_f),
	      .valid(valid_f),
	      .enb(enb_f),
	      .addrb(addrb_f),
	      .doutb(doutb_f)
          );
          
    conv_ctrlr #(
        .DATA_WIDTH(C_S00_AXI_DATA_WIDTH/2),
        .ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
        )
        s30(
           .iclk(s00_axi_aclk),
           .irst(s00_axi_aresetn),
           .valid_i_read(valid_i),
           .enb_i_read(enb_i),
           .addrb_i_read(addrb_i),
           .value_i_read(doutb_i),
           .valid_w_read(valid_w),
           .enb_w_read(enb_w),
           .addrb_w_read(addrb_w),
           .value_w_read(doutb_w),
           .ena_f_write(ena_f),
           .wea_f_write(wea_f),
           .addra_f_write(addra_f),
           .dina_f_write(dina_f),
           .start(start),
           .done(done)
           );       	        

	// Add user logic here
    assign start = slv_register0_lsb;    
    
    // data out muxing -----------------------------//
    always @(posedge s00_axi_aclk, negedge s00_axi_aresetn) begin
        if(!s00_axi_aresetn)
            ext_axi_araddr_latched <= 16'b0;
        else
        if(s00_axi_arvalid)
            ext_axi_araddr_latched <= s00_axi_araddr;
    end
    
    assign s00_axi_rdata = axi_rdata;
    
    always @(*) begin
        case (ext_axi_araddr_latched[15:12])
            4'h0 : axi_rdata = s_axi_rdata;
            4'h3 : axi_rdata = data_out;
            default : axi_rdata = 0;
        endcase
    end
	// User logic ends

	endmodule
