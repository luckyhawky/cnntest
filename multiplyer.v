//==============================================================================
// FILE: auc_multiply_8bit.v
// DESCRIPTION: 8x8 Multiplier
// 
//==============================================================================
module auc_multiply_8bit(
    input  [7:0] a,
    input  [7:0] b,
    output [15:0] res 
);

   
    wire [3:0] a_h = a[7:4];
    wire [3:0] a_l = a[3:0];
    wire [3:0] b_h = b[7:4];
    wire [3:0] b_l = b[3:0];

    
    wire [7:0] p_hh; // Weight 256
    wire [7:0] p_hl; // Weight 16
    wire [7:0] p_lh; // Weight 16
    wire [7:0] p_ll; // Weight 1
