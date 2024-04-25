pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Use the same constraints from IntDiv, but this
// time assign the quotient in `out`. You still need
// to apply the same constraints as IntDiv

template IntDivOut(n) {
    signal input numerator;
    signal input denominator;
    signal output out;

    remainder <-- numerator % denominator;
    quotient <-- numerator \ denominator;

    // a constraint for numerator
    numerator === (quotient * denominator) + remainder;

    // a constraint for remainder
    signal r;
    r <== LessThan(n)([remainder, denominator]);
    r === 1;

    // assign return value to be quotient
    // returning a value only applies from circuit to circuit. not the outside world
    out <-- quotient;

}

component main = IntDivOut(252);
