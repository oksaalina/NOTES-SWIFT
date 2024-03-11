//
//  NoteTextEditor.swift
//  NOTES
//
//  Created by Алина Кузнецова on 10.03.2024.
//

import SwiftUI

struct NoteTextEditor: View {
    @State var content: Binding<String>
    
    var body: some View {
        TextEditor(text: content)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal)
    }
}
