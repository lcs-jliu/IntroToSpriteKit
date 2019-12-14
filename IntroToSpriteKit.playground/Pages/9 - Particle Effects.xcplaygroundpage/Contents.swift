/*:
 ## Particle Effects
 
 The code below sets up a basic scene with a black background.

 A character from a classic video game is positioned in the lower left corner.
 
 Read past this code to learn how particle effects can be used to add some "sizzle" to your SpriteKit animations.
 
 */

// Required frameworks
import PlaygroundSupport    // Allows playground to show live view
import SpriteKit            // Provides 2D graphics classes

// Define the animation size, scene, and scene color
let frame = CGRect(x: 0, y: 0, width: 400, height: 300)
var scene = SKScene(size: frame.size)

// Define, configure, and present the scene
let view = SKView(frame: frame)
view.showsNodeCount = true
view.presentScene(scene)

// Add an edge-loop physics body around the scene, so that the character doesn't fall off the bottom of the scene
scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)

// Add the character to bottom left corner
let character = SKSpriteNode(imageNamed: "sf")
// Increase the character's size as the original image is very small
let actionScaleUp = SKAction.scale(by: 1.5, duration: 0)
character.run(actionScaleUp)
// Position at bottom left
character.position = CGPoint(x: 50, y: character.size.height * 1.5 / 2)
// Create physics body
character.physicsBody = SKPhysicsBody(texture: character.texture!, alphaThreshold: 0.5, size: character.size)
// Actually add to the scene
scene.addChild(character)

// Show the view in the live view area
PlaygroundSupport.PlaygroundPage.current.liveView = view

/*:
 ### An "Attack" Animation
 
 - Experiment:
    Uncomment the block of code below, then run the playground.
 
    You should see the character repeatedly making a motion.
 
 */
// Create [SKTexture] array
var throwFireBallTextures: [SKTexture] = []     // Empty array
throwFireBallTextures.append(SKTexture(imageNamed: "sf_fireball_0"))
throwFireBallTextures.append(SKTexture(imageNamed: "sf_fireball_1"))
throwFireBallTextures.append(SKTexture(imageNamed: "sf_fireball_2"))

// Create an action to animate throwing a fireball
let throwFireballAnimation = SKAction.animate(with: throwFireBallTextures, timePerFrame: 0.1, resize: true, restore: true)

// Wait a bit
let actionWaitASecond = SKAction.wait(forDuration: 1)

// Make a sequence – throw fireball, then wait
var actionThrowFireBallThenWait = SKAction.sequence([throwFireballAnimation, actionWaitASecond])

// Repeat the sequence
var throwFireBallRepeatedly = SKAction.repeatForever(actionThrowFireBallThenWait)

// Cause the character to throw the fireball
character.run(throwFireBallRepeatedly)

/*:
 Doesn't it look like the character should be throwing a fireball? Let's make that happen.

 ### Adding a Particle Emitter Node
 
 From the [developer documentation on `SKEmitterNode`](https://developer.apple.com/documentation/spritekit/skemitternode):
 
 A *particle emitter* "is a node that automatically creates and renders small particle sprites. Particles are privately owned by SpriteKit—your game cannot access the generated sprites. For example, you cannot add physics shapes to particles. Emitter nodes are often used to create smoke, fire, sparks, and other particle effects."
 
 A particle emitter that looks like a fireball (`Fire.sks`) has already been added to this playground's **Resources** folder. The code below uses that particle emitter.
 
 - Experiment:
    Uncomment the blocks of code below.  Read through the code that's been uncommented. Then, run the playground to see the results.
 
 */

// Add a method to the CGFloat type that converts from degrees to radians
// NOTE: Not strictly required, but makes it easier to think about how to rotate the particle emitter
extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180
    }
}

// Create an instance of the 'SKParticleEmitter' Node at the right edge of the character's arm
func generateFireball() {
    
    // Attempt to create an SKEmitterNode instance based on a file named "Fire.sks" (see Resources folder)
    if let fireball = SKEmitterNode(fileNamed: "Fire") {
        
        // Create the fireball at the tip of the character's arm
        fireball.position = CGPoint(x: character.position.x + 40, y: character.position.y + 27)
        
        // Make the fireball point to the right
        let actionRotate = SKAction.rotate(byAngle: CGFloat(90).toRadians(), duration: 0)
        fireball.run(actionRotate)
        
        // Add fireball to scene
        scene.addChild(fireball)
        
        // Move the fireball
        let actionMoveFireball = SKAction.moveTo(x: scene.size.width * 1.2, duration: 1.5)
        fireball.run(actionMoveFireball)
    }
    
}

// Create an action that calls the `generateFireball` method
let actionGenerateFireball = SKAction.run(generateFireball)

// Modify the actions in the actionThrowFireBallThenWait sequence to include the fireball generation action
actionThrowFireBallThenWait = SKAction.sequence([throwFireballAnimation, actionGenerateFireball, actionWaitASecond])

// Re-set the throwFireBallRepeatedly action using the revised sequence from line 122
throwFireBallRepeatedly = SKAction.repeatForever(actionThrowFireBallThenWait)

// Remove all existing actions tied to this node
// NOTE: This causes the character to disappear if the throwing fireball sequence is interrupted, so...
character.removeAllActions()

// ... re-set the character's image back to the starting texture
let originalCharacterImage = SKTexture(imageNamed: "sf")
let actionSetToOriginalTexture = SKAction.setTexture(originalCharacterImage)
character.run(actionSetToOriginalTexture)

// Add the revised actionThrowFireBallThenWait sequence and run repeatedly
character.run(throwFireBallRepeatedly)

/*:
### About Particle Effects
 
 You can add, and configure, new particle files.
 
 To do this, two-finger tap on the **IntroToSpriteKit** folder in this project, then choose **New File...**:
 
 ![new-file](new-file.png)
 
 In the sheet that appears, select the **macOS** tab, then **SpriteKit Particle File**:
 
 ![template-file-selection](template-file-selection.png)
 
 Then select whatever template suits your purposes – for now, select *Magic*, then press **Next**.
 
 On the final screen, choose a suitable file name – the default location is fine – then click **Create**:
 
 ![save-file](save-file.png)
 
 You will immediately be taken to a view that shows you the particle emitter with it's default settings.
 
 Show the **Inspectors** panel to adjust settings for the particle emitter:
 
 ![inspector](inspector.png)
 
 Experiment with the settings, but be sure to [also take a look at this document that explains the purpose of the various settings](https://www.hackingwithswift.com/read/11/7/special-effects-skemitternode) (be sure to scroll down a touch on the page to see the descriptions of what each setting does).
 
 Finally – but importantly – to use the particle emitter in a playground page – you'll need to copy it into the *Resources* folder. You can do this by holding down the **Option** key on your keyboard, then dragging up:
 
 ![option-drag](option-drag.png)
 
 ### Exercises
 
 Particle emitters can be used for a variety of purposes.
 
 1. Create a particle emitter that makes it look like a major snowstorm is occurring. Add it to this scene.
 
 */

// Exercise 1: Write your code below.

// Here is some starter code (assuming that your new particle emitter file is named "Snow.sks"

    if let snowstorm = SKEmitterNode(fileNamed: "Snow") {
        // Position the node and add to scene – write the code to make this happen
        snowstorm.position = CGPoint(x: scene.size.width / 2, y: scene.size.height)
        scene.addChild(snowstorm)
}




/*:

 [Previous: Animating a Sprite](@previous) | Page 9 | [Next: Music and Sound Effects](@next)
 
 */
