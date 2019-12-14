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
        
        // Add some decorations to the background
        
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
