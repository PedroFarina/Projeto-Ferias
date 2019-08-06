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
        apple.frame.size = SizeAdapter.getRatioSizeByBiggest(Apple.dimensions, deviceSize: deviceSize)
        self.addSubview(apple)
        self.apple = apple
    }
    
    public func getApple() -> Apple?{
        return apple
    }
    
    public override func awakeFromNib() {
        guard let apple = apple else{
            return
        }
        apple.center = CGPoint(x: frame.width/2, y: frame.height/2)
    }
    
    public override var center: CGPoint{
        get{
            return super.center
        }
        set{
            apple?.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
            super.center = newValue
        }
    }
}
