//
//  RecipeListView.swift
//  Recipes
//
//  Created by Harish on 01/05/2026.
//

import SwiftUI

struct RecipeListView: View {
    @State private var viewModel: RecipeListViewModel
    
    init(service: RecipesServiceProtocol) {
        _viewModel = State(initialValue: RecipeListViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.viewState {
                case .loading:
                    VStack {
                        ProgressView {
                            Text("Loading...")
                        }
                    }
                case .success:
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(viewModel.categories) { category in
                                    RecipeCategoryCardView(category: category, selectedCategoryName: viewModel.selectedCategory)
                                    .padding(.horizontal, 10)
                                    .onTapGesture {
                                        Task {
                                            await viewModel.selectCategory(category: category.name)
                                        }
                                    }
                                }
                            }
                            .frame(height: 100)
                        }
                        if viewModel.recipes.isEmpty {
                            Spacer()
                            Text("No recipes for selected category")
                            Spacer()
                        } else {
                            List(viewModel.recipes) { recipe in
                                NavigationLink {
                                    RecipeDetailsView(service: viewModel.service, id: recipe.id)
                                } label: {
                                    Text(recipe.name)
                                }
                            }
                        }
                    }
                case .error:
                    VStack(spacing: 10) {
                        Button {
                            Task { await viewModel.loadData() }
                        } label: {
                            Image(systemName: "arrow.trianglehead.2.counterclockwise")
                                .foregroundStyle(.blue)
                                .font(.title)
                        }
                        Text("Something went wrong, please try again")
                            .font(.headline)
                    }
                }
            }
            .navigationTitle(viewModel.title)
        }
        .task {
            await viewModel.loadData()
        }
    }
}

#Preview {
    RecipeListView(service: RecipeService())
}
