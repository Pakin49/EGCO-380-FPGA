module multiplier_4x4_shift_add (
  input logic [3:0] a,
  input logic [3:0] b,
  output logic [7:0] product
);

  logic [7:0] partial_products [0:3];
  logic [7:0] accumulated_product;

  integer i;

  always_comb begin
    // Initialize partial products and accumulated product
    for (i = 0; i < 4; i++) begin
      partial_products[i] = 8'b0;
    end
    accumulated_product = 8'b0;

    // Generate partial products by shifting and ANDing
    for (i = 0; i < 4; i++) begin
      partial_products[i] = {4'b0, (a & {4{b[i]}})} << i; // Shift left by i ,   "{,}" is  concatination
    end

    // Accumulate the partial products
    for (i = 0; i < 4; i++) begin
      accumulated_product = accumulated_product + partial_products[i];
    end

    product = accumulated_product;
  end

endmodule