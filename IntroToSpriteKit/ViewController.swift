//
//  ViewController.swift
//  IntroToSpriteKit
//
//  Created by Russell Gordon on 2019-12-07.
//  Copyright © 2019 Russell Gordon. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change size of view
        // Grade 12 students:
        // 1. When ready to make screen recording, uncomment line 22 and comment out line 23
        // 2. Choose Product > Clean Build Folder to be sure Xcode picks up the window size change
        //self.skView.frame = NSRect(x: 0, y: 0, width: 1200, height: 900)
        self.skView.frame = NSRect(x: 0, y: 0, width: 800, height: 600)

        // Create a scene based on the GameScene class
        // Scene size is a bit smaller but will scale up to fill the window
        let sceneSize = CGSize(width: 800, height: 600)
        let scene = GameScene(size: sceneSize)
        scene.scaleMode = .aspectFill
        
        // Show frames per second in the view
        self.skView.showsFPS = true
        
        // Keep track of how many nodes (visual elements) are on screen
        // (The fewer nodes the better for performance reasons)
        self.skView.showsNodeCount = true
        
        // See physics bodies
        self.skView.showsPhysics = true
        
        // Present the scene (which is an instance of the GameScene class)
        skView.presentScene(scene)

    }
}

