//
//  IssueDetailViewController.swift
//  Firebase-Issue
//
//  Created by PushpendraSingh on 24/06/19.
//  Copyright © 2019 PushpendraSingh. All rights reserved.
//

import UIKit

class IssueDetailViewController: UITableViewController {
    
     var issueDetailViewModel:GitIssueDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = issueDetailViewModel?.title
        issueDetailViewModel?.fetchComments(completion: { (message) in
            DispatchQueue.main.async {
                if(message == nil){
                    self.issueDetailViewModel?.count == 0 ? UIAlertController.showAlert(title: "Firebase-Issue", message: "Comments not available"): self.tableView.reloadData()
                }
                else{
                    UIAlertController.showAlert(title: "Firebase-Issue", message: message!)
                }
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issueDetailViewModel?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "issueDetails", for: indexPath)

        let comment = self.issueDetailViewModel?.getComment(atIndex: indexPath.row)
        cell.detailTextLabel?.text = comment?.body
        cell.textLabel?.text = comment?.user?.login
        return cell
    }
}
