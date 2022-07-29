//
//  CreateTodoView.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import SwiftUI

struct CreateTodoView: View {
    
    let user: AppUser
    
    @State var title: String = ""
    @State var description: String = ""
    @State var type: String = ""
    @State var completed: String = ""
    
    @ObservedObject var viewModel: TodoViewModel
    
    var body: some View {
        VStack {
            TodoTextField(text: $title, placeholder: "Todo...")
                .padding([.horizontal, .bottom])
            TextField("Description", text: $description)
                .padding([.horizontal, .bottom])
            TodoTextField(text: $title, placeholder: "Todo...")
                    .padding([.horizontal, .bottom])
            
            CustomTextEditor(
                text: $description,
                placeholder: Text("Description"),
                imageName: "line.3.horizontal",
                foregroundColor: .gray
            )
            .padding([.horizontal, .bottom])
            
            HStack {
                Button {
                    viewModel.uploadTodo(todo: Task(creatorId: user.id ?? "", title: title, description: description))
                    viewModel.showCreateTodoView = false
                } label: {
                    DoTodoButton(text: "Create", backgroundColor: Color("lightBlue"))
                }
                
                Button {
                    viewModel.showCreateTodoView = false
                } label: {
                    DoTodoButton(text: "Cancel", backgroundColor: Color(.systemRed))
                }
            }
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.size.width - 100, height: 360)
        .background(Color(.systemGray5))
        .cornerRadius(25)
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct CreateTodoView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTodoView(user: AppUser.dummy1, viewModel: TodoViewModel())
    }
}


struct DoTodoButton: View {
    
    let text: String
    let backgroundColor: Color
    
    init(text: String, backgroundColor: Color) {
        self.text = text
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 150, height: 40)
            .background(backgroundColor.opacity(0.6))
            .clipShape(Capsule())
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}
