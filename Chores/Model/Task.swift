//
//  Todo.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import FirebaseFirestoreSwift
import Foundation

struct Task: Identifiable, Decodable, Equatable {
    @DocumentID var id: String? = UUID().uuidString
    let ownerId: String
    var title: String
    var description: String
    var isCompleted: Bool
    var documentID: String? = ""

    static var dummy1 = Self(id: "1", ownerId: "1", title: "Get milk", description: "Get it ASAP", isCompleted: false)
    static var dummy2 = Self(id: "2", ownerId: "1", title: "Get cucumber", description: "Get it ASAP", isCompleted: false)
    static var dummy3 = Self(id: "3", ownerId: "1", title: "Get ham", description: "Get it ASAP", isCompleted: false)
    static var dummy4 = Self(id: "4", ownerId: "1", title: "Get bread", description: "Get it ASAP", isCompleted: false)
}

extension Task: FirebaseConvertable {
    func toDocument(userId: String) -> [String: Any] {
        [
            "ownerId": ownerId,
            "title": title,
            "description": description,
            "isCompleted": isCompleted
        ]
    }
}
