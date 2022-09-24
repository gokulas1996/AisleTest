//
//  Notes.swift
//  Aisle
//
//  Created by Gokul A S on 24/09/22.
//

import Foundation

struct Notes: Codable {
    var likes: Likes?
}

struct Likes: Codable {
    var likes_received_count: Int?
    var profiles: [Profiles]?
}

struct Profiles: Codable {
    var avatar: String?
    var first_name: String?
}
