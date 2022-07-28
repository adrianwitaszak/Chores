//
//  Constants.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection(Constants.Firebase.collectionUsers)

struct Constants {
    struct Firebase {
        static let collectionUsers = "users"
        static let collectionTodos = "todos"
    }
}
