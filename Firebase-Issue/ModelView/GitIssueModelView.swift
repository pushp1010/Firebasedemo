//
//  IssueDetailViewController.swift
//  Firebase-Issue
//
//  Created by PushpendraSingh on 24/06/19.
//  Copyright © 2019 PushpendraSingh. All rights reserved.
//

import Foundation
import UIKit


let baseURl = "https://api.github.com/repos/firebase/firebase-ios-sdk/issues?sort=updated"

class GitIssueModelView {
    
    private var issues:[Issue] = []
    
    func fetchIssue(completion: @escaping (String?) -> ())
    {
        let url = URL(string: baseURl)
        
        if (!self.isOneDayOver)
       {
            self.issues =  PersistentManager.shared.fetch(Issue.self)
            completion(nil)
        }
        else
        {
            ConnectionManager.init().getDataJsonContentType(with:url!) { [weak self] (data, response, error) in
                if error != nil{
                    completion(error?.localizedDescription)
                }
                else
                {
                    PersistentManager.shared.deleteRecords()
                    do {
                        let decoder = JSONDecoder()
                        let _ = try decoder.decode([Issue].self, from:
                            data ?? Data())
                        PersistentManager.shared.saveContext()
                        UserDefaults.standard.set(Date(), forKey: "Date")
                        self?.issues =  PersistentManager.shared.fetch(Issue.self)
                        completion(nil)
                        
                    } catch let parsingError {
                        print("Error", parsingError)
                        completion (error?.localizedDescription)
                    }
                }
                
            }
        }
    }
    
    var count:Int{
        return self.issues.count
    }
    
    func getGitIssue(atIndex:Int)->Issue
    {
        return self.issues[atIndex]
    }
    
    private var isOneDayOver:Bool
    {
        let date1 = Date()
        let date2 = UserDefaults.standard.value(forKey: "Date") as? Date ?? Date()
        let diff = Int(date1.timeIntervalSince1970 - date2.timeIntervalSince1970)
         if (diff < 86400  && diff > 0 )
         {
            return false
        }
        else
         {
            return true
        }
    }
}
