//
//  UserManager.swift
//  Domain
//
//  Created by 김동준 on 7/21/24
//

public class UserManager {
    public static let shared = UserManager()
    
    private init() {}
    
    public var id: Int = -1
    public var email: String = "-"
    public var role: String = "-"
    
    public func setUserInfo(id: Int, email: String, role: String) {
        self.id = id
        self.email = email
        self.role = role
    }
}
