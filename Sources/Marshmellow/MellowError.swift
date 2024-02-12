//  Created by Jatin Menghani on 12/02/24.

import Foundation

public enum MellowError: Error {
    case invalidURL(URL?)
    case invalidResponse(HTTPURLResponse?)
    case invalidData(Data?)
    case statusCode(Int)
    case noData
    case unableToComplete
}
