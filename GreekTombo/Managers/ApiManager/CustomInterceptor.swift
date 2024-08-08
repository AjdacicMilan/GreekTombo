//
//  CustomInterceptor.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation
import Alamofire

public class CustomInterceptor: RequestInterceptor {
    
    public init() {}
    
    private var retryCounter: Int = 0
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if retryCounter > 0 {
            completion(.doNotRetry)
            return
        }
        self.retryCounter += 1
        completion(.retry)
    }
}
