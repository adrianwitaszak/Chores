//
//  AppUser.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import FirebaseAuth
import FirebaseFirestoreSwift

struct AppUser: Identifiable, Decodable {
    @DocumentID var id: String?
    let uid: String
    var firstName: String = ""
    var lastName: String = ""
    let email: String

    var isCurrentUser: Bool {
        AuthViewModel.shared.userSession?.uid == id
    }
    
    static var dummy1 = Self(id: "1", uid: "1", firstName: "Adrian", lastName: "Witaszak", email: "adrianwitaszak@gmail.com")
}

extension User: FirebaseConvertable {
    func toDocument(userId: String) -> [String: Any] {
        [
            "uid": userId,
            "firstName": "",
            "lastName": "",
            "email": email
        ]
    }
}
