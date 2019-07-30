//
//  GlassWithApple.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 29/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class GlassWithApple : Glass{
    private var apple:Apple?
    
    public func setApple(_ apple:Apple, deviceSize:CGSize){
        if let currentApple = self.apple{
            currentApple.removeFromSuperview()
        }
        apple.frame.size = SizeAdapter.getRatioSizeByMinor(Apple.dimensions, deviceSize: deviceSize)
        apple.center = self.center
        self.addSubview(apple)
        self.apple = apple
    }
    
    public func getApple() -> Apple?{
        return apple
    }
}
