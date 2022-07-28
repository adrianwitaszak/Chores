//
//  Todo.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import FirebaseFirestoreSwift
import Foundation

enum Priority: String, Decodable {
    case none, low, medium, high
}

enum StatusType: String, Decodable, Equatable {
    case created = "created",
         seen = "seen",
         notCompleted = "not completed",
         inProgress = "in progress",
         completed = "completed",
         expired = "expired"
}

struct Status: Decodable {
    let type: StatusType
    var date: Double = Date().timeIntervalSince1970
}

struct Task: Identifiable, Decodable {
    @DocumentID var id: String? = UUID().uuidString
    var creatorId: String
    var title: String
    var description: String = ""
    var thumbnail: String = ""
    var images: [String] = []
    var assignedToIDs: [String] = []
    var priority: Priority = .none
    var dueByDate: Double = 0.0
    var dueByTime: Double = 0.0
    var isCompleted: Bool = false
    var subtaskIDs: [String] = []
    var documentID: String? = ""
}

let dummyTask = Task(id: "1", creatorId: "1", title: "Get milk", description: "Get it ASAP", thumbnail: "", images: [], assignedToIDs: [], priority: .none, dueByDate: 0.0, dueByTime: 0.0, isCompleted: false, subtaskIDs: [])

extension Task: FirebaseConvertable {
    init?(from document: [String: Any]) {
        let id = document["id"] as? String ?? ""
        let creatorId = document["creatorId"] as? String ?? ""
        let title = document["title"] as? String ?? ""
        let description = document["description"] as? String ?? ""
        let thumbnail = document["thumbnail"] as? String ?? ""
        let images = document["images"] as? [String] ?? []
        let assignedToIDs = document["assignedToIDs"] as? [String] ?? []
        let priorityString = document["priority"] as? String ?? ""
        let priority = Priority(rawValue: priorityString) ?? .none

        let dueByDateString = document["dueByDate"] as? String ?? ""
        let dueByDate = Double(dueByDateString) ?? 0.0

        let dueByTimeString = document["dueByTime"] as? String ?? ""
        let dueByTime = Double(dueByTimeString) ?? 0.0

        let isCompleted = document["isCompleted"] as? Bool ?? false
        let subtaskIDs = document["subtaskIDs"] as? [String] ?? []
        let documentID = document["documentID"] as? String ?? ""

        self.init(
                id: id,
                creatorId: creatorId,
                title: title,
                description: description,
                thumbnail: thumbnail,
                images: images,
                assignedToIDs: assignedToIDs,
                priority: priority,
                dueByDate: dueByDate,
                dueByTime: dueByTime,
                isCompleted: isCompleted,
                subtaskIDs: subtaskIDs,
                documentID: documentID
        )
    }

    func toDocument(userId: String) -> [String: Any] {
        [
//            "ownerId": creatorId,
//            "title": title,
//            "description": description,
//            "isCompleted": isCompleted
            "creatorId": creatorId,
            "title": title,
            "description": description,
            "thumbnail": thumbnail,
            "images": "\(images)",
            "assignedToIDs": "\(assignedToIDs)",
            "priority": "\(priority.rawValue)",
            "dueByDate": "\(dueByDate)",
            "dueByTime": "\(dueByTime)",
            "isCompleted": "\(isCompleted)",
            "subtaskIDs": "\(subtaskIDs)",
        ]
    }
}
