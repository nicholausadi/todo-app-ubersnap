//
//  TodoViewModel.swift
//  TodoListUbersnap
//
//  Created by Nicholaus Adisetyo Purnomo on 02/08/23.
//

import CoreData
import SwiftUI

final class TodoViewModel: ObservableObject {
    
    @Published var errorMsg: Error?
    
    func getTodo(for objectId: NSManagedObjectID, context: NSManagedObjectContext) -> TodoItem? {
        guard let item = context.object(with: objectId) as? TodoItem else {
            return nil
        }
        
        return item
    }
    
    func upsertTodo(
        todoId: NSManagedObjectID?,
        with model: TodoModel,
        in context: NSManagedObjectContext
    ) {
        let item: TodoItem
        if let objectId = todoId, let fetchedTodo = getTodo(for: objectId, context: context) {
            item = fetchedTodo
        } else {
            item = TodoItem(context: context)
        }
        
        item.title = model.title
        item.desc = model.desc
        item.dueDate = model.dueDate
        item.createdDate = model.createdDate
        
        do {
            try context.save()
        } catch {
            context.rollback()

            // Show pop up error handling.
            let nsError = error as NSError
            errorMsg = Error.failedUpsert(error: nsError)
        }
    }
    
    func deleteItem(
        for indexSet: IndexSet,
        items: FetchedResults<TodoItem>,
        context: NSManagedObjectContext
    ) {
        indexSet.map { items[$0] }.forEach(context.delete)
        
        do {
            try context.save()
        } catch {
            context.rollback()

            // Show pop up error handling.
            let nsError = error as NSError
            errorMsg = Error.failedDelete(error: nsError)
        }
    }
}
