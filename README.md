# Array language benchmarks

In-progress benchmark suite for array languages. Supports BQN primarily, with working but not-too-accurate cross-language interfaces to BQN, Dyalog APL, and J.

To use:

    $ ./benchmark.bqn help       # See options
    $ ./benchmark.bqn list       # See functions that can be benchmarked
    $ ./benchmark.bqn all arith  # Record and plot arithmetic benchmarks

![Arithmetic performance](output/plot/arith-summary.svg)
