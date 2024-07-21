//
//  UserManager.swift
//  Domain
//
//  Created by 김동준 on 7/21/24
//

public class UserManager {
    public static let shared = UserManager()
    
    init(
        id: Int = -1,
        email: String = "-",
        role: String = "-"
    ) {
        self.id = id
        self.email = email
        self.role = role
    }
    
    public var id: Int
    public var email: String
    public var role: String
    
    public func setUserInfo(id: Int, email: String, role: String) {
        self.id = id
        self.email = email
        self.role = role
    }
}
