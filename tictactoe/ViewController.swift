//
//  ViewController.swift
//  tictactoe
//
//  Created by Jianan Li on 1/28/19.
//  Copyright © 2019 Jianan Li. All rights reserved.
//

import UIKit
import TouchVisualizer

class ViewController: UIViewController {

    @IBOutlet var cellButtons: [UIButton]!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func didTapCell(_ sender: UIButton) {
        if t3.gameIsRunning {
            // For debugging purpose, print button tag
            // Should be one of 0 - 8
//            print(sender.tag)
            
            // Cell button start with alpha = 1 to be tappable
            // After tapped and before appearing, set alpha = 0
            sender.alpha = 0
            // then set backgroundImage
            sender.setBackgroundImage(UIImage(named: t3.tokenToBePlacedNext.rawValue), for: .normal)
            // then animate alpha to 1
            UIView.animate(withDuration: 0.3, animations: {
                sender.alpha = 1
            })
            
            // Make a move in the game
            t3.placeToken(at: sender.tag)
            print(t3!)
            
            // Check if game is over after the move
            if t3.gameIsOver {
                // Show reset button animation
                resetButton.alpha = 0;
                UIView.animate(withDuration: 0.7, animations: {self.resetButton.alpha = 1})
            }
        }
    }
    
    @IBAction func didTapReset(_ sender: UIButton) {
        // Hide reset button animation
        UIView.animate(withDuration: 0.7, animations: {
            self.resetButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            self.resetButton.alpha = 0
        }, completion: { (finished) in
            self.resetButton.transform = CGAffineTransform(rotationAngle: 0)
        })
        
        // Hide cell button and clear background image animation
        UIView.animate(withDuration: 0.7, animations: {
            for button in self.cellButtons {
                button.alpha = 0
            }
        }, completion: { (finished) in
            for button in self.cellButtons {
                button.setBackgroundImage(nil, for: .normal)
                button.alpha = 1
            }
        })
        
        // Reset game
        t3.resetGame()
    }
    
    var t3: T3!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Initialize model
        t3 = T3()
        
        // Touch visualizer setup
        var config = Configuration()
        config.color = #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1)
        Visualizer.start(config)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

}

