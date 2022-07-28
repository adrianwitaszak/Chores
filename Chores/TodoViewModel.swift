//
//  TodoViewModel.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import Firebase
import Foundation

class TodoViewModel: ObservableObject {
    @Published var todos = [Todo]()
    @Published var showCreateTodoView: Bool = false
    @Published var todosFiltered = [Todo]()
    
    var currentUser: AppUser? {
        return AuthViewModel.shared.currentUser
    }

    init() {
        loadTodos()
    }

    func loadTodos() {
        guard let user = currentUser else { return }

        let query = COLLECTION_USERS.document(user.id ?? "").collection(Constants.Firebase.collectionTodos).order(by: "isCompleted", descending: false)
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.todos = documents.compactMap { try? $0.data(as: Todo.self) }

            for index in stride(from: 0, to: self.todos.count, by: 1) {
                self.todos[index].documentID = documents[index].documentID
            }
            
            self.todosFiltered = self.todos
        }
    }
    
    func uploadTodo(todo: Todo) {
        guard let user = currentUser else { return }
        
        let data: [String: Any] = [
            "ownerId": user.id ?? "",
            "title": todo.title,
            "description": todo.description,
            "isCompleted": todo.isCompleted
        ]
        
        COLLECTION_USERS.document(user.id ?? "").collection(Constants.Firebase.collectionTodos).addDocument(data: data) { error in
            if let error = error {
                print("DashboardViewModel: uploadTodo error \(error.localizedDescription)")
                return
            }
            self.loadTodos()
        }
    }
    
    func deleteTodo(with id: String) {
        guard let user = currentUser else { return }
        
        COLLECTION_USERS.document(user.uid).collection(Constants.Firebase.collectionTodos).document(id).delete() { error in
            if let error = error {
                print("DashboardViewModel: deleteTodo error \(error.localizedDescription)")
                return
            }
            self.loadTodos()
        }
    }
    
    func updateTodo(with id: String, isCompleted: Bool) {
        guard let user = currentUser else { return }
        
        COLLECTION_USERS.document(user.uid).collection(Constants.Firebase.collectionTodos).document(id).updateData(["isCompleted": isCompleted]) { error in
            if let error = error {
                print("DashboardViewModel: updateTodo error \(error.localizedDescription)")
                return
            }
            self.loadTodos()
        }
    }
}
