//
//  CGSizeExtension.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 29/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

extension CGSize{
    static func -(lsh:CGSize, rhs:CGSize) -> CGSize{
        return CGSize(width: lsh.width - rhs.width, height: lsh.height - rhs.height)
    }
    
    static func +(lsh:CGSize, rhs:CGSize) -> CGSize{
        return CGSize(width: lsh.width + rhs.width, height: lsh.height + rhs.height)
    }
}
