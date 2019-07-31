//
//  IntOperators.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 29/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

extension Int{
    static postfix func ++(lNumber: inout Int){
        lNumber += 1
    }
    static postfix func --(lNumber: inout Int){
        lNumber -= 1
    }
    
    static func *(lsh:Int, rhs:Double) -> Double{
        return Double(lsh) * rhs
    }
    
    static func -(lsh:Int, rhs:Double) -> Double{
        return Double(lsh) - rhs
    }
    
    static func +(lsh:Int, rhs:Double) -> Double{
        return Double(lsh) + rhs
    }
}
