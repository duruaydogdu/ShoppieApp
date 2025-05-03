import Foundation
import Alamofire

final class ProductRepository {
    static let shared = ProductRepository()

    func fetchAllProducts(completion: @escaping ([Product]) -> Void) {
        let url = "http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php"

        AF.request(url, method: .get).responseDecodable(of: APIResponse.self) { response in
            switch response.result {
            case .success(let apiResponse):
                completion(apiResponse.urunler)
            case .failure(let error):
                print("API Error:", error)
                completion([])
            }
        }
    }
}
