In this stage, your bot will be tested against some of the [Bratko-Kopec test](https://www.chessprogramming.org/Bratko-Kopec_Test) positions.

### Bratko-Kopec test

The [Bratko-Kopec test](https://www.chessprogramming.org/Bratko-Kopec_Test) is a famous test position set
used to evaluate chess engines.

To pass these tests, you'll need to implement more sophisticated move selection logic. Some approaches
you might consider:

- Material counting
- Position evaluation
- Simple search algorithms
- Pattern matching for tactical motifs

<!-- TODO: Isaac to review, we weren't super sure of this list -->

### Tests

Your bot will be tested against a selection of Bratko-Kopec test positions. It must find valid moves.

### Notes

- The positions will be complex tactical positions
- Your bot should aim to find moves that maintain material equality or gain material
- Simple material counting may not be sufficient - consider piece activity and position