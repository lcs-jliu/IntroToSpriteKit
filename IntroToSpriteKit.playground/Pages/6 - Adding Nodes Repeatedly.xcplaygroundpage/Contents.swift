/*:
 ## Adding Nodes Repeatedly
 
 Immediately below is code similar to what we have explored on prior pages.
 
 Read this section of code briefly – from the comments, you should be able to follow what is happening.
 
 Please ask questions, if you do not follow what you are reading.
 */

// Required frameworks
import PlaygroundSupport    // Allows playground to show live view
import SpriteKit            // Provides 2D graphics classes

// Define the animation size, scene, and scene color
let frame = CGRect(x: 0, y: 0, width: 400, height: 500)
var scene = SKScene(size: frame.size)
scene.backgroundColor = .gray

// Define, configure, and present the scene
let view = SKView(frame: frame)
view.showsNodeCount = true
view.presentScene(scene)

// Show the view in the live view area
PlaygroundSupport.PlaygroundPage.current.liveView = view

// Add an edge loop physics body to the scene, so nodes with physics bodies do not fall off the screen
scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)

// Slow down the force of gravity a bit in this scene
// This avoids problems with small, fast moving sand particles getting through a collision with another body when they shouldn't
scene.physicsWorld.gravity = CGVector(dx: 0, dy: -2)

// Add an hourglass node to the middle of the scene
let hourglass = SKSpriteNode(imageNamed: "wide-hourglass")
hourglass.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
hourglass.physicsBody = SKPhysicsBody(texture: hourglass.texture!,
                                 alphaThreshold: 0.5,
                                 size: hourglass.size)
scene.addChild(hourglass)

/*:
 ### Helper function
 
 The function below creates a single particle of sand.
 
 Review the function to understand how it works.
 
 */
// This function will add a sand sprite to the scene
func spawnSand() {

    // Create a node from the sand image
    let sand = SKSpriteNode(imageNamed: "sand")

    // Vertical position just above top of the scene
    let y = scene.size.height - sand.size.height

    // Horizontal position is random
    let x = CGFloat.random(in: 100...scene.size.width - 100)

    // Set the grain of sand's position
    sand.position = CGPoint(x: x, y: y)

    // Create a physics body for the grain of sand
    sand.physicsBody = SKPhysicsBody(circleOfRadius:
        sand.size.width/2)
    
    // Very low bounciness
    sand.physicsBody?.restitution = 0.01

    // Name the node
    sand.name = "sand"
    
    // Use precise collision detection (at some performance cost)
    sand.physicsBody?.usesPreciseCollisionDetection = true

    // Add node to the scene
    scene.addChild(sand)
}

/*:
 ### Using Actions to Invoke Functions
 
 We can use an action to invoke a function on a regular basis.
 
 - Experiment:
     Uncomment the block of code below. What happens?
 
 */

// Add 100 sand particles, one each second, for the next 50 seconds
let actionSpawnSandParticle = SKAction.run(spawnSand)
let actionWait = SKAction.wait(forDuration: 0.1)
let sequenceSpawnThenWait = SKAction.sequence([actionSpawnSandParticle, actionWait])
let actionRepeatlyAddSand = SKAction.repeat(sequenceSpawnThenWait, count: 300)
scene.run(actionRepeatlyAddSand)

/*:
 ### Exercises
 
 Review the example code provided above.
 
 1. Adjust the code that randomly positions the sand particles horizontally, so that the sand particles all fall into the hourglass.
 
 [Previous: Applying Actions to Nodes](@previous) | Page 6 | [Next: Working With Text](@next)
 
 */
