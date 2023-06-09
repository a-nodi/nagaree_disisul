/* CSED273 Final project */

`timescale 1ns / 1ps


module Decoder(
    input wire[2:0] cnt,
    input en,
    output wire [5:0] out
    );
    /*
    The decoder that selects chip based on count of input word length count 
    
    :input wire[2:0] cnt: selection input
    :input en: enable
    :output wire [5:0] out: 
    
    No initialization needed
    Synchronous module
    */
    
    and(out[0], ~cnt[2], ~cnt[1], cnt[0], en);
    and(out[1], ~cnt[2], cnt[1], ~cnt[0], en);
    and(out[2], ~cnt[2], cnt[1], cnt[0], en);
    and(out[3], cnt[2], ~cnt[1], ~cnt[0], en);
    and(out[4], cnt[2], ~cnt[1], cnt[0], en);
    and(out[5], cnt[2], cnt[1], ~cnt[0], en);
   
endmodule