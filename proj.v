`timescale 10ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.06.2017 19:34:48
// Design Name: 
// Module Name: proj
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


module przygotowanie_kway (input clk, input a, output k);
  localparam
    STATE_IDLE = 3'b000,   //oczekiwanie
    STATE_GW = 3'b001,     //grzenie wody
    STATE_MK = 3'b010,     //mielenie kway
    STATE_SK = 3'b100,      //sypanie kawy  
    STATE_ZW = 3'b110;      //zalewanie

  reg [2:0] state;
  reg [2:0] next_state;

  // logika przechodzenia stanow
  always @* begin
    case (state)
      STATE_IDLE: begin
        if (a) begin
          next_state = STATE_GW;
        end else begin
          next_state = state;
        end
      end
      STATE_GW: begin
          next_state = STATE_MK;
        end
      STATE_MK: begin
          next_state = STATE_SK;
        end
      STATE_ZW: begin
        next_state = STATE_IDLE;  
      end
      default: next_state = state;
    endcase
  end

  //  next state
  always @(posedge clk) begin
    if (!a) begin
      state <= STATE_IDLE;
    end else begin
      state <= next_state;
    end
  end

  // wyjscie (w przyszlosci do sygnalu konczenia pracy)
  assign k = state[0];

endmodule
