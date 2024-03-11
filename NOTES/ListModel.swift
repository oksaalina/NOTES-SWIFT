//
//  ListModel.swift
//  NOTE
//
//  Created by Алина Кузнецова on 05.03.2024.
//

import Foundation

class ListModel: ObservableObject {
    @Published var notes: [NoteItem] = []
    @Published var noteContent: String = UserDefaults.standard.string(forKey: "noteContent") ?? ""
    
    init() {
        loadData()
        if notes.isEmpty {
            add(title: "Hello User!", content: "What's up?")
        }
    }
    
    func add(title: String, content: String) {
        let newNote = NoteItem(title: title, content: content)
        notes.append(newNote)
        saveData()
    }
    
    func delete(index: IndexSet) {
        notes.remove(atOffsets: index)
        saveData()
    }
    
    func update(note: NoteItem, title: String, content: String) {
        guard let index = notes.firstIndex(of: note) else { return }
        notes[index].title = title
        notes[index].content = content
        saveData()
    }
    
    private func saveData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(notes) {
            UserDefaults.standard.set(encoded, forKey: "notes")
        }
        UserDefaults.standard.set(noteContent, forKey: "noteContent")
    }
    
    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: "notes") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([NoteItem].self, from: data) {
                notes = decoded
            }
        }
    }
}
