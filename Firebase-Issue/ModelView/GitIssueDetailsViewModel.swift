//
//  IssueDetailViewController.swift
//  Firebase-Issue
//
//  Created by PushpendraSingh on 24/06/19.
//  Copyright © 2019 PushpendraSingh. All rights reserved.
//

import Foundation
import UIKit


class GitIssueDetailsViewModel {
    
    private var gitIssue:Issue?
    private var comments:[Comment] = []
    var urlString:String?
    
    init(issue:Issue) {
        gitIssue = issue
        urlString = gitIssue?.comments_url
    }
    
    var title:String?{
        return gitIssue?.title
    }
    
    func fetchComments(completion: @escaping (String?) -> ())
    {
        DispatchQueue.global(qos: .background).async {

            if let urlStr = self.urlString
            {
                if let url = URL(string: urlStr){
                    ConnectionManager.init().getDataJsonContentType(with:url) { (data, response, error) in
                        
                        if error != nil{
                            completion(error?.localizedDescription)
                        }
                        else
                            {
                            do {
                                let decoder = JSONDecoder()
                                let model = try decoder.decode([Comment].self, from:
                                    data ?? Data())
                                self.comments = model
                                completion(nil)
                                
                            } catch {
                                let message = "Parsing error"
                                completion(message)
                            }
                        }
                    }
                }
            }
        }
    }
    
    var count:Int{
        return self.comments.count
    }
    
    func getComment(atIndex:Int)->Comment
    {
        return self.comments[atIndex]
    }
    
}
