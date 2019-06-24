//
//  Issue+CoreDataProperties.swift
//  Firebase-Issue
//
//  Created by PushpendraSingh on 25/06/19.
//  Copyright © 2019 PushpendraSingh. All rights reserved.
//
//

import Foundation
import CoreData


extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue:"context")
}

extension Issue:Encodable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Issue> {
        return NSFetchRequest<Issue>(entityName: "Issue")
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(author_association, forKey: .author_association)
        try container.encode(body, forKey: .body)
        try container.encode(closed_at, forKey: .closed_at)
        try container.encode(title, forKey: .title)
        try container.encode(repository_url, forKey: .repository_url)
        try container.encode(number, forKey: .number)
        try container.encode(node_id, forKey: .node_id)
        try container.encode(milestone, forKey: .milestone)
        try container.encode(labels_url, forKey: .labels_url)
        try container.encode(id, forKey: .id)
        try container.encode(html_url, forKey: .html_url)
        try container.encode(events_url, forKey: .events_url)
        try container.encode(created_at, forKey: .created_at)
        try container.encode(comments_url, forKey: .comments_url)
        try container.encode(comments, forKey: .comments)
        try container.encode(updated_at, forKey: .updated_at)
        try container.encode(url, forKey: .url)
    }
}
