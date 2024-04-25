pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Use the same constraints from IntDiv, but this
// time assign the quotient in `out`. You still need
// to apply the same constraints as IntDiv

template IntDivOut(n) {
    signal input numerator;
    signal input denominator;
    signal output out;

    signal quotient;
    signal remainder;

    remainder <-- numerator % denominator;
    quotient <-- numerator \ denominator;

    // a constraint for numerator
    numerator === (quotient * denominator) + remainder;

    // a constraint for remainder
    signal r;
    r <== LessThan(n)([remainder, denominator]);
    r === 1;

    // assign return value
    out <-- quotient;

}

component main = IntDivOut(252);
