//
//  NewNoteView.swift
//  NOTE
//
//  Created by Алина Кузнецова on 06.03.2024.
//

import SwiftUI

struct NewNoteView: View {
    @ObservedObject var viewModel = ListModel()
    @State var isShowedNote = false
    @State var title = ""
    @State var content = ""
    
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    if !title.isEmpty || !content.isEmpty {
                        viewModel.add(title: title, content: content)
                        title = ""
                        content = ""
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
            VStack(spacing: 1) {
                
                NoteTextEditor(content: $title)
                    .font(.title2)
                    .frame(width: 400, height: 70)
                
                Spacer(minLength: 4)
                
                NoteTextEditor(content: $content)
                    .font(.title2)
                    .frame(maxWidth: .infinity)
            }
            
        }
        .fullScreenCover(isPresented: $isShowedNote) {
            ContentView()
        }
        .background(Color("grey"))
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView()
    }
}
