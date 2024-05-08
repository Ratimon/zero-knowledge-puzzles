pragma circom 2.1.8;

// Create a circuit that takes an array of signals `in` and
// returns 1 if all of the signals are 1. If any of the
// signals are 0 return 0. If any of the signals are not
// 0 or 1 the circuit should not be satisfiable.

template MultiAND(n) {
    signal input in[n];
    signal output out;

    // a constraint that forces inputs element to be only 0 or 1
    for (var i = 0; i < n; i++) {
        in[i] * (1 - in[i]) === 0;
    }

    // g(x_n, x_n-1) = x_n * x_n-1

    // [0,0,0] -> 0*0*0 = 0
    // [1,1,1] -> 1*1*1 = 1
    // [1,0,0] -> 1*0*0 = 0

    signal s[n];
    s[0] <== in[0];

    for(var i = 1; i < n; i++){
        s[i] <== in[i] * s[i - 1];
    }

     out <== s[n-1];

}

component main = MultiAND(4);
