//
//  DetailView.swift
//  BookWorm
//
//  Created by Anurag on 24/01/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var genreImage : String {
        let validGenres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
             
        if validGenres.contains(book.genre){
            return book.genre
        }
        else {
            return "defaultGenre"
        }
    }
    
    var formattedDate: String {
        book.addDate.formatted(date: .numeric,time:.omitted)
    }
    
    let book : Book
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(genreImage)
                    .resizable()
                    .scaledToFit()
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x:-5,y:-5)
                
                
            }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.review)
                .padding()
            Text(formattedDate)
                .padding()
           
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
                
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar{
            Button("Delete this book",systemImage: "trash"){
                showingDeleteAlert = true
            }
        }
        .alert("Delete book",isPresented: $showingDeleteAlert){
            Button("Delete",role:.destructive,action:deleteBook)
            Button("Cancel",role:.cancel){}
        } message: {
            Text("Are you sure ?")
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly:true)
        let container = try ModelContainer(for:Book.self,configurations:config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4)
        
        return DetailView(book: example)
            .modelContainer(container)

    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
    
}
