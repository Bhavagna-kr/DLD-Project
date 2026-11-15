# Logic Design

## Binary power representation

`P = 8*P3 + 4*P2 + 2*P1 + P0`, where P3 is the most significant bit and P0 is the least significant bit.

## Threshold predicates

A threshold `Tk` is HIGH exactly when available power `P` is at least `k`.

| Signal | Predicate | Boolean expression |
|---|---|---|
| T3 | P ≥ 3 | P3 OR P2 OR (P1 AND P0) |
| T4 | P ≥ 4 | P3 OR P2 |
| T5 | P ≥ 5 | P3 OR [P2 AND (P1 OR P0)] |
| T7 | P ≥ 7 | P3 OR (P2 AND P1 AND P0) |
| T8 | P ≥ 8 | P3 |
| T9 | P ≥ 9 | P3 AND (P2 OR P1 OR P0) |
| T12 | P ≥ 12 | P3 AND P2 |

## Accepted-load equations

```text
A1 = R1 AND T5

A2 = R2 AND ((A1 AND T9) OR (NOT A1 AND T4))

A3 = R3 AND ((A1 AND A2 AND T12)
          OR (A1 AND NOT A2 AND T8)
          OR (NOT A1 AND A2 AND T7)
          OR (NOT A1 AND NOT A2 AND T3))
```

## Why the thresholds change

- L1 needs 5 units. Therefore it is accepted only when `R1=1` and `P≥5`.
- If L1 is accepted, L2 needs 4 more units, so the initial capacity must be at least 9. If L1 is not accepted, L2 needs only 4 units.
- L3 needs 3 units after previously accepted loads. The total initial-capacity threshold is 12 if L1 and L2 were accepted, 8 if only L1 was accepted, 7 if only L2 was accepted, and 3 if neither was accepted.

This is a greedy priority allocator with skip-and-continue behaviour. It is not the same as a simple one-hot tier selector.
