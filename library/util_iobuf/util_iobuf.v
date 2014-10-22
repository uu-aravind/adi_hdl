`timescale 1ns/100ps

module util_iobuf (
    I,
    O,
    T,
    IO
);

    parameter   BUS_WIDTH = 1;
    
    input       [BUS_WIDTH-1:0] I;
    output      [BUS_WIDTH-1:0] O;
    input       [BUS_WIDTH-1:0] T;
    inout       [BUS_WIDTH-1:0] IO;

    genvar i;

    generate
    for (i=0; i < BUS_WIDTH-1; i=i+1) begin : IOBUF_LOOP
        IOBUF u_iobuf_inst 
        (
            .I  (I[i]),       
            .T  (T[i]),     
            .IO (IO[i]),  
            .O  (O[i])       
        );
    end
    endgenerate
    
endmodule