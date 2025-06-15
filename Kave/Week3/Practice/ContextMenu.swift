//
//  ContextMenu.swift
//
//
//  Created by Jimin on 6/9/25.
//

import SwiftUI

struct ContextMenu: View {
    @State private var commentText = ""
    @State private var comments: [String] = []
    
    var body: some View {
        VStack {
            HStack {
                Text("Comment")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            Spacer()
            
            List {
                ForEach(comments, id: \.self) { comment in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(comment)
                            .font(.body)
                            .foregroundColor(.black)
                    }
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical, 10)
                    .padding(.horizontal, 4)
                    // MARK: Context Menu
                    // .contextMenu {
                    //     Button(role: .destructive, action: {
                    //         deleteComment(comment)
                    //     }) {
                    //         Label("삭제", systemImage: "trash")
                    //     }
                    // }

                    // MARK: Context Menu - Section
                    // .contextMenu {
                    //     Button("삭제") {}
                    //     Section {
                    //         Button("복사") {}
                    //         Button("번역") {}
                    //         Button("더 보기...") {}
                    //     }
                    // }

                    // MARK: Context Menu - Divider
                    .contextMenu {
                        Button("삭제") {}
                        Divider()
                        Button("복사") {}
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            HStack {
                TextField(
                    "",
                    text: $commentText,
                    prompt: Text("댓글을 입력하세요").foregroundColor(.white),
                    axis: .vertical
                )
                .padding(.vertical, 13)
                .padding(.horizontal, 21)
                .background(Color.black.opacity(0.7))
                .cornerRadius(23.5)
                .foregroundColor(.white)
                .padding(.trailing, 8)
                .onSubmit {
                    if !commentText.trimmingCharacters(in: .whitespaces).isEmpty {
                        comments.append(commentText)
                        commentText = ""
                    }
                }
                
                Button(action: {
                    if !commentText.trimmingCharacters(in: .whitespaces).isEmpty {
                        comments.append(commentText)
                        commentText = ""
                    }
                }) {
                    Image(systemName: "arrow.up")
                        .padding(14)
                        .background(.orange)
                        .foregroundColor(.white)
                        .cornerRadius(23.5)
                }
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .background(.white)
    }
    private func deleteComment(_ comment: String) {
        comments.removeAll { $0 == comment }
    }
}


#Preview {
    ContextMenu()
}
