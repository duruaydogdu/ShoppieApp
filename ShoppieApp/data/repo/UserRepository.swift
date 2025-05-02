import Foundation

final class UserRepository {
    private let registeredUsersKey = "registeredUsers"
    private let currentUserKey = "currentUser"

    // MARK: - Kayıt
    func register(user: User) -> Bool {
        var users = getAllUsers()
        // Kullanıcı adı benzersiz mi kontrol et
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

    // MARK: - Aktif kullanıcı adı
    func getCurrentUsername() -> String? {
        return UserDefaults.standard.string(forKey: currentUserKey)
    }

    // MARK: - Aktif kullanıcı objesi
    func getCurrentUser() -> User? {
        guard let username = getCurrentUsername() else { return nil }
        return getAllUsers().first(where: { $0.username == username })
    }

    // MARK: - Kayıtlı tüm kullanıcıları getir
    private func getAllUsers() -> [User] {
        guard let data = UserDefaults.standard.data(forKey: registeredUsersKey),
              let users = try? JSONDecoder().decode([User].self, from: data) else {
            return []
        }
        return users
    }

    // MARK: - Kayıtlı kullanıcıları kaydet
    private func saveUsers(_ users: [User]) {
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: registeredUsersKey)
        }
    }

    // MARK: - Aktif kullanıcı adını kaydet
    private func saveCurrentUser(_ username: String) {
        UserDefaults.standard.set(username, forKey: currentUserKey)
    }
}
