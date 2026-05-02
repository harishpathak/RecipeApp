//
//  RecipeDetailsView.swift
//  Recipes
//
//  Created by Harish on 02/05/2026.
//

import SwiftUI

struct RecipeDetailsView: View {
   @State private var viewModel: RecipeDetailsViewModel
    
    init(service: RecipesServiceProtocol, id: String) {
        _viewModel = State(initialValue: RecipeDetailsViewModel(service: service, id: id))
    }
    
    var body: some View {
        Group {
                if let recipe = viewModel.recipe {
                    ScrollView {
                        VStack {
                            AsyncImage(url: recipe.imageUrl) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                Image(systemName: "fork.knife")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(Color.blue.opacity(0.5))
                                    .padding(25)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal, 50)
                            .frame(height: 180)
                            .frame(maxWidth: .infinity)
                            
                            Text(recipe.name)
                                .font(.headline)
                                .padding(.top, 10)
                            
                            Text("(\(recipe.category))")
                                .font(.subheadline)
                            
                            Text(recipe.instructions ?? "")
                                .font(.caption)
                                .padding(.top, 10)
                            
                            Spacer()
                        }
                        .padding(.top, 50)
                        .padding(.horizontal, 20)
                    }
                    
                } else {
                    VStack {
                        Spacer()
                        Text("Recipe details not found")
                        Spacer()
                    }
                }
        }
        .navigationTitle(viewModel.recipe?.name ?? "Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
           await viewModel.loadData()
        }
    }
}

#Preview {
    RecipeDetailsView(service: RecipeService(), id: "52772")
}
