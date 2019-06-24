//
//  IssueDetailViewController.swift
//  Firebase-Issue
//
//  Created by PushpendraSingh on 24/06/19.
//  Copyright © 2019 PushpendraSingh. All rights reserved.
//

import UIKit

class IssueListViewController: UITableViewController {
    
    private var gitIssueViewModel:GitIssueModelView = GitIssueModelView()
    private var selected:Issue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionIndexColor = UIColor.lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      self.fetchAndUpdateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "moveToDetails")
        {
            let destination = segue.destination as! IssueDetailViewController
            if let gitIssue = selected{
                destination.issueDetailViewModel = GitIssueDetailsViewModel.init(issue:gitIssue )
            }
        }
    }
    
    private func fetchAndUpdateUI()
    {
        var activity:ProgressHUD?
        
        DispatchQueue.main.async {
            activity = ProgressHUD.init(text: "")
            activity?.show(hud:activity!)
//            self.tableView.reloadData()
        }
        
        gitIssueViewModel.fetchIssue(completion:
            { (message)  in
                if (message == nil)
                {
                    DispatchQueue.main.async {
                        activity?.hide()
                        self.tableView.reloadData()
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        activity?.hide()
                        UIAlertController.showAlert(title: "contacts", message: message!)
                    }
                }
        })
    }
}


extension IssueListViewController{
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gitIssueViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Issue", for: indexPath)
        
        let issue = self.gitIssueViewModel.getGitIssue(atIndex: indexPath.row)
        cell.textLabel?.text =  issue.title
        cell.detailTextLabel?.text = issue.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selected = self.gitIssueViewModel.getGitIssue(atIndex: indexPath.row)
            self.performSegue(withIdentifier:"moveToDetails", sender: nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
