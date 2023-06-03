/* CSED273 FInal project */

`timescale 1ns / 1ps


module Decoder(
    input wire[2:0] cnt,
    output wire [5:0] out
    );
    
    
    and(out[0], ~cnt[2], ~cnt[1], cnt[0]);
    and(out[1], ~cnt[2], cnt[1], ~cnt[0]);
    and(out[2], ~cnt[2], cnt[1], cnt[0]);
    and(out[3], cnt[2], ~cnt[1], ~cnt[0]);
    and(out[4], cnt[2], ~cnt[1], cnt[0]);
    and(out[5], cnt[2], cnt[1], ~cnt[0]);
   
endmodule