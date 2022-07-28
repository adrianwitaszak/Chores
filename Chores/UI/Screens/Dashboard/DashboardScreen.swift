//
//  DashboardScreen.swift
//  AllDone
//
//  Created by Adrian Witaszak on 25/07/2022.
//

import SwiftUI

struct DashboardScreen: View {

    @ObservedObject var viewModel = TodoViewModel()

    @State var searchText: String = ""

    let user: AppUser

    var body: some View {
        ZStack {
            VStack {

// MARK: - HEADER
                HStack {
                    Spacer()
                    Text("- AllDone -")
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                    Spacer()
                }
                        .overlay {
                            HStack {
                                Spacer()
                                Button(action: AuthViewModel.shared.signOut) {
                                    Text("Logout")
                                            .foregroundColor(Color(.systemGray))
                                }
                                        .padding(.trailing)
                            }
                        }

// MARK: - SEARCH BAR
                SearchBarView(searchText: $searchText)
                        .padding()

// MARK: - LOGO
                if viewModel.todosFiltered.isEmpty {
                    AddTodoLogo()
                            .padding(.top)
                }

                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(viewModel.todosFiltered, id: \.id) { todo in
                            if searchText == "" {
                                TodoView(todo: Task(ownerId: todo.ownerId, title: todo.title, description: todo.description, isCompleted: todo.isCompleted, documentID: todo.documentID), viewModel: viewModel)
                            } else {
                                if todo.title.lowercased().contains(searchText.lowercased()) || todo.description.lowercased().contains(searchText.lowercased()) {
                                    TodoView(todo: Task(ownerId: todo.ownerId, title: todo.title, description: todo.description, isCompleted: todo.isCompleted, documentID: todo.documentID), viewModel: viewModel)
                                }
                            }
                        }
                    }
                }
            }
                    .overlay {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.showCreateTodoView = true
                                } label: {
                                    Image(systemName: "plus")
                                            .padding()
                                            .foregroundColor(.white)
                                            .font(.system(size: 30))
                                            .frame(width: 60, height: 60)
                                            .background(Color("lightBlue"))
                                            .cornerRadius(30)
                                            .padding(20)
                                }
                            }
                        }

                        if viewModel.showCreateTodoView {
                            BlankView()
                            CreateTodoView(user: user, viewModel: viewModel)
                        }
                    }
        }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        DashboardScreen(user: AppUser.dummy1)
    }
}
