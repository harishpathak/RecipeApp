//
//  RecipeCategoryCardView.swift
//  Recipes
//
//  Created by Harish on 02/05/2026.
//

import SwiftUI

struct RecipeCategoryCardView: View {
    var category: CategoryDisplayModel
    var selectedCategoryName: String
    var body: some View {
        VStack {
            AsyncImage(url: category.imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                    .padding(5)
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .clipShape(Circle())
            .frame(width: 60, height: 60)
            .overlay {
                let color = selectedCategoryName == category.name ? Color.orange.opacity(0.8) : Color.orange.opacity(0.1)
                Circle().stroke(color, lineWidth: 2)
            }
            
            Text(category.name)
                .font(.headline)
        }
    }
}

#Preview {
    RecipeCategoryCardView(category: CategoryDisplayModel(from: CategoryDTO(idCategory: "", strCategory: "Indian", strCategoryThumb: "https://www.themealdb.com/images/media/meals/a4kgf21763075288.jpg", strCategoryDescription: "")), selectedCategoryName: "Indian")
}

