pragma circom 2.1.8;

include "../node_modules/circomlib/circuits/comparators.circom";

// Write a circuit that constrains the 4 input signals to be
// sorted. Sorted means the values are non decreasing starting
// at index 0. The circuit should not have an output.

template IsSorted() {
    signal input in[4];

    component lte0 = LessEqThan(252);
    component lte1 = LessEqThan(252);
    component lte2 = LessEqThan(252);


    lte0.in[0] <== in[0];
    lte0.in[1] <== in[1];
   

    lte1.in[0] <== in[1];
    lte1.in[1] <== in[2];
    

    lte2.in[0] <== in[2];
    lte2.in[1] <== in[3];

    lte0.out === 1;
    lte1.out === 1;
    lte2.out === 1;

}

component main = IsSorted();
