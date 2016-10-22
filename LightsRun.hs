module LightsRun where
import HDL.Hydra.Core.Lib
import Lights

main :: IO ()
main =  runLights testdata

testdata :: [[Int]]
testdata =
-----------------------------------
-- rst     light
-----------------------------------
  [[1], -- green
   [0], -- green
   [0], -- green
   [0], -- amber
   [0], -- red
   [0], -- red
   [0], -- red
   [0], -- red
   [0], -- amber
   [0], -- green
   [0], -- green
   [0], -- green
   [0], -- amber
   [0], -- red
   [1], -- green
   [0]] -- green

runLights :: [[Int]] -> IO ()
runLights input = runAllInput input output
  where
-- Extract input signals from the input data
    rst = getbit input 0
-- Connect the inputs and output signals to the circuit
    (g,a,r) = lights rst
-- Format the output signals
    output =
      [string "rst=", bit rst,
       string "   Output",
       string " g=", bit g,
       string " a=", bit a,
       string " r=", bit r,
       string "  (", bit g, bit a, bit r, string ")"]

