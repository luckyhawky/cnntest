# cnntest  for cicai



module cnntest #(
    parameter IMG_WIDTH_MAX = 1920, 
    parameter I2C_ADDR = 7'h5A      // 7-bit I2C address
)
(
    // --- Global Signals ---
    input  wire        clk,
    input  wire        rst_n,

    // --- Video Input Stream ---
    input  wire        i_valid,
    input  wire [7:0]  i_pixel,
    input  wire        i_vsync,

    // --- Feature Map Output Stream ---
    output reg         o_valid,
    output reg  [7:0]  o_feature,
    output reg         o_vsync,

    // --- I2C Configuration Interface ---
    input  wire        i2c_scl,
    inout  wire        i2c_sda
);

//==============================================================================
//
//==============================================================================

reg [7:0]  cfg_ctrl;
reg [15:0] cfg_img_width;
reg [7:0]  cfg_act_mode;
reg [7:0]  cfg_act_param;
reg [7:0]  cfg_pool_mode; 

reg [71:0] cfg_kernel_a;
reg [71:0] cfg_kernel_b;
reg        cfg_kernel_select; 

wire ip_en       = cfg_ctrl[0];
wire soft_reset  = cfg_ctrl[1];
wire auto_swap   = cfg_ctrl[4];

assign i2c_sda = 1'bz; //

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cfg_ctrl <= 8'h01; 
        cfg_img_width <= IMG_WIDTH_MAX; 
        cfg_act_mode <= 2'h0; 
        cfg_act_param <= 8'h0; 
        cfg_pool_mode <= 2'h0; 
        cfg_kernel_a <= 72'h0000010000FEFFFF01; 
        cfg_kernel_b <= 72'h0;
        cfg_kernel_select <= 1'b0;
    end else begin
        if (auto_swap && i_vsync) begin
             cfg_kernel_select <= ~cfg_kernel_select;
        end
    end
end
