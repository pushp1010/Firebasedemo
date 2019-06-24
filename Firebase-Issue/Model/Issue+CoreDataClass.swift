//
//  Issue+CoreDataClass.swift
//  Firebase-Issue
//
//  Created by PushpendraSingh on 25/06/19.
//  Copyright © 2019 PushpendraSingh. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Issue)
public class Issue: NSManagedObject,Decodable {
    @NSManaged public var author_association: String?
    @NSManaged public var body: String?
    @NSManaged public var closed_at: String?
    @NSManaged public var comments: Int64
    @NSManaged public var comments_url: String?
    @NSManaged public var created_at: String?
    @NSManaged public var events_url: String?
    @NSManaged public var html_url: String?
    @NSManaged public var id: Int64
    @NSManaged public var labels_url: String?
    @NSManaged public var milestone: String?
    @NSManaged public var node_id: String?
    @NSManaged public var number: Int64
    @NSManaged public var repository_url: String?
    @NSManaged public var title: String?
    @NSManaged public var updated_at: String?
    @NSManaged public var url: String?
    
    enum CodingKeys: String, CodingKey {
        case author_association
        case body
        case closed_at
        case comments
        case comments_url
        case created_at
        case events_url
        case html_url
        case id
        case labels_url
        case milestone
        case node_id
        case number
        case repository_url
        case title
        case updated_at
        case url
    }
    /*
     // Create NSEntityDescription with NSManagedObjectContext
     guard let contextUserInfoKey = CodingUserInfoKey.context,
     let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
     let entity = NSEntityDescription.entity(forEntityName: ENTITY_NAME, in: managedObjectContext) else {
     fatalError("Failed to decode Person!")
     }
 */
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard
            let entity = NSEntityDescription.entity(forEntityName: "Issue", in:  PersistentManager.shared.context) else {
                fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto:  PersistentManager.shared.context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author_association = try container.decodeIfPresent(String.self, forKey: .author_association)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.closed_at = try container.decodeIfPresent(String.self, forKey: .closed_at)
        self.comments = try container.decodeIfPresent(Int64.self, forKey: .comments) ?? 0
        self.comments_url = try container.decodeIfPresent(String.self, forKey: .comments_url)
        self.events_url = try container.decodeIfPresent(String.self, forKey: .events_url)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.repository_url = try container.decodeIfPresent(String.self, forKey: .repository_url)
        self.number = try container.decodeIfPresent(Int64.self, forKey: .number) ?? 0
        self.node_id = try container.decodeIfPresent(String.self, forKey: .node_id)
        self.milestone = try container.decodeIfPresent(String.self, forKey: .milestone)
        self.labels_url = try container.decodeIfPresent(String.self, forKey: .labels_url)
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id) ?? 0
        self.html_url = try container.decodeIfPresent(String.self, forKey: .html_url)
    }
}
