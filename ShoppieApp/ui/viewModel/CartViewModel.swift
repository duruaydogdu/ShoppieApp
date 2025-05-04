import Foundation

final class CartViewModel {

    private(set) var items: [CartItem] = []

    var totalAmount: Int {
        items.reduce(0) { $0 + ($1.fiyat * $1.siparisAdeti) }
    }

    func loadCartItems(completion: @escaping () -> Void) {
        CartRepository.shared.fetchCartItems { [weak self] fetchedItems in
            self?.items = fetchedItems 
            completion()
        }
    }


    func numberOfItems() -> Int {
        items.count
    }

    func item(at index: Int) -> CartItem {
        items[index]
    }

    func removeItem(at index: Int, completion: @escaping () -> Void) {
        let sepetId = items[index].sepetId
        CartRepository.shared.removeFromCart(sepetId: sepetId) { [weak self] success in
            if success {
                self?.items.remove(at: index)
            }
            completion()
        }
    }
}
