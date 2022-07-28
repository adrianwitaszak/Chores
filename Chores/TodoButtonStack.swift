////
////  TodoButtonStack.swift
////  Chores
////
////  Created by Adrian Witaszak on 28/07/2022.
////
//
//import SwiftUI
//
//struct TodoButtonStack: View {
//    
//    @ObservedObject var viewModel: TodoViewModel
//    
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators:  false) {
//            HStack {
//                ForEach(SelectedButton.allCases, id:\.self) {
//                    TodoButton(viewModel: viewModel, buttonType: $0)
//                }
//            }
//        }
//        .eraseToAnyView()
//    }
//
//    #if DEBUG
//    @ObservedObject var iO = injectionObserver
//    #endif
//}
//
//struct TodoButtonStack_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoButtonStack(viewModel: TodoViewModel())
//    }
//}
//
//struct TodoButton: View {
//    @ObservedObject var viewModel: TodoViewModel
//    let buttonType: SelectedButton
//    
//    var body: some View {
//        Button {
//            viewModel.selectedButton = buttonType
//            
//            if viewModel.selectedButton != .all {
//                let _ = viewModel.todosFiltered == viewModel.todos.filter { todo in
//                    return todo.type == viewModel.selectedButton.rawValue
//                }
//            } else {
//                viewModel.todosFiltered = viewModel.todos
//            }
//        } label: {
//            Text("\(buttonType.rawValue)")
//                .foregroundColor(
//                    viewModel.selectedButton == buttonType ? .white : Color(.systemGray)
//                )
//                .frame(width: 100, height: 40)
//                .background(buttonType == viewModel.selectedButton ? Color("lightBlue") : Color(.systemGray6))
//                .cornerRadius(20)
//        }
//        .eraseToAnyView()
//    }
//
//    #if DEBUG
//    @ObservedObject var iO = injectionObserver
//    #endif
//}
