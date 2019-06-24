//
//  Contact.swift
//  Contacts
//
//  Created by pushpendra singh on 6/22/19.
//  Copyright © 2019 pushpendra singh. All rights reserved.
//

import Foundation

/*
 {
 "user": {
 "login": "Corrob",
 "id": 2016057,
 "node_id": "MDQ6VXNlcjIwMTYwNTc=",
 "avatar_url": "https://avatars1.githubusercontent.com/u/2016057?v=4",
 "gravatar_id": "",
 "url": "https://api.github.com/users/Corrob",
 "html_url": "https://github.com/Corrob",
 "followers_url": "https://api.github.com/users/Corrob/followers",
 "following_url": "https://api.github.com/users/Corrob/following{/other_user}",
 "gists_url": "https://api.github.com/users/Corrob/gists{/gist_id}",
 "starred_url": "https://api.github.com/users/Corrob/starred{/owner}{/repo}",
 "subscriptions_url": "https://api.github.com/users/Corrob/subscriptions",
 "organizations_url": "https://api.github.com/users/Corrob/orgs",
 "repos_url": "https://api.github.com/users/Corrob/repos",
 "events_url": "https://api.github.com/users/Corrob/events{/privacy}",
 "received_events_url": "https://api.github.com/users/Corrob/received_events",
 "type": "User",
 "site_admin": false
 },
 "labels": [{
 "id": 658858759,
 "node_id": "MDU6TGFiZWw2NTg4NTg3NTk=",
 "url": "https://api.github.com/repos/firebase/firebase-ios-sdk/labels/cla:%20yes",
 "name": "cla: yes",
 "color": "ededed",
 "default": false
 }],
 "state": "open",
 "locked": false,
 "assignee": null,
 "assignees": [
 
 ],
 "milestone": null,
 "comments": 0,
 "created_at": "2019-06-22T01:01:09Z",
 "updated_at": "2019-06-22T13:53:31Z",
 "closed_at": null,
 "author_association": "COLLABORATOR",
 "pull_request": {
 "url": "https://api.github.com/repos/firebase/firebase-ios-sdk/pulls/3240",
 "html_url": "https://github.com/firebase/firebase-ios-sdk/pull/3240",
 "diff_url": "https://github.com/firebase/firebase-ios-sdk/pull/3240.diff",
 "patch_url": "https://github.com/firebase/firebase-ios-sdk/pull/3240.patch"
 },
 "body": ""
 }
 */
struct GitIssue:Codable {
    var id:Int?
    var url:String?
    var repository_url:String?
    var labels_url:String?
    var comments_url:String?
    var events_url:String?
    var html_url:String?
    var node_id:String?
    var number:Int?
    var title:String?
    var milestone:String?
    var comments:Int
    var created_at:String?
    var updated_at:String?
    var closed_at:String?
    var author_association:String?
    var body:String?
}
