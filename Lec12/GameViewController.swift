//
//  GameViewController.swift
//  Lec12
//
//  Created by hackeru on 17 Sivan 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // we've looked at the story board and seen that the main View in this UIViewController
        // is of type SKView
        // so we can do the following:
        let v = view as! SKView // because i'm sure of it , i could have write self.view
    
        // we would like to instinitate a Sceane (which is a screen in the game), a game is very similar to a movie, the game screen is allways moving
        // So , Init A Scene
        // our view has a frame and the frame has its size
        let size = self.view.frame.size // every view has a size, it's its rectengular size
        let scene = GameScene(size: size)
       
        // in games, the screen is always redrewn
        // we can get the Frames Per second rate to show on screen, but
        // don't leave it on for the APP Store!!!!!!!!!
        // for debug pupos only !!!!!!!!!!!!!!!!!!!!!!!!!!!
        v.showsFPS = true
        v.showsNodeCount = true
        
        // change the background color
        scene.backgroundColor = UIColor.orange
        
        // Show the Scene
        v.presentScene(scene)
        //
        
    
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
