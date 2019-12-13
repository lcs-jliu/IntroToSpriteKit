/*:
 ## Actions
 
 Immediately below is code similar to what we have explored on prior pages.
 
 Read this section of code briefly – from the comments, you should be able to follow what is happening.
 
 Please ask questions, if you do not follow what you are reading.
 */

// Required frameworks
import PlaygroundSupport    // Allows playground to show live view
import SpriteKit            // Provides 2D graphics classes

// Define the animation size and scene
let frame = CGRect(x: 0, y: 0, width: 400, height: 320)
var scene = SKScene(size: frame.size)

// Define, configure, and present the scene
let view = SKView(frame: frame)
view.showsNodeCount = true
view.presentScene(scene)

// Show the view in the live view area
PlaygroundSupport.PlaygroundPage.current.liveView = view

// Add an edge loop physics body to the scene, so nodes with physics bodies do not fall off the screen
scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)

// Add four circle nodes, with physics bodies, spaced along the bottom edge of the frame

// First circle
let circle1 = SKSpriteNode(imageNamed: "circle")
circle1.position = CGPoint(x: 50, y: 40)
circle1.physicsBody = SKPhysicsBody(circleOfRadius: circle1.size.width * 0.5)
scene.addChild(circle1)

// Second circle
let circle2 = SKSpriteNode(imageNamed: "circle")
circle2.position = CGPoint(x: 150, y: 40)
circle2.physicsBody = SKPhysicsBody(circleOfRadius: circle2.size.width * 0.5)
scene.addChild(circle2)

// Third circle
let circle3 = SKSpriteNode(imageNamed: "circle")
circle3.position = CGPoint(x: 250, y: 40)
circle3.physicsBody = SKPhysicsBody(circleOfRadius: circle3.size.width * 0.5)
scene.addChild(circle3)

// Fourth circle
let circle4 = SKSpriteNode(imageNamed: "circle")
circle4.position = CGPoint(x: 350, y: 40)
circle4.physicsBody = SKPhysicsBody(circleOfRadius: circle4.size.width * 0.5)
scene.addChild(circle4)


/*:
 ### Assigning actions and sequences
 
 An *action* is "an animation that is executed by a node in a scene".
 
 There is a [long list of actions](https://developer.apple.com/documentation/spritekit/skaction/action_initializers) that can be assigned to a node.
 
 These actions can run as:
 
 * "one offs"
 
 or
 

 * a *sequence* of actions to run one after another
 
 or
 
 * as a *group* of actions to run on a node all at the same time
 
 or
 
 * as some combination of all of the above
 
 Have a look through the actions defined below.
 
 - Experiment:
     Run the playground. What happens?
 
 */

// Define an action that causes a node to wait (do nothing)
let actionFiveSecondWait = SKAction.wait(forDuration: 5.0)

// Define a vector that describes an upward movement
let upThisMuch = CGVector(dx: 0, dy: 250)

// Define an action that causes a node to move up for half a second
let actionUpwardsMovement = SKAction.move(by: upThisMuch, duration: 0.5)

/*:
 
 It is not enough to simply *define* actions.
 
 We must assign those actions to nodes that will run them.
 
 - Experiment:
     Uncomment the blocks of code below, one block at a time. Run the playground after uncommenting each block.
  
 Remember that you can select a block of code by positioning your cursor at the left edge of the first line, then hold down the **Shift** key, then press the **↓** key.
  
 Once you have selected the block of code, press the **Command** and / keys at the same time to toggle the comments off all at once.
 
 */

// 1. Make the first circle move up immediately (runs a single action, once)
circle1.run(actionUpwardsMovement)

// Define a sequence that involves a:
// * five second wait
// * moving upward
let actionShortWaitThenMoveUp = SKAction.sequence([actionFiveSecondWait, actionUpwardsMovement])

// 2. Make the second circle wait for five seconds, then move up
circle2.run(actionShortWaitThenMoveUp)

// Define a sequence that involves a:
// * five second wait
// * another five second wait
// * moving upward
let actionLongerWaitThenMoveUp = SKAction.sequence([actionFiveSecondWait, actionFiveSecondWait, actionUpwardsMovement])

// 3. Make the third circle wait for 10 seconds, then move up
circle3.run(actionLongerWaitThenMoveUp)

// 4. Make the fourth circle move up every five seconds
let actionRepeatWaitThenJump = SKAction.repeatForever(actionShortWaitThenMoveUp)
circle4.run(actionRepeatWaitThenJump)

// 5. Make the third circle wait for 15 seconds, then both fade in and out, and then both expand and contract in size

// Grouped actions to get larger and fade out
let actionScaleUp = SKAction.scale(by: 2.0, duration: 2)
let actionFadeOut = SKAction.fadeOut(withDuration: 2)
let actionScaleUpAndFadeOut = SKAction.group([actionScaleUp, actionFadeOut])

// Grouped actions to get small and fade in
let actionScaleDown = SKAction.scale(by: 0.5, duration: 2)
let actionFadeIn = SKAction.fadeIn(withDuration: 2)
let actionScaleDownAndFadeIn = SKAction.group([actionScaleDown, actionFadeIn])

// Run the grouped actions as a sequence
let actionFadeOutThenIn = SKAction.sequence([actionScaleUpAndFadeOut, actionScaleDownAndFadeIn])

// Make the fade out then fade in run forever
let repeatFadeOutThenIn = SKAction.repeatForever(actionFadeOutThenIn)

// Finally, make the sequence that programs a 15 second wait, then the repeated fading
let waitAndThenRepeatedlyFadeOutAndIn = SKAction.sequence([actionFiveSecondWait, actionFiveSecondWait, actionFiveSecondWait, repeatFadeOutThenIn])

// Now run the sequence on the third circle
circle3.run(waitAndThenRepeatedlyFadeOutAndIn)


/*:
 ### Exercises
 
 Review the example code provided above. Then, write code to complete each of the following tasks.
 
 1. Make the first circle wait 20 seconds, then move to the right.
 2. Make the second circle wait 20 seconds, then move up and to the left.
 3. Make up a sequence of actions of your choice, then run them on a node of your choice. You might need to [consult the list of actions](https://developer.apple.com/documentation/spritekit/skaction/action_initializers) you can use.
 
 Remember to use autocomplete to your advantage:
 
 ![autocomplete](autocomplete.png)
 
 If autocomplete is not offering suggestions as shown, please quit Xcode, then reopen this project, and carry on.
 
 */

// Exercise 1: Write your code below.
let actionTwentySecondWait = SKAction.wait(forDuration: 2.0)
let RightThisMuch = CGVector(dx: 200, dy: 0)
let actionRightMovement = SKAction.move(by: RightThisMuch, duration: 0.5)

let actionWaitThenMoveRight = SKAction.sequence([actionTwentySecondWait, actionRightMovement])

circle1.run(actionWaitThenMoveRight)


// Exercise 2: Write your code below.
let MoveThisMuch = CGVector(dx: 300, dy :300)
let actionMovement = SKAction.move(by: MoveThisMuch, duration: 2)
let actionWaitThenMove = SKAction.sequence([actionTwentySecondWait, actionMovement])

circle2.run(actionWaitThenMove)

// Exercise 3: Write your code below.

/*:

 [Previous: Physics Engine](@previous) | Page 5 | [Next: Adding Nodes Repeatedly](@next)
 
 
 */
