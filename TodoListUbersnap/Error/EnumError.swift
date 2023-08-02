//
//  EnumError.swift
//  TodoListUbersnap
//
//  Created by Nicholaus Adisetyo Purnomo on 02/08/23.
//

import Foundation

enum Error: LocalizedError {
    case failedUpsert(error: NSError)
    case failedDelete(error: NSError)

    var errorDescription: String? {
        switch self {
        case .failedUpsert:
            return "Failed to upsert new task"
            
        case .failedDelete:
            return "Failed to delete a task"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .failedUpsert(let error):
            return "Create/Update a task failed due to \(error), \(error.userInfo)"
            
        case .failedDelete(let error):
            return "Delete a task failed due to \(error), \(error.userInfo)"
        }
    }
}
