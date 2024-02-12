//  Created by Jatin Menghani on 12/02/24.

import Foundation

public protocol MellowRequestProtcol {
    
    init(baseURL: URL, path: String, scheme: String)
    
    @discardableResult
    func set(method: MellowHttpMethod) -> Self
    
    @discardableResult
    func set(path: String) -> Self
    
    @discardableResult
    func set(scheme: String) -> Self
    
    @discardableResult
    func set(headers: [String:String]?) -> Self
    
    @discardableResult
    func set(parameters: MellowRequestParams) -> Self
}
