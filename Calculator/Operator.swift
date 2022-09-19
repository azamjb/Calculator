//
//  Operator.swift
//  Calculator
//
//  Created by Azam Jawad on 2022-06-15.
//

import Foundation


class Operator {
    
    var op: (Double, Double) -> Double
    var isDivision = false
    
    init( string: String) {
        
        if string == "+" {
            self.op = (+)
            
        }
        else if string == "-" {
            self.op = (-)
            
        }
        else if string == "\u{00d7}" {
            self.op = (*)
            
        }
        else {
            self.op = (/)
            self.isDivision = true
        }
        
    }
}
