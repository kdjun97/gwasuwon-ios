//
//  ClassRepositoryProtocol.swift
//  Domain
//
//  Created by 김동준 on 7/11/24
//

public protocol ClassRepositoryProtocol {
    func getClassList() async -> Result<[ClassInformation], NetworkError>
}
