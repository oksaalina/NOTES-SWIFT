//
//  ContentView.swift
//  NOTE
//
//  Created by Алина Кузнецова on 05.03.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ListModel()
    @State var isShowedNote = false
    @State var isInfoNote = false
    @State private var selectedNote: NoteItem? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("My Notes")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        isShowedNote.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                }
                Divider()
                List {
                    ForEach(viewModel.notes) { note in
                        Button(action: {
                            selectedNote = note
                            viewModel.update(note: note, title: note.title, content: note.content)
                            isInfoNote.toggle()
                        }) {
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(note.title.prefix(20))
                                            .font(.headline)
                                            .lineLimit(1)
                                        Spacer()
                                        Text(note.lastModifiedDate, style: .date)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Text(note.content.prefix(40))
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                }
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color("grey"))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        }
                        .frame(width: 400)
                    }
                    .onDelete(perform: viewModel.delete)
                }
                .listStyle(PlainListStyle())
                Spacer()
            }
            .scrollContentBackground(.hidden)
        }
        .padding(.horizontal)
        .fullScreenCover(isPresented: $isShowedNote) {
            NewNoteView()
        }
        .fullScreenCover(item: $selectedNote) { note in
            NoteInfoView(selectedNote: note)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
