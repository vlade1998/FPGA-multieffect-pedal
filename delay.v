module delay
#(parameter DATA_WIDTH=16)
(
    input clk,
    input[(DATA_WIDTH-1):0] audio_right_in,
    input[(DATA_WIDTH-1):0] audio_left_in,
    output reg[(DATA_WIDTH-1):0] audio_right_out,
    output reg[(DATA_WIDTH-1):0] audio_left_out
);

    wire[(DATA_WIDTH-1):0] delayed_audio_left, delayed_audio_right;

    AudioBuffer #(.DATA_WIDTH(DATA_WIDTH)) audioBuffer(
        .clk(clk),
        .audio_data_right(audio_right_in),
        .audio_data_left(audio_left_in),
        .data_read_right(delayed_audio_right),
        .data_read_left(delayed_audio_left),
        .read_shift(1)
    );

    always @ (negedge clk) begin
        audio_right_out = audio_right_in + delayed_audio_right;
        audio_left_out = audio_left_in + delayed_audio_left;
    end

endmodule
