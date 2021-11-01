import Foundation

final class KeyChainHelper {
    static let standard = KeyChainHelper()
    private init(){
        
    }
    
    func save(data: Data, service: String, account: String) {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        if status != errSecSuccess {
            print("Error: \(status)")
        }
    }
    
    func save<T>(item: T, service: String, account: String) where T : Codable {
        do {
            let data = try JSONEncoder().encode(item)
            save(data: data, service: service, account: account)
        } catch {
            assertionFailure("fail to decode item for keychain: \(error)")
        }
    }

    func read(service: String, account: String) -> Data?{
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable{
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("fail to decode item for keychain: \(error)")
            return nil
        }
    }
    
    func delete(service: String, account: String){
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        SecItemDelete(query)
    }
    
    func update(data: Data, service: String, account: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let attributes = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary
        
        SecItemUpdate(query, attributes)
    }
    
    func update<T>(item: T, service: String, account: String) where T : Codable{
        do {
            let data = try JSONEncoder().encode(item)
            update(data: data, service: service, account: account)
        }
        catch {
            assertionFailure("fail to decode item for keychain: \(error)")
        }
    }
}
