pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Write a circuit that returns true when at least one
// element is 1. It should return false if all elements
// are 0. It should be unsatisfiable if any of the inputs
// are not 0 or not 1.

template MultiOR(n) {
    signal input in[n];
    signal output out;

    // a constraint that forces inputs element to be only 0 or 1
    for (var i = 0; i < n; i++) {
        in[i] * (1 - in[i]) === 0;
    }

    // f(x) = 1 - x
    // g(x_n, x_n-1) = x_n * x_n-1
    // h(x) = 1 - x

    // [0,0,0] -> [1,1,1]  ->  1*1*1 = 1 -> 0
    // [1,1,1] -> [0,0,0]  ->  0*0*0 = 0 -> 1
    // [1,0,0] -> [0,1,1]   ->  0*1*1 = 0 -> 1

    signal s[n];
    s[0] <== 1 - in[0];

    for(var i = 1; i < n; i++){
        s[i] <== (1 - in[i]) * s[i - 1];
    }

    out <== 1 - s[n-1];


}

component main = MultiOR(4);
