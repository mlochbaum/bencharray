Tools for cross-language benchmarking. Because the operations to be
benchmarked are those that are important to BQN, results should not be
taken as a comparison of language performance as a whole, but might
indicate places where certain primitives can be sped up.

Each script reads metadata from /tmp/bencharray_meta and array contents
from /tmp/bencharray_data, then times the specified function, printing
an average time in seconds.

Metadata is:
- Function to run
- Number of arguments (1 or 2)
- Number of iterations
- Types and shapes of all arguments in sequence

Fancy timing statistics would remove variable costs such as amortized
memory management from the timings, so it's not used. At the same time,
it's better if benchmarks don't include the overhead of the part that
runs the function multiple times. Thus two functions are timed: first,
the fastest available function (typically a no-op), and then the
function to be benchmarked. The average time for one iteration is
measured for both, where an iteration consists of calling a function on
every set of arguments. The time to be printed is the difference of
these two results.

The possible types are u1, i8, i16, i32, and f64 (this is BQN-centric by
design). Array data is placed in /tmp/bencharray_meta in order, packing
bits into bytes in little-endian order for u1 and padding to the next
largest byte.
