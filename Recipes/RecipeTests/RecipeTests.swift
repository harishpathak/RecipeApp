//
//  RecipeTests.swift
//  RecipeTests
//
//  Created by Harish on 11/05/2026.
//

import XCTest
@testable import Recipes

@MainActor
class RecipeServiceMock: RecipesServiceProtocol {
    var categoryFetched: String = ""
    var categoryError: APIError?
    var recipeError: APIError?
    var withContinuation: Bool = false
    var continuation: CheckedContinuation<[Recipes.CategoryDisplayModel], Never>?
    func fetchRecipes(category: String) async throws -> [Recipes.Recipe] {
        categoryFetched = category
        if let recipeError = recipeError {
            throw recipeError
        }
        let recipe1 = Recipe(id: "1", name: "Biryani")
        let recipe2 = Recipe(id: "2", name: "Kebab")
        return [recipe1, recipe2]
    }
    
    func fetchRecipeCategories() async throws -> [Recipes.CategoryDisplayModel] {
        if withContinuation {
            return await withCheckedContinuation { cont in
                self.continuation = cont
            }
        } else {
            if let categoryError = categoryError {
                throw categoryError
            }
            return [CategoryDisplayModel(id: "1", name: "Beef", imageUrl: URL(string:""), description: "")]
        }
    }
    
    func fetchRecipe(with id: String) async throws -> Recipes.RecipeDetails {
        return RecipeDetails(id: "1", name: "Biryani", category: "Beef", imageUrl: URL(string:""), instructions: "")
    }
}

@MainActor
final class RecipeTests: XCTestCase {
    var sut: RecipeListViewModel!
    var mockService: RecipeServiceMock!
    
    override func setUp() async throws {
        mockService = RecipeServiceMock()
        sut = RecipeListViewModel(service: mockService)
    }
    
    override func tearDown() async throws {
        mockService = nil
        sut = nil
    }
    
    func testInitialLoad() async {
        await sut.loadData()
        
        XCTAssert(sut.categories.count > 0)
        XCTAssert(sut.selectedCategory == "Beef")
        XCTAssert(sut.recipes.count > 0)
        XCTAssert(sut.viewState == .success)
    }
    
    func testLodingState() async {
        mockService.withContinuation = true
        let task = Task {
            await sut.loadData()
        }
        while mockService.continuation == nil {
            await Task.yield()
        }
        XCTAssert(sut.viewState == .loading)
        mockService.continuation?.resume(with: .success([]))
        await task.value
        XCTAssert(sut.viewState == .success)
    }
    
    func testSelectCategory() async {
        await sut.selectCategory(category: "Indian")
        
        XCTAssert(mockService.categoryFetched == "Indian")
        XCTAssert(sut.selectedCategory == "Indian")
    }
    
    func testErrorState() async {
        mockService.categoryError = APIError.apiError
        
        await sut.loadData()
        
        XCTAssert(sut.categories.count == 0)
        XCTAssert(sut.recipes.count == 0)
        XCTAssert(sut.viewState == .error)
    }
    
    func testRecipeErrorState() async {
        mockService.recipeError = APIError.apiError
        
        await sut.loadData()
        
        XCTAssert(sut.categories.count > 0)
        XCTAssert(sut.recipes.count == 0)
        XCTAssert(sut.viewState == .error)
    }
    
    func testRecipeErrorOnSelectionState() async {
        mockService.recipeError = APIError.apiError
        
        await sut.selectCategory(category: "Indian")
        
        XCTAssert(sut.recipes.count == 0)
        XCTAssert(sut.viewState != .error)
    }
   
}
