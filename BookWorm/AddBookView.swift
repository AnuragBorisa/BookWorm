//
//  AddBookView.swift
//  BookWorm
//
//  Created by Anurag on 23/01/25.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    var hasValidInput : Bool {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || genre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        return true
    }
    let genres = ["Fantasy", "Horror", "Kids", "Mystery","Poetry" ,"Romance","Thriller"]
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Name of book",text:$title)
                    TextField("Author's name",text:$author)
                    
                    Picker("Genre",selection:$genre){
                        ForEach(genres,id: \.self){
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review"){
                    TextEditor(text:$review)
                    RatingView(rating: $rating)
                    
                    
                }
                
                Section{
                    Button("Save"){
                      let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
                .disabled(hasValidInput == false)
                
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}