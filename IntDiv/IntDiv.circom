pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Create a circuit that is satisfied if `numerator`,
// `denominator`, `quotient`, and `remainder` represent
// a valid integer division. You will need a comparison check, so
// we've already imported the library and set n to be 252 bits.
//
// Hint: integer division in Circom is `\`.
// `/` is modular division
// `%` is integer modulus

template IntDiv(n) {
    signal input numerator;
    signal input denominator;
    signal input quotient;
    signal input remainder;

    

    // ex.
    // num = 13
    // den = 10
    // q = 1
    // r = 3

    // num/den = q + r/ den
    // num = (q * den) + r

    // a constraint for numerator
    numerator === (quotient * denominator) + remainder;

    // a constraint for remainder
    signal r;
    r <== LessThan(n)([remainder, denominator]);
    r === 1;

}

component main = IntDiv(252);
