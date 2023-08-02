//
//  DatePickerField.swift
//  TodoListUbersnap
//
//  Created by Nicholaus Adisetyo Purnomo on 02/08/23.
//

import SwiftUI

struct DatePickerField: View {
    @Binding var date: Date
    @Binding var isDateSet: Bool
    
    var body: some View {
        if (isDateSet) {
            HStack {
                DatePicker("Due on ", selection: $date, in: Date()...)
                Button {
                    isDateSet.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .frame(width: 20, height: 20, alignment: .center).foregroundColor(Color(.systemGray2))
                }.buttonStyle(PlainButtonStyle())
            }
        } else {
            Button {
                isDateSet.toggle()
            } label: {
                HStack {
                    Text("Due on").foregroundColor(.black)
                    Spacer()
                    Text("Tap to set")
                }.padding(.vertical, 7)
            }

        }
    }
}
