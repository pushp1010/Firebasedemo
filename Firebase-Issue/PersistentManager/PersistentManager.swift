//
//  PersistantManager.swift
//  Firebase-Issue
//
//  Created by PushpendraSingh on 24/06/19.
//  Copyright © 2019 PushpendraSingh. All rights reserved.
//

import Foundation
import CoreData

class  PersistentManager {
    
    private init() {
    }
    static let shared = PersistentManager()
    
    // MARK: Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Firebase-Issue")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved successfully")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T:NSManagedObject>(_ objectType:T.Type)->[T]
    {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key:"updated_at", ascending: false)]
    
        do{
            let fetchObject = try context.fetch(fetchRequest) as? [T]
            return fetchObject ?? [T]()
            
        }
        catch
        {
            return [T]()
        }
    }
    
    func deleteRecords() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Issue")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
}
