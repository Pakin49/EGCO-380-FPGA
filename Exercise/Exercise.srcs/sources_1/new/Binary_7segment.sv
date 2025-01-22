`timescale 1ns / 1ps

module Binary_7segment(
    input wire [3:0] in,
    output a,b,c,d,e,f,g  
    );
    segment_a seg_A(in,a);
    segment_b seg_B(in,b);
    segment_c seg_C(in,c);
    segment_d seg_D(in,d);
    segment_e seg_E(in,e);
    segment_f seg_F(in,f);
    segment_g seg_G(in,g);
    //...
endmodule

module segment_a(
    input wire[3:0] in,
    output logic out
    );

    always_comb begin
        case(in)
            4'b0000 : out = 1; //0
            4'b0001 : out = 0; //1
            4'b0010 : out = 1; //2
            4'b0011 : out = 1; //3
            4'b0100 : out = 0; //4
            4'b0101 : out = 1; //5
            4'b0110 : out = 1; //6
            4'b0111 : out = 1; //7
            4'b1000 : out = 1; //8
            4'b1001 : out = 1; //9
            default : out = 0; //Defualt
        endcase
    end
endmodule

module segment_b(
    input wire[3:0] in,
    output logic out
    );

    always_comb begin
        case(in)
            4'b0000 : out = 1; //0
            4'b0001 : out = 1; //1
            4'b0010 : out = 1; //2
            4'b0011 : out = 1; //3
            4'b0100 : out = 1; //4
            4'b0101 : out = 0; //5
            4'b0110 : out = 0; //6
            4'b0111 : out = 1; //7
            4'b1000 : out = 1; //8
            4'b1001 : out = 1; //9
            default : out = 0; //Defualt
        endcase
    end
endmodule

module segment_c(
    input wire[3:0] in,
    output logic out
    );

    always_comb begin
        case(in)
            4'b0000 : out = 1; //0
            4'b0001 : out = 1; //1
            4'b0010 : out = 0; //2
            4'b0011 : out = 1; //3
            4'b0100 : out = 1; //4
            4'b0101 : out = 1; //5
            4'b0110 : out = 1; //6
            4'b0111 : out = 1; //7
            4'b1000 : out = 1; //8
            4'b1001 : out = 1; //9
            default : out = 0; //Defualt
        endcase
    end
endmodule

module segment_d(
    input wire[3:0] in,
    output logic out
    );

    always_comb begin
        case(in)
            4'b0000 : out = 1; //0
            4'b0001 : out = 0; //1
            4'b0010 : out = 1; //2
            4'b0011 : out = 1; //3
            4'b0100 : out = 0; //4
            4'b0101 : out = 1; //5
            4'b0110 : out = 1; //6
            4'b0111 : out = 0; //7
            4'b1000 : out = 1; //8
            4'b1001 : out = 1; //9
            default : out = 0; //Defualt
        endcase
    end
endmodule

module segment_e(
    input wire[3:0] in,
    output logic out
    );

    always_comb begin
        case(in)
            4'b0000 : out = 1; //0
            4'b0001 : out = 0; //1
            4'b0010 : out = 1; //2
            4'b0011 : out = 0; //3
            4'b0100 : out = 0; //4
            4'b0101 : out = 0; //5
            4'b0110 : out = 1; //6
            4'b0111 : out = 0; //7
            4'b1000 : out = 1; //8
            4'b1001 : out = 0; //9
            default : out = 0; //Defualt
        endcase
    end
endmodule

module segment_f(
    input wire[3:0] in,
    output logic out
    );

    always_comb begin
        case(in)
            4'b0000 : out = 1; //0
            4'b0001 : out = 0; //1
            4'b0010 : out = 0; //2
            4'b0011 : out = 0; //3
            4'b0100 : out = 1; //4
            4'b0101 : out = 1; //5
            4'b0110 : out = 1; //6
            4'b0111 : out = 0; //7
            4'b1000 : out = 1; //8
            4'b1001 : out = 1; //9
            default : out = 0; //Defualt
        endcase
    end
endmodule

module segment_g(
    input wire[3:0] in,
    output logic out
    );

    always_comb begin
        case(in)
            4'b0000 : out = 0; //0
            4'b0001 : out = 0; //1
            4'b0010 : out = 1; //2
            4'b0011 : out = 1; //3
            4'b0100 : out = 1; //4
            4'b0101 : out = 1; //5
            4'b0110 : out = 1; //6
            4'b0111 : out = 0; //7
            4'b1000 : out = 1; //8
            4'b1001 : out = 1; //9
            default : out = 0; //Defualt
        endcase
    end
endmodule