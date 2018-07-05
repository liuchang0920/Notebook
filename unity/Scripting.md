# Scripting

## Event functions

#### Regular update events
**update function** is called before the frame is rendered and also before animations are calculated

The Physic engine also updates in descrete time steps in a similar way to the frame  rendering. the function is called: **FixedUpdate**. You will get more accurate results from physics code if you place it in the FixedUpdate function rather than Update.

```
void FixedUpdate() {
	...
}
```

**LateUpdate**
sometimes it is useful to make addictional changes at ta point after the Update and Fixedupate, for example: a camera should remain trained on a traget object, the adjustment of the camera need to be made after the target object has moved.

```
void LateUpdate() {
	Camera.main.transform.LookAt(target.transform);
}

```

####Initialization events

**start** function is called before the first frame or physics update on an object. **Awake** is called for each object in the scene at the time when the scene loads.


#### GUI events

unity has a rendering GUI controls over main actions in the scene, and responding to clickes on theses controls. There could also be events that occur over a GameObject as it appears in the scene. such as: OnMouseOver, OnMouseDown.


```
void OnGUI() {
	GUI.label(..., ...);
}
```

####Physics events
The physics events will report collisions against an object by calling event functions on that object's script. OnCollisionEnter, OnCollisionStay, OnCollisionExit function will be called as contact is made, held, and broken. the corresponding OnTriggerEnter, OnTriggerStay, OnTriggerExit functions will be called when the object's collider is configure as a Trigger (a collider that simply detects whne something enters it rather than reactin physically). 

```
void OnCollisionEnter(otherObj: Collision) {
	if(otherObj.tag == "Arrow") {
		ApplyDamage(100);
	}
}
```

----

## Time and framerate management
An important thing to remember when handling time-based actions like this is that the game's framerate is not constant and neither is the length of time between Update function calls.

```

using UnityEngine;
using System.Collections;

public class ExampleScript : MonoBehaviour {
    public float distancePerFrame;
    
    void Update() {
        transform.Translate(0, 0, distancePerFrame);
    }
}

```

Given that the frame time is not constant, the object will appear to move at an irregular speed. The solution is to scale the size of the movement by the **frame time ** which you can read from the Time.deltaTime property:

```

using UnityEngine;
using System.Collections;

public class ExampleScript : MonoBehaviour {
    public float distancePerSecond;
    
    void Update() {
        transform.Translate(0, 0, distancePerSecond * Time.deltaTime);
    }
}

```

#### Fixed Timestep
todo

#### Maximum Allowed Timestep

todo

#### Time Scale

todo

For special effects, such as “bullet-time”, it is sometimes useful to slow the passage of game time so that animations and script responses happen at a reduced rate. 

Furthermore, you may want to freeze game time completely, as when the game is paused, Unity has a Time Scale property, that controls how fast game time proceeds relative to real time. If the scaule is set to 1.0, then the game time matches real time. A value of 2.0 makes time pass twice as quickly in Unity while a value of 0.5 will slow gameplay down to half speed. A value of zero will make time "stop" completely.

Other script functions are not affected by the time scale so you can, desplay a GUI with normal interaction when the game is paused.

eg:
```
using UnityEngine;
using System.Collections;

public class ExampleScript: MonoBehavior {
	
	void Pause() {
		Time.timeScale = 0;
	}
	
	void Resume() {
		Time.timeScale = 1;
	}
}

```


#### Capture Framerate

todo:

```
//C# script example
using UnityEngine;
using System.Collections;

public class ExampleScript : MonoBehaviour {
    // Capture frames as a screenshot sequence. Images are
    // stored as PNG files in a folder - these can be combined into
    // a movie using image utility software (eg, QuickTime Pro).
    // The folder to contain our screenshots.
    // If the folder exists we will append numbers to create an empty folder.
    string folder = "ScreenshotFolder";
    int frameRate = 25;
        
    void Start () {
        // Set the playback framerate (real time will not relate to game time after this).
        Time.captureFramerate = frameRate;
        
        // Create the folder
        System.IO.Directory.CreateDirectory(folder);
    }
    
    void Update () {
        // Append filename to folder name (format is '0005 shot.png"')
        string name = string.Format("{0}/{1:D04} shot.png", folder, Time.frameCount );
        
        // Capture the screenshot to the specified file.
        Application.CaptureScreenshot(name);
    }
}


```


----
## Creating and Destroying gameObjects

A gameObject can be created using  **Instantiate** function which makes a new copy of an existing object.

```
public GameObject enemy;

void Start() {
	for(int i=0;i<5;i++) {
		Instantiate(enemy);
	}
}
```

Note that the object from which the copy is made doesn't have to be presend in the scene. It is more common to use a prefab dragged to a public variable fro mthe project panel in the editor.

also instatiateing a gameobject will copy all components present on the original.


eg: distroy an object after the frame update has finished 
```
void OnCollisionEnter(Collision otherObj) {
    if (otherObj.gameObject.tag == "Missile") {
        Destroy(gameObject,.5f);
    }
}


```


**note** destroy function can destroy individual components without affecting the gameobject ifself. cannot do the following:

```
 Destroy(this);

```


## Coroutines
Normal functions must happen within a single frame update; afunction call can't be used to contain a procedural animation or a sequence of events over time. 

```
void Fade() {
    for (float f = 1f; f >= 0; f -= 0.1f) {
        Color c = renderer.material.color;
        c.a = f;
        renderer.material.color = c;
    }
}

```

As it stands, the Fade function will not have the effect you might expect. In order for the fading to be visible, the alpha must be reduced over a sequence of frames to show the intermediate values being rendered. However, the function will execute in its entirety within a single frame update. The intermediate values will never be seen and the object will disappear instantly.


  这个效果在一帧里就全部完成了
  
  Solution: use a coroutine for this kind of task
  
  A coroutine is like a function that has the ability to pause execution and return control to Unity but then to continue where it left off on the follwing frame.
  
  declare a coroutine like this:
  
```
  IEnumerator Fade() {
  	for(float f = 1f; f>= o;f -= 0.1f) {
  		Color c = renderer.material.color;
  		c.a = f;
  		renderer.material.color = c;
  		yeild return null;
  	}
  }
  
```
  
  ** a function declared with a return type of IEnumerator**, and the yield return statement included somewhere in the body.

To Set a croutine running, need to use the StartCoroutine function:

```
void Update() {
	if(Input.GetKeyDown("f")) {
		StartCoroutine("Fade");
	}
}
```

By default, a coroutine is resumed on the frame after it yields, but it is also possible to introduce a time delay using **WaitForSeconds**

```
IEnumerator Fade() {
	for(float f = 1f; f>=0;f -= 0.1f) {
		Color c = renderer.material.color;
		c.a = f;
		renderer.material.color = c;
		yeilf return new WaitForSeconds(0.1f);
	}
}

```

When a task doesn't need to be repreated quite so frequently, you can put it in a coroutine to get an update regularly, but not every single frame. 
  
 eg: warn the player if an enemy is nearby.
 
```
function ProximityCheck() {
    for (int i = 0; i < enemies.Length; i++) {
        if (Vector3.Distance(transform.position, enemies[i].transform.position) < dangerDistance) {
                return true;
        }
    }
    
    return false;
}


and call this function every 0.1 seconds

IEnumerator DoCheck() {
	for(;;) {
		ProximityCheck;
		yield return new WaitForSeconds(0.1f);
	}
}

```
  
## Namespace
项目规模大了以后，难以管理代码。要使用naming covention, 但是仍旧会 出现同名的情况，于是乎出现了namespace

```
namespace Enemy {
    public class Controller1 : MonoBehaviour {
        ...
    }
    
    public class Controller2 : MonoBehaviour {
        ...
    }
}


```

使用这个namespace下的类：
```
Enemy.Controller1

or

using Enemy;

```


## Attributes
Attributes are markers that can be placed above a class, property or function in a script to indicate special behavior.

eg:

```

[HideInInspector]
public float strength;
```

## Execution order of event functions
事件函数的执行顺序

#### First Scene Load

* Awake: gameobject active状态第一个执行的函数

* OnEnable: called after the object is enables, may be alevel is loaded or a gameobject with the script componenet is instantiated.

* OnLevelWasLoaded: a new level has been loaded然后执行


#### Editor
* reset: called to init the script's properties when it is first attached to the object and also when the Reset command is Used.

#### Before the first frame update
* start: called before the first frame update only if the script instance is enabled.

#### In between frames
* OnAppliationPause: called at the end of the frame where the pause is detected.
* OnApplicationPause: called to allow the game to show graphics that indictae the paused state.

#### Update order

* Fixedupdatea: called more frequently than Update. if can be called multiple times per frame. All phycis calculations and upates occur after fixedupdate.  **important: **, when applying movement calculation inside fixedupdate, need not to mulitply values by Time.deltaTime, because fixedupdate is called o na reliable timer, independent of frame rate!!
* update: once per frame, which is the main workhorse function for rame updates.
* Lateupdate: A common use for lateupdate would be following third-person camera. 


#### Rendering
* onPreCull: before the camera culls the scene.
* OnBecameVisible/OnBecameInvisible: called when object in/visible to any camera
* OnWillRenderObject: Called once for each camera if the object is visible.
* OnPreRender: Called before the camera starts rendering the scene.
* OnRenderObject: Called after all regular scene rendering is done. You can use GL class or Graphics.DrawMeshNow to draw custom geometry at this point.
* OnPostRender: Called after a camera finishes rendering the scene.
* OnRenderImage: Called after scene rendering is complete to allow post-processing of the image, see Post-processing Effects.

*OnGUI: Called multiple times per frame in response to GUI events. The Layout and Repaint events are processed first, followed by a Layout and keyboard/mouse event for each input event.

*OnDrawGizmos Used for drawing Gizmos in the scene view for visualisation purposes.


#### Coroutines
normal coroutines updates are run after update function returns. a coroutine is a function that can suspend its execution(yield) until the given yield instruction finishes.

各种各样的yeild:
* yield: update 结束以后调用 on the next frame
* yeild WaitForSeconds: continue after a specific time delay
* yeild waitForFixedupdate: after al fixedupdates has been callled on all scripts
* yield WWW, after a www download has completed
* yeild startCoroutine: chain a coroutine

#### When the object is destroyed
* OnDestroy: called after all frame updates for the last frame of the object's existence.

#### When quitting
* OnApplictionQuit: all game objects before the applictoin is quit.
* OnDisable: when the behavior becomes diabled or inactive.

Flowchart
![](monobehaviour_flowchart.svg)


## Understanding Automatic memory management
create object, get memory from Heap.

#### Value and refernce types
 the actual storage space for a large item is allocated from the heap and a small “pointer” value is used to remember its location. From then on, only the pointer need be copied during parameter passing. As long as the runtime system can locate the item identified by the pointer, a single copy of the data can be used as often as necessary.

 #### Allocation and garbage collection

 The memory manager keeps track of areas in the heap that it knows to be unused. 
 


 #### optimization

bad code: 

``` csharp
//C# script example
using UnityEngine;
using System.Collections;

public class ExampleScript : MonoBehaviour {
    void ConcatExample(int[] intArray) {
        string line = intArray[0].ToString();
        
        for (i = 1; i < intArray.Length; i++) {
            line += ", " + intArray[i].ToString();
        }
        
        return line;
    }
}


```

如果上面的函数放在update函数里面，会有性能问题

``` csharp
//C# script example
using UnityEngine;
using System.Collections;

public class ExampleScript : MonoBehaviour {
    public GUIText scoreBoard;
    public string scoreText;
    public int score;
    public int oldScore;
    
    void Update() {
        if (score != oldScore) {
            scoreText = "Score: " + score.ToString();
            scoreBoard.text = scoreText;
            oldScore = score;
        }
    }
}

```

``` csharp
//C# script example
using UnityEngine;
using System.Collections;

public class ExampleScript : MonoBehaviour {
    float[] RandomList(int numElements) {
        var result = new float[numElements];
        
        for (int i = 0; i < numElements; i++) {
            result[i] = Random.value;
        }
        
        return result;
    }
}



```
Since arrays can be very large, the free heap space could get used up rapidly, resulting in frequent garbage collections. One way to avoid this problem is to make use of the fact that an array is a reference type. An array passed into a function as a parameter can be modified within that function and the results will remain after the function returns. A function like the one above can often be replaced with something like:

``` csharp
//C# script example
using UnityEngine;
using System.Collections;

public class ExampleScript : MonoBehaviour {
    void RandomList(float[] arrayToFill) {
        for (int i = 0; i < arrayToFill.Length; i++) {
            arrayToFill[i] = Random.value;
        }
    }
}

```

## Platform dependent compilation
略

## Special forders and script compilation order
默认文件夹：
* Assets
* Editor
* Editor default resources
* Gizmos
* Plugins
* Resources
* Standard Assets
* StreamingAssets

The phases of compilation are as follows:

* Phase 1: Runtime scripts in folders called Standard Assets, Pro Standard Assets and Plugins.
* Phase 2: Editor scripts in folders called Editor that are anywhere inside top-level folders called Standard Assets, Pro Standard Assets and Plugins.
* Phase 3: All other scripts that are not inside a folder called Editor.
* Phase 4: All remaining scripts (those that are inside a folder called Editor).


## Script compilation and assembly definition files
略

## .NET profile support
略

## Referencing additional class library assemblies
略

## Stable scripting runtime: known limitations 

略

## Generic functions
泛型

``` csharp
void FuncName<T>();
```
In C#, it can save a lot of keystrokes and casts


## Script Serialization
略

## UnityEvents
UnityEvents are a way of allowing users driven callback to be persisted from edit time to run time with out the need for additional programming and script configuration.

用途:
* content driven callback
* decoupling system
* persistent callbacks
* preconfigured call events

When a unityEvent is added to a MonoBehavior it appears in the inspector and persistent calbacks can be added.

#### Using UnityEvents

When configuring a unityevent in the inspector there are two types of function calls that are supported:
* static: static calls are preconfigured calls, with preconfigured values that are set in the UI. This means that when the callback is involked, the target function is invoked with the argument that has been entered into the UI.
* Dynamic: invoked using an argument that is sent from code, and this is bound to the type of unityevent that is being invoked. The UI filters the callbacks and only shows the dynamic calls that are valid for the unityevent.

####Generic Unity Events
???

## Null reference exception

``` csharp
//c# example
using UnityEngine;
using System.Collections;

public class Example : MonoBehaviour {

    // Use this for initialization
    void Start () {
        GameObject go = GameObject.Find("wibble");
        Debug.Log(go.name);
    }

}

```

##### Null checks


#### Try/ catch blocks

``` cs

void Start() {
    try {
        myLight.color = Color.yellow;
    } catch (NullReferenceException ex) {
        Debug.Log("not set properly");
    }
}

```

## Important classes

* MonoBehavior: 
所有script的基类

* Transform: 
every game object has position, rotation, and scale in space(whether 3d or 2d), and they are represented by the Transform component. 

* Rigidbody/ Rigidbody2D:
most gameplay elements, the physics engine provides the easies set of tools for moving objects around, detecting triggers and collisions, and applying forces.


## Understanding vector arithmetic
dot product
点积

cross product??
叉积， 相当于两条向量为边的平行四边形的面积

## Direction and distance from one object to Another
其他的忽略


## Event System
事件系统：is a way of sending event to objects in the application based on input, be it keyboard, mouse, touch, or custom input. The event system consist of a few components that work together to send events.

#### Input Modules
Input module is where the main logic of how you want the event 
System to behave lives, they are used for 
* handling input
* managing event state
* sending events to scene objects

#### Raycasters

There are three provided raycasters:
* graphic raycaster -- used for UI elements
* physics 2D raycaster -- used for 2D physics elements
* physics raycaster -- used for 3D physics elements

## Messaging system
通信系统
略

## Input Modules

## Supported events

## Raycasters

* 后续的东西讲的不是很清楚，就没看了

