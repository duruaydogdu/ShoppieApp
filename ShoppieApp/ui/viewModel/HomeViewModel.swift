final class HomeViewModel {
    private(set) var allProducts: [Product] = []
    private(set) var filteredProducts: [Product] = []
    
    func loadProducts(completion: @escaping () -> Void) {
        ProductRepository.shared.fetchAllProducts { [weak self] products in
            self?.allProducts = products
            self?.filteredProducts = products
            completion()
        }
    }

    func numberOfItems() -> Int {
        return filteredProducts.count
    }

    func product(at index: Int) -> Product {
        return filteredProducts[index]
    }

    func search(query: String) {
        if query.isEmpty {
            filteredProducts = allProducts
        } else {
            filteredProducts = allProducts.filter { $0.ad.lowercased().contains(query.lowercased()) }
        }
    }
}
