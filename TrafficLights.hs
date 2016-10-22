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
    cnt = count4mod9 rst
    g = nor3 (cnt !! 0) (cnt !! 1) (and2 (cnt !! 2) (cnt !! 3))
    a = nor2 (cnt !! 1) g
    r = cnt !! 1

count4mod9 reset = [x0,x1,x2,x3]
  where
    x0 = dff (mux1 (or2 reset xis9) y0 zero)
    x1 = dff (mux1 (or2 reset xis9) y1 zero)
    x2 = dff (mux1 (or2 reset xis9) y2 zero)
    x3 = dff (mux1 (or2 reset xis9) y3 zero)

    (c0,y0) = halfAdd x0 c1
    (c1,y1) = halfAdd x1 c2
    (c2,y2) = halfAdd x2 c3
    (c3,y3) = halfAdd x3 one

    xis9 = x0

-- Counter-light correspondance table:
---------------------------
-- Counter RAG WAIT WALK --
---------------------------
-- 000     001  1    0
-- 001     010  0    1
-- 010     100  0    1
-- 011     100  0    1
-- 100     100  0    1
-- 101     010  0    1

lights2 :: CBit a => a -> a -> (a, a, a, a, a, [a])
lights2 rst walkReq = (g, a, r, wait, walk, walkCount)
  where
    cnt = count3mod6 (or2 rst (and2 (inv walkReq) g))
    g = nor3 (cnt !! 0) (cnt !! 1) (cnt !! 2)
    a = and2 (inv (cnt !! 1)) (cnt !! 2)
    r = nor2 g a
    wait = inv walk
    walk = r
    walkCount = reg 16 (or2 rst (and2 walkReq g)) (mux1w rst (inc16 walkCount) (boolword 16 zero))


count3mod6 reset = [x0,x1,x2]
  where
    x0 = dff (mux1 (or2 reset xis5) y0 zero)
    x1 = dff (mux1 (or2 reset xis5) y1 zero)
    x2 = dff (mux1 (or2 reset xis5) y2 zero)

    (c0,y0) = halfAdd x0 c1
    (c1,y1) = halfAdd x1 c2
    (c2,y2) = halfAdd x2 one

    xis5 = and2 x0 x2

inc16 [x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15] = [y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15]
  where
    (c0,y0) = halfAdd x0 c1

    (c1,y1) = halfAdd x1 c2
    (c2,y2) = halfAdd x2 c3
    (c3,y3) = halfAdd x3 c4
    (c4,y4) = halfAdd x4 c5
    (c5,y5) = halfAdd x5 c6
    
    (c6,y6) = halfAdd x6 c7
    (c7,y7) = halfAdd x7 c8
    (c8,y8) = halfAdd x8 c9
    (c9,y9) = halfAdd x9 c10
    (c10,y10) = halfAdd x10 c11

    (c11,y11) = halfAdd x11 c12
    (c12,y12) = halfAdd x12 c13
    (c13,y13) = halfAdd x13 c14
    (c14,y14) = halfAdd x14 c15
    (c15,y15) = halfAdd x15 one
     


