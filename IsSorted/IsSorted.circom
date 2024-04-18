pragma circom 2.1.6;

// include "./node_modules/circomlib/circuits/comparators.circom";

// Write a circuit that constrains the 4 input signals to be
// sorted. Sorted means the values are non decreasing starting
// at index 0. The circuit should not have an output.

template Num2Bits(n) {
    signal input in;
    signal output out[n];
    var lc1=0;

    var e2=1;
    for (var i = 0; i<n; i++) {
        out[i] <-- (in >> i) & 1;
        out[i] * (out[i] -1 ) === 0;
        lc1 += out[i] * e2;
        e2 = e2+e2;
    }

    lc1 === in;
}

template LessThan(n) {
    assert(n <= 252);
    signal input in[2];
    signal output out;

    component n2b = Num2Bits(n+1);

    n2b.in <== in[0]+ (1<<n) - in[1];

    out <== 1-n2b.out[n];
}


// N is the number of bits the input  have.
// The MSF is the sign bit.
template LessEqThan(n) {
    signal input in[2];
    signal output out;

    component lt = LessThan(n);

    lt.in[0] <== in[0];
    lt.in[1] <== in[1]+1;
    lt.out ==> out;
}

template IsSorted() {
    signal input in[4];

    component lte0 = LessEqThan(252);
    lte0.in[0] <== in[0];
    lte0.in[1] <== in[1];
    lte0.out === 1;

    component lte1 = LessEqThan(252);
    lte1.in[0] <== in[1];
    lte1.in[1] <== in[2];
    lte1.out === 1;

    component lte2 = LessEqThan(252);
    lte2.in[0] <== in[2];
    lte2.in[1] <== in[3];
    lte2.out === 1;

}

component main = IsSorted();
