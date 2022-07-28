//
//  TodoView.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import SwiftUI

struct TodoView: View {
    
    var todo: Task
    
    @ObservedObject var viewModel: TodoViewModel
    
    var body: some View {
        HStack {
            Button {
                if todo.isCompleted {
                    viewModel.updateTodo(with: todo.documentID ?? "", isCompleted: false)
                } else {
                    viewModel.updateTodo(with: todo.documentID ?? "", isCompleted: true)
                }
            } label: {
                Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("lightBlue"))
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(todo.title)
                    .font(.system(size: 18))
                
                if !todo.description.isEmpty {
                    HStack {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .frame(width: 15, height: 10)
                            .foregroundColor(Color("lightBlue"))
                        
                        Text("\(todo.description)")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.systemGray2))
                    }
                }
            }
            .padding(.leading, 10)
            
            Spacer()
            
            Button {
                viewModel.deleteTodo(with: todo.documentID ?? "")
            } label: {
                Image(systemName: "x.circle")
                    .foregroundColor(.red)
                    .frame(width: 22, height: 22)
            }
        }
        .padding(20)
        .frame(width: UIScreen.main.bounds.size.width - 25, height: 70)
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(todo: Task.dummy1, viewModel: TodoViewModel())
    }
}
