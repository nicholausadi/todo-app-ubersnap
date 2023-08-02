//
//  TodoUpsertView.swift
//  TodoListUbersnap
//
//  Created by Nicholaus Adisetyo Purnomo on 01/08/23.
//

import SwiftUI
import CoreData

struct TodoUpsertView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    // Task
    @State private var title: String = ""
    @State private var desc: String = ""
    @State private var dueDate: Date = Date()
    @State private var isDueSet: Bool = false
    @State private var createdDate: Date?
    
    // Params
    var todoId: NSManagedObjectID?
    
    // View Model
    let viewModel = TodoViewModel()
    
    // Error State
    @State private var titleError = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    Section {
                        // Title
                        VStack(alignment: .leading) {
                            TextField("Enter title...", text: $title, prompt: Text("Title"))
                            if titleError {
                                Text("Title is required").foregroundColor(.red)
                            }
                        }
                        
                        // Description (optional)
                        VStack {
                            TextField("Enter description...", text: $desc, prompt: Text("Description"))
                        }
                        
                        // Due Date (optional). Limit due date start from today.
                        DatePickerField(date: $dueDate, isDateSet: $isDueSet)
                    }
                }
                
                Button {
                    if title.isEmpty {
                        titleError = title.isEmpty
                    } else {
                        let model = TodoModel(
                            title: title,
                            desc: desc,
                            dueDate: isDueSet ? dueDate : nil,
                            createdDate: createdDate ?? Date())
                        
                        // Save to Core Data
                        viewModel.upsertTodo(todoId: todoId, with: model, in: viewContext)
                        
                        // Pop screen
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Save")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .foregroundColor(.white)
                .background(.blue)
            }
            .navigationTitle("\(todoId == nil ? "New Task" : "Edit Task")")
            
            Spacer()
        }.onAppear {
            guard let objectId = todoId, let item = viewModel.getTodo(for: objectId, context: viewContext) else { return }
            
            title = item.title ?? ""
            desc = item.desc ?? ""
            dueDate = item.dueDate ?? Date()
            isDueSet = item.dueDate != nil
            createdDate = item.createdDate
        }
        
    }
}

struct TodoUpsertView_Previews: PreviewProvider {
    static var previews: some View {
        TodoUpsertView()
    }
}
