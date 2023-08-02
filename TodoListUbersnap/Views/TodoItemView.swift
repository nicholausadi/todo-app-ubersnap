//
//  TodoItemView.swift
//  TodoListUbersnap
//
//  Created by Nicholaus Adisetyo Purnomo on 01/08/23.
//

import SwiftUI

struct TodoItemView: View {
    var item: TodoItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title ?? "")
            
            if let desc = item.desc, !desc.isEmpty {
                Text(desc)
                    .foregroundStyle(.gray)
                    .font(.system(size: 12))
            }
            
            if let dueDate = item.dueDate {
                let dateStr = dateFormatter.string(from: dueDate)
                Text("Due on \(dateStr)")
                    .foregroundStyle(.gray)
                    .font(.system(size: 12))
            }
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM yyyy H:mm a"
    return formatter
}()
