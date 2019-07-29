//
//  LevelMakerController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 22/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

/*
 
 7x15
 b -> blue apple
 B -> blue vase
 e -> empty
 g -> green apple
 G -> green vase
 r -> red apple
 R -> red vase
 W -> water
 V -> normal vase
 
 
 1 -> glass obstacle
 5 -> breaking glass
 9 -> broke glass
 
 + 1 -> red apple behind
 + 2 -> green apple behind
 + 3 -> blue apple behind
 
 */

import UIKit

extension DynamicAnimatorController{
    public func makeLevel(levelState:String, controller:UIViewController, delegate:Selector?){
        guard let view = self.animator.referenceView else{
            fatalError("O animador não referenciava uma view.")
        }
        
        let floor = Floor(frame: CGRect(x: 0, y: view.frame.height - Floor.dimensions.height, width: view.frame.width, height: Floor.dimensions.height))
        addSubview(floor)
        
        var multiplier:CGPoint = CGPoint(x: 0, y: 1)
        var object:AffectedByDynamics?
        var size:CGSize?
        for c in levelState{
            let p:CGPoint = CGPoint(x: view.frame.width/7 * multiplier.x, y: view.frame.height/15 * multiplier.y)
            switch c{
            case "e":
                break
            case "b":
                object = Apple(image: UIImage(named: GeneralProperties.blueApplePath))
                size = Apple.dimensions
                (object as! Apple).value = 2
            case "B":
                object = Vase(image: UIImage(named: GeneralProperties.blueVasePath))
                (object as! Vase).value = 2
                size = Vase.dimensions
            case "g":
                object = Apple(image: UIImage(named: GeneralProperties.greenApplePath))
                (object as! Apple).value = 3
                size = Apple.dimensions
            case "G":
                object = Vase(image: UIImage(named: GeneralProperties.greenVasePath))
                (object as! Vase).value = 3
                size = Vase.dimensions
            case "r":
                object = Apple(image: UIImage(named: GeneralProperties.redApplePath))
                (object as! Apple).value = 1
                size = Apple.dimensions
            case "R":
                object = Vase(image: UIImage(named: GeneralProperties.redVasePath))
                (object as! Vase).value = 3
                size = Vase.dimensions
            case "W":
                object = Droplet(image: UIImage(named: GeneralProperties.dropletPath))
                size = Droplet.dimensions
            case "V":
                object = Vase(image: UIImage(named: GeneralProperties.vasePath))
                size = Vase.dimensions
            case "1", "2", "3", "4":
                object = Glass(image: UIImage(named: GeneralProperties.glassPath))
                size = Glass.dimensions
            //case "5":
                //object = Glass(image: UIImage(named: GeneralProperties.glassBreakingPath))
            //case "9":
                //object = Glass(image: UIImage(named: GeneralProperties.glassBrokenPath))
            case "\n":
                multiplier.y += 1
                multiplier.x = -1
                object = nil
            default:
                print(c)
                fatalError()
            }
            multiplier.x += 1
            if let obj = object, let size = size{
                if let obj = obj as? Apple ?? obj as? Glass{
                    let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: controller, action: delegate)
                    obj.isUserInteractionEnabled = true
                    obj.addGestureRecognizer(tapGesture)
                }
                obj.frame = CGRect(origin: p, size: SizeAdapter.getRatioSizeByMinor(size, deviceSize: view.frame.size))
                obj.center = p
                addSubview(obj)
                obj.awakeFromNib()
                object = nil
            }
        }
    }
}
