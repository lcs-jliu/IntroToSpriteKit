/*:
 ## Music and Sound Effects
 
 No game or animation is complete without sound effects and background music.
 
 The code below sets up a basic scene with a black background, and a hero that will walk from a position at bottom left, while jumping twice along the way.
 
 Read past the scene setup code below to learn how to add sound effects, and then background music, to an animation.
  
 */

// Required frameworks
import PlaygroundSupport    // Allows playground to show live view
import SpriteKit            // Provides 2D graphics classes
import AVFoundation         // Provides classes to play audio files

// Define the animation size, scene, and scene color
let frame = CGRect(x: 0, y: 0, width: 400, height: 300)
var scene = SKScene(size: frame.size)

// Define, configure, and present the scene
let view = SKView(frame: frame)
view.showsNodeCount = true
view.presentScene(scene)

// Show the view in the live view area
PlaygroundSupport.PlaygroundPage.current.liveView = view

// Add an edge-loop physics body around the scene, so that the hero doesn't fall off the bottom of the scene
scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)

// Draw a hero, with a physics body, in the bottom left corner
let hero = SKSpriteNode(imageNamed: "hero")
hero.position = CGPoint(x: hero.size.width / 2, y: hero.size.height / 2)
hero.physicsBody = SKPhysicsBody(texture: hero.texture!,
                                 alphaThreshold: 0.5,
                                 size: hero.size)
scene.addChild(hero)

// Create an empty array of SKTexture objects
var walkingTextures: [SKTexture] = []

// Now add the two images we need in the array
walkingTextures.append(SKTexture(imageNamed: "hero-walk-right-0"))
walkingTextures.append(SKTexture(imageNamed: "hero-walk-right-1"))

// Create an action to animate a walking motion using the hero sprites array (walkingTextures)
let actionWalkingAnimation = SKAction.animate(with: walkingTextures, timePerFrame: 0.2, resize: true, restore: true)

// Create an action that moves the hero forward a "step" where a step is 10 pixels
// NOTE: The time interval for moving forward matches the time per frame of the animation
let actionMoveForward = SKAction.moveBy(x: 10, y: 0, duration: 0.2)

// Repeat the move forward action twice
let actionMoveForwardTwice = SKAction.repeat(actionMoveForward, count: 2)

// Now, combine the walking animation with the sprite moving forward
let actionWalkAndMove = SKAction.group([actionWalkingAnimation, actionMoveForwardTwice])

// Repeat the "walk and move" action ten times
let actionWalkAndMoveTenTimes = SKAction.repeat(actionWalkAndMove, count: 10)

// Create a sequence that waits for a second, then makes the hero jump
let actionBriefWait = SKAction.wait(forDuration: 1)
let moveUp = CGVector(dx: 0, dy: 20)
let actionJump = SKAction.applyImpulse(moveUp, duration: 0.1)
var sequenceWaitThenJump = SKAction.sequence([actionBriefWait, actionJump])
var actionWaitThenJumpRepeatedTwice = SKAction.repeat(sequenceWaitThenJump, count: 2)

// Combine the walking forward action with the action that makes the character jump twice
var actionWalkAndJump = SKAction.group([actionWalkAndMoveTenTimes, actionWaitThenJumpRepeatedTwice])

// Actually make the hero walk and jump
hero.run(actionWalkAndJump)

/*:
 ### Sound effects
 
 It's common for character actions in a video game to be associated with a sound effect.
 
 - Experiment:
    Uncomment the block of code below.
 
    Read the comments.
 
    Predict what will happen.
 
    Then run the playground and see if your prediction was accurate.
 */

// Remove all existing actions tied to the hero
// NOTE: This causes the hero to disappear if walking sequence is interrupted, so...
hero.removeAllActions()

// ... re-set the hero's image back to the starting texture
let originalHeroImage = SKTexture(imageNamed: "hero")
let actionSetToOriginalTexture = SKAction.setTexture(originalHeroImage)
hero.run(actionSetToOriginalTexture)

// Add an action that plays a jump sound effect
let actionJumpSoundEffect = SKAction.playSoundFileNamed("jump.wav", waitForCompletion: false)

// Revise the wait then jump sequence (to include the new sound effect action, played just before the jump)
sequenceWaitThenJump = SKAction.sequence([actionBriefWait, actionJumpSoundEffect, actionJump])

// Re-set the repeated wait-then-jump sequence (to use the revised jump sequence that now includes the sound effect)
actionWaitThenJumpRepeatedTwice = SKAction.repeat(sequenceWaitThenJump, count: 2)

// Re-set the walk-while-jumping sequence (now with sound effect)
actionWalkAndJump = SKAction.group([actionWalkAndMoveTenTimes, actionWaitThenJumpRepeatedTwice])

// Have the hero run the revised action (now with sound effect)
hero.run(actionWalkAndJump)

/*:
 The above code is longer than it really needs to be, since it revises actions already assigned to the hero.
 
 To summarize... to play a sound effect in a SpriteKit animation within a playground, just:
 
 1. Copy the desired sound effect into the playground page's **Resources** folder:
 
 ![copy-sound-file-resources](copy-sound-file-resources.png)
 
 2. Create an instance of `SKAction` that tells SpriteKit to play the sound file:
 
 - Example:
    `let actionJumpSoundEffect = SKAction.playSoundFileNamed("jump.wav", waitForCompletion: false)`
 
 3. Use the action in whatever combination of actions you need to achieve your desired animation effect. Typically, this means playing the sound effect just before the action you want it to be associated with:
 
 - Example:
    `let sequenceWaitThenJump = SKAction.sequence([actionBriefWait, actionJumpSoundEffect, actionJump])`
 
 4. Remember that to actually make an action, sequence, or group of actions happen – they need to be run on a node in the scene:
 
 - Example:
    `hero.run(sequenceWaitThenJump)`
 
 
*/


/*:
 
 ### Background Music
 
 For performance reasons, it is not advisable to use an `SKAction` instance to play a longer audio file.
 
 When playing longer audio files, like those used for background music, use the [`AVAudioPlayer` class](https://developer.apple.com/documentation/avfoundation/avaudioplayer).
 
 1. To use `AVAudioPlayer`, you must import another framework – this line of code should go at the top of your playground file:
 
        import AVFoundation
 
 2. Then, copy the background music file into the **Resources** folder.
 
 ![copy-background-music-in](copy-background-music-in.png)
 
 3. Remaining code to play background music is below, with explanatory comments. You can use the code below as a template for your own animation – adjust as necessary.
 
 - Callout(Listen):
    Uncomment the block of code below and listen to the results.
 
 */


// Create a variable to store a background music player instance
var backgroundMusic: AVAudioPlayer?

// Get a reference to the mp3 file in playground Resources folder
let backgroundMusicFilePath = Bundle.main.path(forResource: "game-level-background-music.mp3", ofType: nil)!

// Convert the file path string to a URL (Uniform Resource Locator)
let backgroundMusicFileURL = URL(fileURLWithPath: backgroundMusicFilePath)

// Attempt to open and play the file at the given URL
do {
    backgroundMusic = try AVAudioPlayer(contentsOf: backgroundMusicFileURL)
    backgroundMusic?.play()
} catch {
    // Do nothing if the sound file could not be played
}

/*:
 ### Useful Resources
 
 #### Sound Assets
 
 [The Sounds Resource](https://www.sounds-resource.com) has sound effects (like for a ray gun blast, jump sound effect, et cetera). Use the search box to find what you need.

 [RetroTracks](https://retro.sx) is a great resource for full-length background music from classic video games.

 [Audacity](https://www.fosshub.com/Audacity.html) is a reasonably capable open source app that is helpful for editing sound file clips, if needed.
  
 [Previous: Particle Effects](@previous) | Page 10 | [Next: Freestyle](@next)
 
 */
