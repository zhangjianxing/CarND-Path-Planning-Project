# CarND-Path-Planning-Project-Write-Up

The car is able to drive at least 4.32 miles without incident..

### The car drives according to the speed limit.

I have set if the car is not too close to next car on the same lane, then 
slowly set the speed to 49.5, which is just below speed limit.

```c++
if (too_close){
     ...
}
else if (49.5-.224 < ref_vel && ref_vel < 49.5 + .224) {
    ref_vel = 49.5;
}
else if (ref_vel > 49.5) {
    ref_vel -= .224;
}
else if (ref_vel < 49.5) {
    ref_vel += .224;
}
```

### Max Acceleration and Jerk are not Exceeded.
From previous code, I changed the speed slowly by adding/subtracting spped
 by .224 in each iteration.

### Car does not have collisions.
I will keep monitoring the next car at the same lane. If the next car speed is 
lower than my current speed, I will slow down

```c++
if (car_speed > (current_lane_speed-2)) {
    ref_vel -= .224;
}
```

###The car stays in its lane, except for the time between changing lanes.
I create new variable `changing_lane`. If my car is `changing_lane==true`, then
I am free to change a lane. Otherwise, my car will stay in the same lane.

###The car is able to change lanes

If my next car is too close, I will seeking for changing lane. e.g. if 
`left_lane_empty && left_lane_speed > current_lane_speed`, I will try to change
to left lane. 

```c++
bool too_close = false;
bool left_lane_empty = lane > 0;
bool right_lane_empty = lane < 2;
double current_lane_speed = INFINITY;
double left_lane_speed = INFINITY;
double right_lane_speed = INFINITY;

// find value
...
    
if (too_close) {
    if (!changing_lane){
        if (left_lane_empty && left_lane_speed > current_lane_speed) {
            --lane;
            changing_lane = true;
        }
        else if (right_lane_empty && right_lane_speed > current_lane_speed) {
            ++lane;
            changing_lane = true;
        }
    }
    if (car_speed > (current_lane_speed-2)) {
        ref_vel -= .224;
    }
}
else ...
```

### There is a reflection on how to generate paths.
In simulator, there is a reflection on how to generate paths.