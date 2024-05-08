pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Be sure to solve IntSqrt before solving this 
// puzzle. Your goal is to compute the square root
// in the provided function, then constrain the answer
// to be true using your work from the previous puzzle.
// You can use the Bablyonian/Heron's or Newton's
// method to compute the integer square root. Remember,
// this is not the modular square root.


function intSqrtFloor(x) {
    // compute the floor of the
    // integer square root

    if(x == 0 || x == 1) {
        return x;
    }

    var i = 1;
    var result = 1;

    while(result <= x) {
        i += 1;
        result = i * i;
    }

    return i - 1;

}

template IntSqrtOut(n) {
    signal input in;
    signal output out;

    out <-- intSqrtFloor(in);
    // constrain out using your
    // work from IntSqrt

    // in === out * out;

    signal product1;
    signal o1;
    product1 <-- ( out - 1 ) * ( out - 1 );
    o1 <== LessThan(252)( [product1, in ]);
    o1 === 1;

    // (b + 1)(b + 1) > a
    signal product2;
    signal o2;
    product2 <-- ( out + 1 ) * ( out + 1 );
    o2 <== LessThan(252)( [in, product2 ] );
    o2 === 1;

}

component main = IntSqrtOut(252);


