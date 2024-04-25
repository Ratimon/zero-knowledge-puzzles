pragma circom 2.1.8;

include "../node_modules/circomlib/circuits/comparators.circom";

// Create a circuit that takes an array of signals `in[n]` and
// a signal k. The circuit should return 1 if `k` is in the list
// and 0 otherwise. This circuit should work for an arbitrary
// length of `in`.

template HasAtLeastOne(n) {
    signal input in[n];
    signal input k;
    signal output out;

    signal s[n];
    for (var i = 0; i < n; i++) {
       s[i] <== IsEqual()([in[i], k]);
    }

    // f(x) = 1 - x
    // g(x_n, x_n-1) = x_n * x_n-1
    // h(x) = 1 - x

    // [0,0,0] -> [1,1,1]  ->  1*1*1 = 1 -> 0
    // [1,1,1] -> [0,0,0]  ->  0*0*0 = 0 -> 1
    // [1,0,0] -> [0,1,1]   ->  0*1*1 = 0 -> 1

    signal m[n];
    m[0] <== 1 - s[0];

    for(var i = 1; i < n; i++){
        m[i] <== (1 - s[i]) * m[i - 1];
    }

    out <== 1 - m[n-1];

}

component main = HasAtLeastOne(4);
