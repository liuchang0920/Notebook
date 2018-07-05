# Physics

There are 2 separate physics engines: 一个3D, 一个2D
对应的组件有： Rigidbody, Rigidbody2D

## Rigidbody Overview

If one or more Collider components added, the gameobject is moved by incoming collisions.

Should not take over the movement of the gameobject it is attached to, should not try to move by changing the transform proerties such as position and rotation, instead, should apply forces to push gameobject and let the physics engine calculate the result.

* Kinematic: 额 没太弄懂
Non-physical motion produced from a script. This property removes the component fro mthe control of the physics engine and allow it to be moved kinematically from a script.

## Sleeping
when the rigidbody is moving slower than a minimum linear or rotation speed, the physics engine assumes it come to a halt, and turn it into sleep mode, no computing is on this, and it will update the rigidbody until it is "awoken".

## Colliders
Colliders componenets define the shape of an object for the purpose of physical collision.

3D:
* Box collider
* sphere collider
* capsule collider

2D:
* Box collider2d
* Circle collder2d

When creating a compond collider like this, there should be only one Rigidbody component, placed on the root object in the hierarchy

in 3D: 
use **Mesh Colliders** to match the shape of the object's mesh exactly.


#### Physics materials
Although the shape of colliders i snot deformed during collision, the friction and bounce can be configured using pysics materials. 

#### Triggers
Scripting system can detect when collisions occurs and initiate actions using the **OnCollisionEnter** function.