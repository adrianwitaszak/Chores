//
//  AuthViewModel.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import Firebase
import FirebaseAuth
import Foundation

class AuthViewModel: ObservableObject {
    @Published var userSession: User?
    @Published var currentUser: AppUser?
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: AppUser.self) else { return }
            self.currentUser = user
        }
    }
    
    func login(with email: String, and password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("AuthViewModel: Logon Failed \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func register(with email: String, and password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("AuthViewModel: Logon Failed \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            
            let data = [
                "uid": user.uid,
                "firstName": "",
                "lastName": "",
                "email": email
            ]
            
            COLLECTION_USERS.document(user.uid).setData(data) { _ in
                print("AuthViewModel: Successfully uploaded data")
                self.userSession = user
                self.fetchUser()
            }
        }
    }
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
        print("AuthViewModel: Signed out")
    }
    
    func resetPassword() {
        print("AuthViewModel: reset password")
    }
}
