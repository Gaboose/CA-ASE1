module Lights where
import HDL.Hydra.Core.Lib
import HDL.Hydra.Circuits.Combinational
import HDL.Hydra.Circuits.Register

-- Counter-light correspondance table:
-----------------
-- Counter RAG --
-----------------
-- 0000    001
-- 0001    001
-- 0010    001
-- 0011    010
-- 0100    100
-- 0101    100
-- 0110    100
-- 0111    100
-- 1000    010

lights :: CBit a => a -> (a, a, a)
lights rst = (g, a, r)
  where
    cnt = counter rst
    g = nor3 (cnt !! 0) (cnt !! 1) (and2 (cnt !! 2) (cnt !! 3))
    a = nor2 (cnt !! 1) g
    r = cnt !! 1

-- 4-bit counter modulus 9
counter :: CBit a => a -> [a]
counter rst = c
  where
    c = mux1w rst (wlatch 4 next) zero4
    next = mux1w (msb c) plusone zero4
    (carry, plusone) = rippleAdd one (bitslice2 c zero4) -- can this be simplified?
    zero4 = (fanout 4 zero)