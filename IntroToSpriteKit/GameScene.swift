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
    
    // This function runs once to set up the scene
    override func didMove(to view: SKView) {
        
        // Setting an edge
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        // Set the background
        self.backgroundColor = .black
        let background = SKSpriteNode(imageNamed: "BG")
        background.position = CGPoint(x: background.size.width / 2, y: background.size.height / 2)
        self.addChild(background)
        
        //Add ground tiles into the animation
        let startGroundTile = SKSpriteNode(imageNamed: "groundTileStart")
        startGroundTile.position = CGPoint(x: startGroundTile.size.width / 2, y: startGroundTile.size.height / 2)
        self.addChild(startGroundTile)
        
        let endGroundTile = SKSpriteNode(imageNamed: "groundTileEnd")
        endGroundTile.position = CGPoint(x: background.size.width - endGroundTile.size.width / 2, y: endGroundTile.size.height / 2)
        self.addChild(endGroundTile)
        
        for i in 1...8 {
            let groundTile = SKSpriteNode(imageNamed: "groundTileMiddle")
            groundTile.position = CGPoint(x: groundTile.size.width / 2 + CGFloat(i) * groundTile.size.width , y: groundTile.size.height / 2)
            self.addChild(groundTile)
        }
        
        let backgroundPhysicsBodyLocation = CGRect(x: -1 * background.size.width / 2, y:  -1 * background.size.height / 2 + startGroundTile.size.height, width: background.size.width, height: 1) // relative to sprite's position
        background.physicsBody = SKPhysicsBody(edgeLoopFrom: backgroundPhysicsBodyLocation)
        
        // Make the scene snow all the time
        if let snow = SKEmitterNode(fileNamed: "Snow") {
            
            snow.position = CGPoint(x: background.size.width / 2, y: background.size.height)
            self.addChild(snow)
        }
        
        // Add a igloo to the background
        let igloo = SKSpriteNode(imageNamed: "Igloo")
        igloo.position = CGPoint(x: background.size.width - igloo.size.width / 2 - 10, y: startGroundTile.size.height + igloo.size.height / 2)
        self.addChild(igloo)
        
        // Add a physics body for the igloo
        igloo.physicsBody = SKPhysicsBody(texture: igloo.texture!, size: igloo.size)
        igloo.physicsBody?.isDynamic = false
        
        // Add a crystal to the background
        let crystal = SKSpriteNode(imageNamed: "Crystal")
        crystal.position = CGPoint(x: background.size.width / 2.5, y: startGroundTile.size.height + crystal.size.height / 2)
        self.addChild(crystal)
        
        // Add a animated snowman into the scene
        let snowman = SKSpriteNode(imageNamed: "iceman_01")
        snowman.position = CGPoint(x: background.size.width - igloo.size.width - 35, y: startGroundTile.size.height + snowman.size.height / 2)
        self.addChild(snowman)
        
        var snowmanTextures: [SKTexture] = []
        snowmanTextures.append(SKTexture(imageNamed: "iceman_01"))
        snowmanTextures.append(SKTexture(imageNamed: "iceman_02"))
        snowmanTextures.append(SKTexture(imageNamed: "iceman_04"))
        snowmanTextures.append(SKTexture(imageNamed: "iceman_05"))

        let actionSnowmanAnimation = SKAction.animate(with: snowmanTextures, timePerFrame: 0.5, resize: true, restore: true)
        let actionSnowmanAnimationRepeat = SKAction.repeat(actionSnowmanAnimation, count: 10)
        snowman.run(actionSnowmanAnimationRepeat)
        
        // Add a physics body for the snowman
        snowman.physicsBody = SKPhysicsBody(texture: snowman.texture!, size: snowman.size)
        snowman.physicsBody?.mass = 4
        
        // Make the snowman jump
        // Vector that allows an upward movement
        let moveUp = CGVector(dx: 0, dy: 700)
        
        // Actions that needed to achieve repeated jumping
        let actionUpwardsMovement = SKAction.move(by: moveUp, duration: 1)
        let actionWaitForTwoSeconds = SKAction.wait(forDuration: 2.0)
        let actionWaitThenJump = SKAction.sequence([actionWaitForTwoSeconds, actionUpwardsMovement])
        
        // Make the snowman jump 3 times
        let moveUpRepeat = SKAction.repeat(actionWaitThenJump, count: 3)
        snowman.run(moveUpRepeat)
        
        // Add a tree to the background
        let tree = SKSpriteNode(imageNamed: "Tree_1")
        tree.position = CGPoint(x: background.size.width / 7, y: startGroundTile.size.height + tree.size.height / 2)
        self.addChild(tree)
        
        // Drop candies from the top
        let actionSpawnCandy = SKAction.run(spawnCandy)
        let actionWait = SKAction.wait(forDuration: 0.3)
        let sequenceSpawnThenWait = SKAction.sequence([actionSpawnCandy, actionWait])
        let actionRepeatlyAddSand = SKAction.repeat(sequenceSpawnThenWait, count: 25)
        self.run(actionRepeatlyAddSand)
        
        // Get a reference to the mp3 file in the app bundle
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
    
    // This function will add a candy randomly
    func spawnCandy() {
        let n = Int.random(in: 1...9)
        
        let candy = SKSpriteNode(imageNamed: "candy\(n)")
        
        // Set the position of the candy
        let y = self.size.height - candy.size.height
        let x = CGFloat.random(in: 0...self.size.width)
        candy.position = CGPoint(x: x, y: y)
        
        // Add a physics body to candy
        candy.physicsBody = SKPhysicsBody(texture: candy.texture!, size: candy.size)
        candy.physicsBody?.restitution = 0.5
        candy.physicsBody?.usesPreciseCollisionDetection = true
        candy.physicsBody?.mass = 0.01
        self.addChild(candy)
    }
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
