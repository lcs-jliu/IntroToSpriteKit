//
//  GameScene.swift
//  IntroToSpriteKit
//
//  Created by Russell Gordon on 2019-12-07.
//  Copyright © 2019 Russell Gordon. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    // Background music player
    var backgroundMusic: AVAudioPlayer?
    
    /// This function runs once to set up the scene
    override func didMove(to view: SKView) {
        
        /// Setting an edge
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        /// Set the background
        
        // Default background
        self.backgroundColor = .black
        
        //Actual background
        let background = SKSpriteNode(imageNamed: "BG")
        background.position = CGPoint(x: background.size.width / 2, y: background.size.height / 2)
        self.addChild(background)
        
        /// Add ground tiles into the animation
        
        // Add the starting ground tile
        let startGroundTile = SKSpriteNode(imageNamed: "groundTileStart")
        startGroundTile.position = CGPoint(x: startGroundTile.size.width / 2, y: startGroundTile.size.height / 2)
        self.addChild(startGroundTile)
        
        // Add the ending ground tile
        let endGroundTile = SKSpriteNode(imageNamed: "groundTileEnd")
        endGroundTile.position = CGPoint(x: background.size.width - endGroundTile.size.width / 2, y: endGroundTile.size.height / 2)
        self.addChild(endGroundTile)
        
        // Add all the ground tile in the middle
        for i in 1...8 {
            let groundTile = SKSpriteNode(imageNamed: "groundTileMiddle")
            groundTile.position = CGPoint(x: groundTile.size.width / 2 + CGFloat(i) * groundTile.size.width , y: groundTile.size.height / 2)
            self.addChild(groundTile)
        }
        
        // Set the horizontal shelf of the ground tiles
        let backgroundPhysicsBodyLocation = CGRect(x: -1 * background.size.width / 2, y:  -1 * background.size.height / 2 + startGroundTile.size.height, width: background.size.width, height: 1)
        background.physicsBody = SKPhysicsBody(edgeLoopFrom: backgroundPhysicsBodyLocation)
        
        /// Make the scene snow all the time
        if let snow = SKEmitterNode(fileNamed: "Snow") {
            
            snow.position = CGPoint(x: background.size.width / 2, y: background.size.height)
            self.addChild(snow)
        }
        
        /// Add a igloo to the background
        let igloo = SKSpriteNode(imageNamed: "Igloo")
        igloo.position = CGPoint(x: background.size.width - igloo.size.width / 2 - 10, y: startGroundTile.size.height + igloo.size.height / 2)
        self.addChild(igloo)
        
        // Add a physics body and properities for the igloo
        igloo.physicsBody = SKPhysicsBody(texture: igloo.texture!, size: igloo.size)
        igloo.physicsBody?.isDynamic = false
        
        /// Add a crystal to the background
        let crystal = SKSpriteNode(imageNamed: "Crystal")
        crystal.position = CGPoint(x: background.size.width / 2.5, y: startGroundTile.size.height + crystal.size.height / 2)
        self.addChild(crystal)
        
        /// Add a animated snowman into the scene
        
        // Create the snowman and add it in the scene
        let snowman = SKSpriteNode(imageNamed: "iceman_01")
        snowman.position = CGPoint(x: background.size.width - igloo.size.width - 85, y: startGroundTile.size.height + snowman.size.height / 2)
        self.addChild(snowman)
        
        // Add a animation to the snowman
        var snowmanTextures: [SKTexture] = []
        snowmanTextures.append(SKTexture(imageNamed: "iceman_01"))
        snowmanTextures.append(SKTexture(imageNamed: "iceman_02"))
        snowmanTextures.append(SKTexture(imageNamed: "iceman_04"))
        snowmanTextures.append(SKTexture(imageNamed: "iceman_05"))

        let actionSnowmanAnimation = SKAction.animate(with: snowmanTextures, timePerFrame: 0.5, resize: true, restore: true)
        let actionSnowmanAnimationRepeat = SKAction.repeat(actionSnowmanAnimation, count: 10)
        snowman.run(actionSnowmanAnimationRepeat)
        
        // Add a physics body and properities for the snowman
        snowman.physicsBody = SKPhysicsBody(texture: snowman.texture!, size: snowman.size)
        snowman.physicsBody?.mass = 4
        
        // Make the snowman jump
        
        // Actions that needed to achieve repeated jumping
        let moveUp = CGVector(dx: 0, dy: 700)
        let actionUpwardsMovement = SKAction.move(by: moveUp, duration: 1)
        let actionWaitForTwoSeconds = SKAction.wait(forDuration: 2.0)
        let actionWaitThenJump = SKAction.sequence([actionWaitForTwoSeconds, actionUpwardsMovement])
        
        // Make the snowman jump 2 times
        let moveUpRepeat = SKAction.repeat(actionWaitThenJump, count: 2)
        snowman.run(moveUpRepeat)
        
        /// Add a tree to the background
        let tree = SKSpriteNode(imageNamed: "Tree_1")
        tree.position = CGPoint(x: background.size.width / 7, y: startGroundTile.size.height + tree.size.height / 2)
        self.addChild(tree)
        
        /// Drop candies from the top
        let actionSpawnCandy = SKAction.run(spawnCandy)
        let actionWait = SKAction.wait(forDuration: 0.3)
        let sequenceSpawnThenWait = SKAction.sequence([actionSpawnCandy, actionWait])
        let actionRepeatlyAddSand = SKAction.repeat(sequenceSpawnThenWait, count: 20)
        self.run(actionRepeatlyAddSand)
        
        /// Add greeting words on the animation
        
        // Action that will wait for 8 seconds
        let actionWaitEightSceonds = SKAction.wait(forDuration: 6.5)
        
        // Call the function to create an action
        let actionWordsHorizontalShelf = SKAction.run(horizontalShelf)
        
        // Wait for the candies to drop and then for edge
        let sequenceWaitThenFormEdge = SKAction.sequence([actionWaitEightSceonds, actionWordsHorizontalShelf])
        self.run(sequenceWaitThenFormEdge)
        
        // Add letters "Christmas" that will fall down from the top
        
        // Create letters "Christmas" and give basic properties to it
        let letters = SKLabelNode(fontNamed: "Chalkduster")
        letters.fontSize = 100
        letters.fontColor = .yellow
        letters.text = "Christmas"
        letters.position = CGPoint(x: 400, y: background.size.height + 10)

        // Add a physics body to the letters
        letters.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 500, height: 100), center: CGPoint(x: 0 ,y: 30))

        // Add the letters into the scene
        self.addChild(letters)
        
        // Add letters "Merry" that will fall down from the top
        
        // Call the function, which will add letters "Merry" into the scene to create an action
        let actionWaitNineSeconds = SKAction.wait(forDuration: 7.5)
        let actionDropLetters = SKAction.run(addLetters)
        let sequenceWaitThenDropLetters = SKAction.sequence([actionWaitNineSeconds, actionDropLetters])
        self.run(sequenceWaitThenDropLetters)
        
        /// Get a reference to the mp3 file in the app bundle
        let backgroundMusicFilePath = Bundle.main.path(forResource: "sleigh-bells-excerpt.mp3", ofType: nil)!
        
        // Convert the file path string to a URL (Uniform Resource Locator)
        let backgroundMusicFileURL = URL(fileURLWithPath: backgroundMusicFilePath)
        
        // Attempt to open and play the file at the given URL
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: backgroundMusicFileURL)
            backgroundMusic?.play()
        } catch {
            // Do nothing if the sound file could not be played
        }

    }
    
    /// This function will add a candy randomly
    func spawnCandy() {
        // Generate a random number based on the image names
        let n = Int.random(in: 1...9)
        
        let candy = SKSpriteNode(imageNamed: "candy\(n)")
        
        // Set the position of the candy
        let y = self.size.height - candy.size.height
        let x = CGFloat.random(in: 0...self.size.width)
        candy.position = CGPoint(x: x, y: y)
        
        // Add a physics body and properities to candy
        candy.physicsBody = SKPhysicsBody(texture: candy.texture!, size: candy.size)
        candy.physicsBody?.restitution = 0.5
        candy.physicsBody?.usesPreciseCollisionDetection = true
        candy.physicsBody?.mass = 0.01
        self.addChild(candy)
    }
    
    /// This function creates a edge loop for the wrods.
    func horizontalShelf() {
        // Set the horizontal shelf of the words
        let wordsPhysicsBodyLocation = CGRect(x: 0, y: self.size.height / 2 - 20, width: self.size.width, height: 1)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: wordsPhysicsBodyLocation)
    }
    
    /// This function creates letters "Merry"
    func addLetters() {
        
        // Create letters "Merry" and give basic properties to it
        let letters2 = SKLabelNode(fontNamed: "Chalkduster")
        letters2.fontSize = 100
        letters2.fontColor = .red
        letters2.text = "Merry"
        letters2.position = CGPoint(x: 400, y: self.size.height + 50)
        
        // Add a physics body to the letters
        letters2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 500, height: 100), center: CGPoint(x: 0 ,y: 30))
        
        // Add the letters into the scene
        self.addChild(letters2)
        
        // Show end credit
        let actionWaitTwoSeconds = SKAction.wait(forDuration: 2)
        let actionShowEndCredits = SKAction.run(ShowEndCredits)
        let actionWaitThenShowEndCredits = SKAction.sequence([actionWaitTwoSeconds, actionShowEndCredits])
        self.run(actionWaitThenShowEndCredits)
        
    }
    
    /// This function will remove everything and show end credits
    func ShowEndCredits() {

        // Remove everything from the screen
        self.removeAllChildren()
        // Add  the end credit
        let credit = SKLabelNode(fontNamed: "Arial")
        credit.fontSize = 50
        credit.fontColor = .white
        credit.text = "Brought to you by Jason Liu"
        credit.zPosition = 3
        credit.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(credit)
    }
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
