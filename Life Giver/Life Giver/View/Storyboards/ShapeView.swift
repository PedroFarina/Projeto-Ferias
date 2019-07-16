//
//  ShapeView.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 26/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

@IBDesignable public class ShapeView : UIView{
    public override init(frame: CGRect) {
        super.init(frame:frame)
        radius = _radius
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        radius = _radius
    }
    
    public private(set) var path:UIBezierPath?
    
    private var _radius:CGFloat = 0
    @IBInspectable public var radius:CGFloat
        {
        get{
            return _radius
        }
        set{
            _radius = min(newValue, min(bounds.width/2, bounds.height/2))
            if _radius == 0{
                backgroundColor = fillColor
                self.layer.borderColor = borderColor.cgColor
                path = nil
            }
            else{
                backgroundColor = .clear
                self.layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable public var borderWidth:CGFloat = 0{
        didSet{
            needsUpdateConstraints()
        }
    }
    
    @IBInspectable public var fillColor:UIColor = .red{
        didSet{
            radius = _radius
            needsUpdateConstraints()
        }
    }
    
    @IBInspectable public var borderColor:UIColor = .gray{
        didSet{
            radius = _radius
            needsUpdateConstraints()
        }
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if radius != 0{
            let center = CGPoint(x:bounds.width/2, y:bounds.height/2)
            let borderPath = UIBezierPath(arcCenter: center, radius: radius + borderWidth, startAngle: CGFloat.zero, endAngle: 2 * CGFloat.pi, clockwise: false)
            borderColor.setFill()
            borderPath.fill()
            path = borderPath
            
            let fillPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat.zero, endAngle: 2 * CGFloat.pi, clockwise: false)
            
            fillColor.setFill()
            fillPath.fill()
        }
    }
}
