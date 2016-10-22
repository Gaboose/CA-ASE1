For both versions, we use counters for the state. We deduce the outputs by looking at the bits of the state counter. 

For the first version, we used a 4-bit counter for the state. Depending on the value of the counter, we decide whether the red, amber, or green light should be turned on. On each clock tick, the counter is incremented by one until it reaches the value of 8, then instead of going to 9, the state counter goes to 0 with modulus arithmetic.

There are 9 states accodring to the requirements:
0. Green
1. Green
2. Green
3. Amber
4. Red
5. Red
6. Red
7. Red
8. Amber


For the second version, we used a 3-bit counter for the state and a 16-bit register for the walkCounter.

We assumed that the walkRequest button press should increment the walkCounter only when the green light is on. The walkRequest is ignored when pressed at any other time.

We also assumed that the reset button can be pressed at any time. After every reset, the green light is turned on, the pedestrian light is switched to 'wait', and the walkCounter is reset to 0.

The default state before a valid walkRequest:
0. Green light, 'wait' pedestrian light.

There are 5 states after a valid walkRequest:
1. Amber light, 'wait' pedestrian light.
2. Red light, 'walk' pedestrian light.
3. Red light, 'walk' pedestrian light.
4. Red light, 'walk' pedestrian light.
5. Amber light, 'wait' pedestrian light.

On the clock tick after the 5th state, the state is reset back to the initial one (the state counter is set to 0) except the walkCounter stays the same.
