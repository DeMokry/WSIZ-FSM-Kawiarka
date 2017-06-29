// wyjœcia zale¿a jedynie od aktualnego stanu
// przejœcia stanu s¹ synchroniczne

module maszyna_moore
(
	input	clk, dane_in, reset,
	output reg [1:0] dane_out
); // cztero-stanowa maszyna moore'a
	
	// deklaracju stanu rejestru
	reg		[1:0]state;
	
	// deklaracja stanów
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
	
	// output zale¿y jedynie od stanów
	always @ (state) begin
		case (state)
			S0:
				dane_out = 2'b01;
			S1:
				dane_out = 2'b10;
			S2:
				dane_out = 2'b11;
			S3:
				dane_out = 2'b00;
			default:
				dane_out = 2'b00;
		endcase
	end
	
	// ustalanie kolejnego stanu
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			case (state)
				S0:
					state <= S1;
				S1:
					if (data_in)
						state <= S2;
					else
						state <= S1;
				S2:
					if (data_in)
						state <= S3;
					else
						state <= S1;
				S3:
					if (data_in)
						state <= S2;
					else
						state <= S3;
			endcase
	end
	
endmodule
