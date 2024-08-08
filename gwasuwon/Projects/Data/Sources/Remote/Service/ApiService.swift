//
//  ApiService.swift
//  Data
//
//  Created by 김동준 on 6/7/24
//

import Foundation
import Domain

public struct ApiService {
    public init() {}
    
    func callApiService(
        httpMethod: HttpMethod,
        endPoint: String,
        queryParameter: Encodable? = nil,
        body: Encodable? = nil
    ) async -> Result<Data, NetworkError> {
        do {
            var count: Int = 1
            
            guard var url = URL(string: "\(BaseUrl.environment.rawValue)\(endPoint)") else {
                return .failure(NetworkError.requestURLNotExistError)
            }
            
            if let queryParameter = queryParameter {
                guard let queryDictionary = try? queryParameter.toDictionary() else {
                    return .failure(NetworkError.queryParameterError)
                }
                
                let queryItems = getQueryParameter(queryDictionary: queryDictionary)
                url.append(queryItems: queryItems)
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = httpMethod.rawValue
            urlRequest.timeoutInterval = 60
            
            while (count > 0) {
                count -= 1
                urlRequest.allHTTPHeaderFields = getHeaders()
                
                if let body = body {
                    guard let httpBody = try? JSONEncoder().encode(body) else {
                        throw NetworkError.bodyEncodingError
                    }
                    urlRequest.httpBody = httpBody
                    print("🤩😅🤣😂🙄🫠🥰😏😐🤥🤮🤓🤩😅🤣😂🙄🫠🥰😏😐🤥🤮🤓\n🥰[HTTP BODY] = \(body)\n🤩😅🤣😂🙄🫠🥰😏😐🤥🤮🤓🤩😅🤣😂🙄🫠🥰😏😐🤥🤮🤓\n")
                    print("🐵🐯🐭😾🐶🐷🐴🐟🐠🐡🦈🐬🦦🦐🦍🐧🐙🐊🐸🐔🐼🦄🦉🐿️\n🥰[HTTP HEADER] = \(urlRequest.allHTTPHeaderFields)\n🐵🐯🐭😾🐶🐷🐴🐟🐠🐡🦈🐬🦦🦐🦍🐧🐙🐊🐸🐔🐼🦄🦉🐿️\n")
                }
                
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                    return .failure(NetworkError.responseError)
                }

                print("🎵🎼🎸🥁🎹🎻🎷🎤📯🪘📻🪗🎵🎼🎸🥁🎹🎻🎷🎤📯🪘📻🪗\n🎸[RequestURL] = \(url)\n🎸[StatusCode] = \(statusCode) / [HTTPMethod] = \(httpMethod.rawValue)\n🎵🎼🎸🥁🎹🎻🎷🎤📯🪘📻🪗🎵🎼🎸🥁🎹🎻🎷🎤📯🪘📻🪗\n")

                if let str = String(data: data, encoding: .utf8) {
                    print("🧡❤️💚💙🖤🤎💛💝💖💕💗💓🧡❤️💚💙🖤🤎💛💝💖💕💗💓\n❤️[Sucessfully Decoded String Data]\n\(str)\n🧡❤️💚💙🖤🤎💛💝💖💕💗💓🧡❤️💚💙🖤🤎💛💝💖💕💗💓\n")
                }
                
                let range = 200..<300
                if (range.contains(statusCode)) {
                    return .success(data)
                } else {
                    let error = networkErrorHandling(statusCode)
                    if (error != .unAuthorizationError) {
                        return .failure(error)
                    } else {
                        count += 1
                        let isRefreshSuccess = await postRefreshToken()
                        if (isRefreshSuccess == false) { return .failure(error) }
                    }
                }
            }
            return .failure(.unKnownError)
        } catch URLError.Code.notConnectedToInternet, URLError.notConnectedToInternet {
            return .failure(NetworkError.internetConnectionError)
        } catch URLError.timedOut {
            return .failure(NetworkError.timeout)
        } catch {
            return .failure(NetworkError.unKnownError)
        }
    }
}

extension ApiService {
    private func getHeaders() -> [String: String] {
        let accessToken: String = KeyChainStorage.read(key: KeyStorageKeys.ACCESS_TOKEN) ?? ""
        let tokenString: String = accessToken.isEmpty ? "" : "Bearer \(accessToken)"
        return  [
            "Authorization": tokenString,
            "Content-Type": "application/json; charset=utf-8",
            "Accept-Charset": "UTF-8"
        ]
    }
    
    private func getQueryParameter(queryDictionary: [String: Any]) -> [URLQueryItem] {
        var queryList: [URLQueryItem] = []
        
        queryDictionary.forEach { key, value in
            queryList.append(URLQueryItem(name: key, value: "\(value)"))
        }
        
        return queryList
    }
    
    private func networkErrorHandling(_ status: Int) -> NetworkError {
        switch (status) {
        case 400:
            return .badRequest
        case 401:
            return .unAuthorizationError
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 500..<600:
            return .internalServerError
        default:
            return .unKnownError
        }
    }
}

// MARK: For Refresh Token
extension ApiService {
    private func postRefreshToken() async -> Bool {
        let refreshToken = KeyChainStorage.read(key: KeyStorageKeys.REFRESH_TOKEN) ?? ""
        
        do {
            guard let url = URL(string: "\(BaseUrl.environment.rawValue)\(AccountEndPoint.refreshToken.url)") else {
                return false
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HttpMethod.POST.rawValue
            urlRequest.timeoutInterval = 60
            
            urlRequest.allHTTPHeaderFields = getHeaders()
            
            let body: Encodable? = RefreshTokenRequest(refreshToken: refreshToken)
            
            if let body = body {
                guard let httpBody = try? JSONEncoder().encode(body) else {
                    throw NetworkError.bodyEncodingError
                }
                urlRequest.httpBody = httpBody
                print("🤩😅🤣😂🙄🫠🥰😏😐🤥🤮🤓🤩😅🤣😂🙄🫠🥰😏😐🤥🤮🤓\n🥰[HTTP BODY] = \(body)\n🤩😅🤣😂🙄🫠🥰😏😐🤥🤮🤓🤩😅🤣😂🙄🫠🥰😏😐🤥🤮🤓\n")
                print("🐵🐯🐭😾🐶🐷🐴🐟🐠🐡🦈🐬🦦🦐🦍🐧🐙🐊🐸🐔🐼🦄🦉🐿️\n🥰[HTTP HEADER] = \(urlRequest.allHTTPHeaderFields)\n🐵🐯🐭😾🐶🐷🐴🐟🐠🐡🦈🐬🦦🦐🦍🐧🐙🐊🐸🐔🐼🦄🦉🐿️\n")
            }
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return false
            }
            
            print("🎵🎼🎸🥁🎹🎻🎷🎤📯🪘📻🪗🎵🎼🎸🥁🎹🎻🎷🎤📯🪘📻🪗\n🎸[RequestURL] = \(url)\n🎸[StatusCode] = \(statusCode) / [HTTPMethod] = \(HttpMethod.POST.rawValue)\n🎵🎼🎸🥁🎹🎻🎷🎤📯🪘📻🪗🎵🎼🎸🥁🎹🎻🎷🎤📯🪘📻🪗\n")
            
            if let str = String(data: data, encoding: .utf8) {
                print("🧡❤️💚💙🖤🤎💛💝💖💕💗💓🧡❤️💚💙🖤🤎💛💝💖💕💗💓\n❤️[Sucessfully Decoded String Data]\n\(str)\n🧡❤️💚💙🖤🤎💛💝💖💕💗💓🧡❤️💚💙🖤🤎💛💝💖💕💗💓\n")
            }
            
            let range = 200..<300
            if (range.contains(statusCode)) {
                let decodedData = try JSONDecoder().decode(RefreshTokenResponse.self, from: data)
                KeyChainStorage.update(key: KeyStorageKeys.ACCESS_TOKEN, data: decodedData.accessToken)
                KeyChainStorage.update(key: KeyStorageKeys.REFRESH_TOKEN, data: decodedData.refreshToken)
                return true
            } else {
                KeyChainStorage.delete(key: KeyStorageKeys.ACCESS_TOKEN)
                KeyChainStorage.delete(key: KeyStorageKeys.REFRESH_TOKEN)
                return false
            }
        } catch URLError.Code.notConnectedToInternet, URLError.notConnectedToInternet {
            return false
        } catch URLError.timedOut {
            return false
        } catch {
            return false
        }
    }
}
