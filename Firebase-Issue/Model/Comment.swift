//
//  File.swift
//  Contacts
//
//  Created by pushpendra singh on 6/22/19.
//  Copyright © 2019 pushpendra singh. All rights reserved.
//

import Foundation

/*
 {
 "url": "https://api.github.com/repos/firebase/firebase-ios-sdk/issues/comments/504983374",
 "html_url": "https://github.com/firebase/firebase-ios-sdk/issues/3242#issuecomment-504983374",
 "issue_url": "https://api.github.com/repos/firebase/firebase-ios-sdk/issues/3242",
 "id": 504983374,
 "node_id": "MDEyOklzc3VlQ29tbWVudDUwNDk4MzM3NA==",
 "user": {
 "login": "Ovid-iu",
 "id": 52161015,
 "node_id": "MDQ6VXNlcjUyMTYxMDE1",
 "avatar_url": "https://avatars2.githubusercontent.com/u/52161015?v=4",
 "gravatar_id": "",
 "url": "https://api.github.com/users/Ovid-iu",
 "html_url": "https://github.com/Ovid-iu",
 "followers_url": "https://api.github.com/users/Ovid-iu/followers",
 "following_url": "https://api.github.com/users/Ovid-iu/following{/other_user}",
 "gists_url": "https://api.github.com/users/Ovid-iu/gists{/gist_id}",
 "starred_url": "https://api.github.com/users/Ovid-iu/starred{/owner}{/repo}",
 "subscriptions_url": "https://api.github.com/users/Ovid-iu/subscriptions",
 "organizations_url": "https://api.github.com/users/Ovid-iu/orgs",
 "repos_url": "https://api.github.com/users/Ovid-iu/repos",
 "events_url": "https://api.github.com/users/Ovid-iu/events{/privacy}",
 "received_events_url": "https://api.github.com/users/Ovid-iu/received_events",
 "type": "User",
 "site_admin": false
 },
 "created_at": "2019-06-24T12:12:30Z",
 "updated_at": "2019-06-24T12:12:30Z",
 "author_association": "NONE",
 "body": "![Screenshot 2019-06-24 at 13 39 21](https://user-images.githubusercontent.com/52161015/60017610-cd484280-9691-11e9-9aec-76008583dab6.png)\r\nAs you can see, the usage is on another thread and not on the main one."
 }
 */

struct Comment:Codable {
    var id:Int?
    var node_id:String?
    var issue_url:String?
    var html_url:String?
    var url:String?
    var created_at:String?
    var updated_at:String?
    var author_association:String?
    var body:String?
    var user:User?
    
}

struct User:Codable {
    var id:Int?
    var login:String?
    var avatar_url:String?
}
