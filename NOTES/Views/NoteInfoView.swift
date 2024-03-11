//
//  NoteInfoView.swift
//  NOTE
//
//  Created by Алина Кузнецова on 07.03.2024.
//

import SwiftUI

struct NoteInfoView: View {
    @ObservedObject var viewModel = ListModel()
    @State var isShowedNote = false
    @State private var editedTitle: String
    @State private var editedContent: String
    var selectedNote: NoteItem
    
    init(selectedNote: NoteItem) {
        self.selectedNote = selectedNote
        self._editedTitle = State(initialValue: selectedNote.title)
        self._editedContent = State(initialValue: selectedNote.content)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    if !editedTitle.isEmpty || !editedContent.isEmpty {
                        viewModel.update(note: selectedNote, title: editedTitle, content: editedContent)
                        isShowedNote.toggle()
                    } else {
                        isShowedNote.toggle()
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.compact.left")
                            .foregroundColor(.black)
                        Text("Notes")
                            .foregroundColor(.black)
                        Spacer()
                    }
                }
            }
            Text(selectedNote.lastModifiedDate, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            TextField("Title", text: $editedTitle)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
            
            NoteTextEditor(content: $editedContent)
            
            Spacer()
        }
        .fullScreenCover(isPresented: $isShowedNote) {
            ContentView()
        }
        .background(Color("grey"))
    }
}

struct NoteInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleNote = NoteItem(title: "Example Title", content: "Example Content")
        return NoteInfoView(selectedNote: exampleNote)
    }
}
