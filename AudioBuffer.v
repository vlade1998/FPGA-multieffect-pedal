module AudioBuffer
#(parameter DATA_WIDTH=16, parameter BUFFER_WIDTH=15)
(
    input clk,
    input[(DATA_WIDTH-1):0] audio_data_right,
    input[(DATA_WIDTH-1):0] audio_data_left,
    input[(BUFFER_WIDTH-1): 0] read_shift,
    output wire[(DATA_WIDTH-1):0] data_read_right,
    output wire[(DATA_WIDTH-1):0] data_read_left
);

    reg[(2**BUFFER_WIDTH-1):0] address_counter ;

    always @ (negedge clk) begin
        address_counter  = address_counter + 1;
    end

    simple_dual_port_ram_single_clock #(.DATA_WIDTH(DATA_WIDTH*2), .ADDR_WIDTH(BUFFER_WIDTH)) 
    buffer_data(
        .data({audio_data_left, audio_data_right}),
        .read_addr(address_counter  - read_shift),
        .write_addr(address_counter ),
        .we(1),
        .clk(clk),
        .q({data_read_left,data_read_right})
    );

endmodule
