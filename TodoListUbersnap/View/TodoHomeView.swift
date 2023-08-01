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

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: UpsertTodoView()) {
                        TodoItemView(item: item)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: UpsertTodoView()) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("To Do List")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // TODO: Add pop up error handling.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct TodoHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TodoHomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
