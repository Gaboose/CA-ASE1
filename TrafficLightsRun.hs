module TrafficLightsRun where
import HDL.Hydra.Core.Lib
import TrafficLights

main :: IO ()
main =  do
  runLights testdata1
  runLights2 testdata2


testdata1 :: [[Int]]
testdata1 =
-----------------------------------
-- rst     light
-----------------------------------
  [[1], -- undefined
   [0], -- green
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
   [1], -- red
   [0], -- green
   [0], -- green
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


testdata2 :: [[Int]]
testdata2 =
--------------------------------------------------
-- rst        light            pedestrian light --
--------------------------------------------------
  [[1, 0], -- undefined        undefined
   [0, 0], -- green            wait
   [0, 0], -- green            wait
   [0, 1], -- green (request!) wait
   [0, 1], -- amber            wait
   [0, 1], -- red              *walk*
   [1, 0], -- red   (reset!)   *walk*
   [0, 0], -- green            wait
   [0, 0], -- green            wait
   [0, 0], -- green            wait
   [0, 0], -- green            wait
   [0, 1], -- green (request!) wait
   [0, 0], -- amber            wait
   [0, 0], -- red              *walk*
   [0, 0], -- red              *walk*
   [0, 0], -- red              *walk*
   [0, 0], -- amber            wait
   [0, 0], -- green            wait
   [0, 0], -- green            wait
   [0, 0]] -- green            wait

runLights2 :: [[Int]] -> IO ()
runLights2 input = runAllInput input output
  where
-- Extract input signals from the input data
    rst = getbit input 0
    walkReq = getbit input 1
-- Connect the inputs and output signals to the circuit
    (g,a,r,wait,walk,walkCount) = lights2 rst walkReq
-- Format the output signals
    output =
      [string "rst=", bit rst,
       string " walkReq=", bit walkReq,
       string "   Output",
       string " g=", bit g,
       string " a=", bit a,
       string " r=", bit r,
       string " wait=", bit wait,
       string " walk=", bit walk,
       string " walkCount=", bindec 1 walkCount]
