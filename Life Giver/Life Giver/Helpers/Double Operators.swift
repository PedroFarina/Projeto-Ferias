//
//  File.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 30/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

extension Double{
    static func *(lsh:Double, rhs:Int) -> Double{
        return lsh * Double(rhs)
    }
    
    static func -(lsh:Double, rhs:Int) -> Double{
        return lsh - Double(rhs)
    }
    
    static func +(lsh:Double, rhs:Int) -> Double{
        return lsh + Double(rhs)
    }
}
