//
//  LineUpBaskObj.swift
//  JSON
//
//  Created by Miguel Paolo Bravo on 3/9/18.
//  Copyright © 2018 Miguel Paolo Bravo. All rights reserved.
//

import UIKit

class LineUpBaskObj: NSObject {

    var PGposition: String!
    var SGposition: String!
    
    var SFposition: String!
    var PFposition: String!
    
    var Gposition: String!
    var Fposition: String!
    
    var Cposition: String!
    var Uposition: String!
    
    var salaryTotal: Double!
    var fantasyPointsTotal: Double!
    
    init(pg: String,
         sg: String,
         g: String,
         sf: String,
         pf: String,
         f: String,
         c: String,
         u: String,
         salary: Double,
         fantasyPoints: Double) {
        
        self.PGposition = pg
        self.SGposition = sg
        
        self.SFposition = sf
        self.PFposition = pf
        
        self.Gposition = g
        self.Fposition = f
        
        self.Cposition = c
        self.Uposition = u
        
        self.salaryTotal = salary
        self.fantasyPointsTotal = fantasyPoints
        
        super.init()
    }
    
    
}
