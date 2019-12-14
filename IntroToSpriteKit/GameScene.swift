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
        
        // Add a tree to the background
        let tree = SKSpriteNode(imageNamed: "Tree_1")
        tree.position = CGPoint(x: background.size.width / 10, y: startGroundTile.size.height + tree.size.height / 2)
        self.addChild(tree)
        
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
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
