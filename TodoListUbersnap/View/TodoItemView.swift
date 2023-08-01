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
            Text(item.name ?? "")
            Text(item.createdDate ?? Date(),
                 formatter: dateFormatter)
            .foregroundStyle(.gray)
            .font(.system(size: 12))
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM yyyy H:mm a"
    return formatter
}()
