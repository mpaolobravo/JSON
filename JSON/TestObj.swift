//
//  TestObj.swift
//  JSON
//
//  Created by Miguel Paolo Bravo on 3/9/18.
//  Copyright © 2018 Miguel Paolo Bravo. All rights reserved.
//

import UIKit

class TestObj: NSObject {

    var playerName: String!
    var playerPosition: String!
    var salary: Double!
    var fantasyPoints: Double!
    
    init(playerName: String, playerPosition: String, salary: Double, fantasyPoints: Double) {
        
        self.playerName = playerName
        self.playerPosition = playerPosition
        self.salary = salary
        self.fantasyPoints = fantasyPoints
        
        super.init()
    }
    
    
}
