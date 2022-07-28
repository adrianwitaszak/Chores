//
//  FirebaseDatasource.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import Firebase
import Foundation

class FirebaseDatasource {

    func getTodos(userId: String, completion: @escaping ([Task]) -> Void) {
        let query = COLLECTION_USERS.document(userId).collection(Constants.Firebase.collectionTodos).order(by: "isCompleted", descending: false)
        query.getDocuments { snapshot, error in
            if let error = error {
                print("FirebaseDatasource: getTodosOfUser error \(error.localizedDescription)")
            }
            guard let documents = snapshot?.documents else { return }

            var todos = documents.compactMap { try? $0.data(as: Task.self) }

            for index in stride(from: 0, to: todos.count, by: 1) {
                todos[index].documentID = documents[index].documentID
            }

            completion(todos)
        }
    }

    func uploadTodo(userId: String, todo: Task) {

        let data: [String: Any] = [
            "ownerId": userId,
            "title": todo.title,
            "description": todo.description,
            "isCompleted": todo.isCompleted
        ]

        COLLECTION_USERS.document(userId).collection(Constants.Firebase.collectionTodos).addDocument(data: data) { error in
            if let error = error {
                print("FirebaseDatasource: uploadTodo error \(error.localizedDescription)")
            }
        }
    }

    func deleteTodo(userId: String, todoId: String) {
        COLLECTION_USERS.document(userId).collection(Constants.Firebase.collectionTodos).document(todoId).delete() { error in
            if let error = error {
                print("FirebaseDatasource: deleteTodo error \(error.localizedDescription)")
                return
            }
        }
    }

    func updateTodo(userId: String, todoId: String, isCompleted: Bool) {
        COLLECTION_USERS.document(userId).collection(Constants.Firebase.collectionTodos).document(todoId).updateData(["isCompleted": isCompleted]) { error in
            if let error = error {
                print("FirebaseDatasource: updateTodo error \(error.localizedDescription)")
            }
        }
    }
}
