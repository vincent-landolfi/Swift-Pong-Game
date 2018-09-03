//
//  MenuVC.swift
//  Pong
//
//  Created by Vincent Landolfi on 2017-04-18.
//  Copyright © 2017 Vincent Landolfi. All rights reserved.
//

import Foundation
import UIKit

enum gameType {
    case easy
    case medium
    case hard
    case player2
}

class MenuVC : UIViewController {
    
    @IBAction func Player(_ sender: AnyObject) {
        moveToGame(game: .player2)
    }
    
    @IBAction func Easy(_ sender: AnyObject) {
        moveToGame(game: .easy)
    }
    
    @IBAction func Medium(_ sender: AnyObject) {
        moveToGame(game: .medium)
    }
    
    @IBAction func Hard(_ sender: AnyObject) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game: gameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
