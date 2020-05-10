//
//  Cricketers.swift
//  Trivia App
//
//  Created by Sasi Raj on 10/05/20.
//

import Foundation
import UIKit

struct Cricketer {
    var name:String?
    var isSelected:Bool = false
    var image:UIImage
    
    init(name:String,isSelected:Bool,image:UIImage) {
        self.name = name
        self.isSelected = false
        self.image = image
    }
    
}
