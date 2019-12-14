/*:
 ## Animating a Sprite
 
 The code below sets up a basic scene with a black background, and a hero from a classic video game at bottom left.
 
 Read past this code section to learn how to animate a sprite to create the appearance of more realistic movement.
 
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

/*:
### Arrays

An [array](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html#ID107) is one of [three collection types](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html) provided by Swift.
 
 An array is an *ordered* collection of values – in other words, a list.
 
 ![Array Example](Arrays_2x.png)
 
 *Image from [Swift Language Guide](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html#ID107).*
 
 An array is very much like a string – something you're familiar with. As you know, a string is essentially a list of individual characters:
 
 ![String example](string-by-index.png)
 
 Sometimes it is convenient to refer to items when they are in a list.
 
 In this case, we need to use a list to refer to the images we'll use to animate a sprite walking.
 
 Why is that?
 
 Well – it's what the `SKAction` method that we want to use – [animate](https://developer.apple.com/documentation/spritekit/skaction/1417656-animate) – expects:
 
 ![animate](animate-with.png)
 
 We can see that the first parameter, *with*, expects an argument that is an array of `SKTexture` objects. How? By the square brackets.
 
 When we see a type like `SKTexture`, that means a single instance of `SKTexture`.
 
 When we see a type like `[SKTexture]`, that means an *array* of `SKTexture` objects. In other words – look for the square brackets.
 
 For more details on what the `animate` method on `SKAction` expects, [read the developer documentation](https://developer.apple.com/documentation/spritekit/skaction/1417656-animate) – it's very well written.
 
 So... long story short, our job is to create an array of the images we want to use to animate a video game hero moving to the right.
 
 If you expand this playground page and peek at the **Resources** subfolder, you'll see the two images we want to use:
 
 ![resources](resources.png)
 
 We want to create an array that looks like this:
 
 ![walking-images-array](walking_images_array.png)
 
 - Experiment:
 Uncomment the block of code below, then run the playground. This creates the array of images we need. Click the *Show Result* button at right, beside line 91. What do you see?
 
 ![show-result](show-result.png)
 
*/
// Create an empty array of SKTexture objects
var walkingTextures: [SKTexture] = []

// Now add the two images we need in the array
walkingTextures.append(SKTexture(imageNamed: "hero-walk-right-0"))
walkingTextures.append(SKTexture(imageNamed: "hero-walk-right-1"))


/*:
 Animation on a computer is very much like animation in a "flipbook".
 
 "You draw a successive sequence of images, and when you flip through them fast enough, it gives the illusion of movement."
 
 ![flipbook](flipbook.png)
 
 *Excerpt and image from [2D Apple Games by Tutorials](https://store.raywenderlich.com/products/2d-apple-games-by-tutorials).*
 
 That is exactly what we are now going to ask SpriteKit to do for us.

 - Experiment:
 Uncomment each block of code below. Run the playground. What happens?
 
 */

// Create an action to animate a walking motion using the hero sprites array (walkingTextures)
let actionWalkingAnimation = SKAction.animate(with: walkingTextures, timePerFrame: 0.2, resize: true, restore: true)

// Create an action that moves the hero forward a "step" where a step is 10 pixels
// NOTE: The time interval for moving forward matches the time per frame of the animation
let actionMoveForward = SKAction.moveBy(x: 10, y: 0, duration: 0.2)

// Repeat the move forward action twice
let actionMoveForwardTwice = SKAction.repeat(actionMoveForward, count: 2)

// Now, combine the walking animation with the sprite moving forward
let actionWalkAndMove = SKAction.group([actionWalkingAnimation, actionMoveForwardTwice])

// Repeat the "walk and move" action five times
let actionWalkAndMoveFiveTimes = SKAction.repeat(actionWalkAndMove, count: 5)

// Make the hero walk and move forward five times
hero.run(actionWalkAndMoveFiveTimes)

/*:
 ### Exercise
 
 Animate a rocket blasting off into space.
 
 If you open the **Resources** subfolder, you'll find a series of images to work with:
 
 ![rocket](rocket-images.png)
 
 These rocket images [are used with permission](http://newsletters.livecode.com/october/issue120/newsletter2.php?a=NWS120) and the [complete list of video and audio assets can be found here](http://www.runrev.com/downloads/galactic-gauntlet.zip).
 
 Make the following happen in order:
 
 * Add a sprite based on the `rocket.png` file. Position the sprite on the right side of the scene, near the ground.
 * Create an `[SKTexture]` array using the images named `rocket_0.png` to `rocket_5.png` from the **Resources** folder.
 * Create an animation that will make the fireball below the rocket grow in size for second or two while the rocket remains stationary.
 * Then, make the rocket "blast off" and move up on the screen. The image should show fire under the rocket as the rocket moves (use `restore: false` when you create the animation in step 3).
 
 */

// Exercise: Write your code below
let rocket = SKSpriteNode(imageNamed: "rocket")
rocket.position = CGPoint(x: scene.size.width / 2 , y: rocket.size.height / 4)
scene.addChild(rocket)

var fireTextures: [SKTexture] = []
fireTextures.append(SKTexture(imageNamed: "rocket_0"))
fireTextures.append(SKTexture(imageNamed: "rocket_1"))
fireTextures.append(SKTexture(imageNamed: "rocket_2"))
fireTextures.append(SKTexture(imageNamed: "rocket_3"))
fireTextures.append(SKTexture(imageNamed: "rocket_4"))
fireTextures.append(SKTexture(imageNamed: "rocket_5"))

let actionFireAnimation = SKAction.animate(with: fireTextures, timePerFrame: 2, resize: true, restore: false)

let actionMoveUp = SKAction.moveBy(x: 0, y: 330, duration: 11)

let actionFireAndMove = SKAction.group([actionFireAnimation, actionMoveUp])

rocket.run(actionFireAndMove)

/*:
 
 [Previous: Working With Text](@previous) | Page 8 | [Next: Particle Effects](@next)
 
 */
