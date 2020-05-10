//
//  Details.swift
//  Trivia App
//
//  Created by Sasi Raj on 10/05/20.
//

import Foundation

struct Details {
    var name:String
    var crickterName:String
    var flagColor = [String]()
    var currDate:String
    init(name:String,crickterName:String,flagColor:[String],currDate:String) {
        self.name = name
        self.crickterName = crickterName
        self.flagColor = flagColor
        self.currDate = currDate
    }
    
}
