//
//  ModelController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 15/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import CoreData
import UIKit

public class ModelController{
    //MARK : Properties
    private let context:NSManagedObjectContext
    private var _levels:[Level]
    
    //MARK : Level Accessors
    public func getLevels() -> [Level]{
        var copy:[Level] = []
        copy.append(contentsOf: _levels)
        return copy
    }
    
    //MARK : Modify
    public func modifyLevel(level:Level, newCompletion:Int16) -> ModelStatus{
        return modifyLevel(level: level, newCompletion: newCompletion, newState: level.state!)
    }
    public func modifyLevel(level:Level, newCompletion:Int16, newState:String) -> ModelStatus{
        var hasModifications:Bool = false
        if newCompletion != level.completion{
            level.completion = newCompletion
            hasModifications = true
        }
        if newState != level.state{
            level.state = newState
            hasModifications = true
        }
        
        if hasModifications{
            do{
                try context.save()
                return ModelStatus(successful: true)
            }
            catch{
                return ModelStatus(successful: false, description: "Não foi possível editar o nível")
            }
        }
        return ModelStatus(successful: true, description: "Não havia modificações")
    }
    
    //MARK : Reset Level
    public func resetLevelState(level:Level) -> ModelStatus{
        let b = Bundle.main.localizedString(forKey: "Level \(level.id)", value: nil, table: "Levels")
        level.state = b
        do{
            try context.save()
            return ModelStatus(successful: true)
        }
        catch{
            return ModelStatus(successful: false, description: "Não foi possível resetar o estado do nível.")
        }
    }
    
    public func resetLevelCompletion(level:Level) -> ModelStatus{
        level.completion = 0
        do{
            try context.save()
            return ModelStatus(successful: true)
        }
        catch{
            return ModelStatus(successful: false, description: "Não foi possível resetar a compleção.")
        }
    }
    
    public func resetLevel(level:Level) -> ModelStatus{
        let b = Bundle.main.localizedString(forKey: "Level \(level.id)", value: nil, table: "Levels")
        level.state = b
        level.completion = 0
        do{
            try context.save()
            return ModelStatus(successful: true)
        }
        catch{
            return ModelStatus(successful: false, description: "Não foi possível resetar o nível.")
        }
    }
    
    //MARK : Singleton properties
    private init(){
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            _levels = try context.fetch(Level.fetchRequest())
            _levels.sort(by: { (first, second) -> Bool in
                return first.id < second.id
                })
        }
        catch{
            fatalError("Não foi possível recuperar os dados.")
        }
        
        var level:String
        for i in _levels.count..<Int.max{
            level = "Level \(i)"
            let b = Bundle.main.localizedString(forKey: level, value: nil, table: "Levels")
            if b == level{
                break
            }
            
            let objLevel:Level = NSEntityDescription.insertNewObject(forEntityName: "Level", into: context) as! Level
            objLevel.id = Int16(i)
            objLevel.completion = 0
            objLevel.state = b
            _levels.append(objLevel)
        }
        if context.hasChanges{
            do{
                try context.save()
            }
            catch{
                fatalError("Não foi possível salvar os dados.")
            }
        }
        
    }
    
    class func shared() -> ModelController{
        return sharedModelController
    }
    
    private static var sharedModelController : ModelController = {
        let MC = ModelController()
        
        return MC
    }()
}
