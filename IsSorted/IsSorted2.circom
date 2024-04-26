pragma circom 2.1.8;

include "../node_modules/circomlib/circuits/comparators.circom";

// Write a circuit that constrains the 4 input signals to be
// sorted. Sorted means the values are non decreasing starting
// at index 0. The circuit should not have an output.

template IsSorted() {
    signal input in[4];

    signal a;
    // 0 , 1
    a <== GreaterEqThan(252)([in[3], in[2]]);

    signal b;
    b <== GreaterEqThan(252)([in[2], in[1]]);

    signal c;
    c <== GreaterEqThan(252)([in[1], in[0]]);

    a === 1;
    b === 1;
    c === 1;

}


component main = IsSorted();
