import Foundation

final class UserRepository {
    private let registeredUsersKey = "registeredUsers"
    private let currentUserKey = "currentUser"
    
    // MARK: - Kayıt
    func register(user: User) -> Bool {
        var users = getAllUsers()
        if users.contains(where: { $0.username == user.username }) {
            return false
        }
        users.append(user)
        saveUsers(users)
        saveCurrentUser(user.username)
        return true
    }
    
    // MARK: - Giriş
    func login(username: String, password: String) -> Bool {
        let users = getAllUsers()
        guard users.contains(where: { $0.username == username && $0.password == password }) else {
            return false
        }
        saveCurrentUser(username)
        return true
    }
    
    // MARK: - Çıkış
    func logout() {
        UserDefaults.standard.removeObject(forKey: currentUserKey)
    }
    
    // MARK: - Aktif kullanıcı adı (global erişim için static eklenebilir)
    func getCurrentUsername() -> String? {
        return UserDefaults.standard.string(forKey: currentUserKey)
    }
    
    static var currentUsername: String {
        return UserDefaults.standard.string(forKey: "currentUser") ?? "duru_aydogdu"
    }
    
    // MARK: - Aktif kullanıcı objesi
    func getCurrentUser() -> User? {
        guard let username = getCurrentUsername() else { return nil }
        return getAllUsers().first(where: { $0.username == username })
    }
    
    // MARK: - Kayıtlı kullanıcıları getir
    private func getAllUsers() -> [User] {
        guard let data = UserDefaults.standard.data(forKey: registeredUsersKey),
              let users = try? JSONDecoder().decode([User].self, from: data) else {
            return []
        }
        return users
    }
    
    // MARK: - Kullanıcıları kaydet
    private func saveUsers(_ users: [User]) {
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: registeredUsersKey)
        }
    }
    
    // MARK: - Aktif kullanıcı adını kaydet
    private func saveCurrentUser(_ username: String) {
//        UserDefaults.standard.set(username, forKey: currentUserKey)
        UserDefaults.standard.set("duru_aydogdu", forKey: currentUserKey)
        
    }
    
    func resetAllData() {
        UserDefaults.standard.removeObject(forKey: "registeredUsers")
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }
}
