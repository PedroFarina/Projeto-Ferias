//
//  BoolOperators.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 29/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

extension Bool{
    static func &=(lsh: inout Bool, rhs:Bool){
        lsh = lsh && rhs
    }
}
