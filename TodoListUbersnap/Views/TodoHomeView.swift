//
//  TodoHomeView.swift
//  TodoListUbersnap
//
//  Created by Nicholaus Adisetyo Purnomo on 01/08/23.
//

import SwiftUI
import CoreData

struct TodoHomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: TodoItem.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \TodoItem.createdDate, ascending: true)],
                  animation: .default)
    
    private var items: FetchedResults<TodoItem>
    
    // State
    @State private var refreshID = UUID()
    
    // View Model
    let viewModel = TodoViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        TodoUpsertView(todoId: item.objectID)
                            .onDisappear {
                                self.refreshID = UUID()
                        }
                    } label: {
                        TodoItemView(item: item)
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        viewModel.deleteItem(
                            for: indexSet,
                            items: items,
                            context: viewContext)
                    }
                }
            }
            .id(refreshID)
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        TodoUpsertView()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }.navigationTitle("To Do List")
        }
    }
}

struct TodoHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TodoHomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
