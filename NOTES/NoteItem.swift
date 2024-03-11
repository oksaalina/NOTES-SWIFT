//
//  NoteItem.swift
//  NOTE
//
//  Created by Алина Кузнецова on 05.03.2024.
//

import Foundation

struct NoteItem : Identifiable, Equatable, Codable {
    var id: UUID
    var title: String
    var content: String
    var lastModifiedDate: Date
    
    init(id: UUID = UUID(), title: String, content: String, lastModifiedDate: Date = Date()) {
        self.id = id
        self.title = title
        self.content = content
        self.lastModifiedDate = lastModifiedDate
    }
}
