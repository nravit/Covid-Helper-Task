//
//  Logger.swift
//  CovidHelper
//
//  Created by Raviteja on 15/05/21.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {
        
        print("\n ✈️ ✈️ ✈️ ✈️ ✈️ OUTGOING ✈️ ✈️ ✈️ ✈️ ✈️  \n")
        defer { print("\n - - - - - - - - - - OUTGOING END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
        \(urlAsString) \n\n
        \(method) \(path)?\(query) HTTP/1.1 \n
        HOST: \(host)\n
        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
    }
    
    static func log(response: URLResponse) {
        print("\n  🙄 🙄 🙄 🙄 🙄 INCOMING 🙄 🙄 🙄 🙄 🙄 \n")
        print("\n 👍🏻 👍🏻 👍🏻 👍🏻 👍🏻 SUCCESS 👍🏻 👍🏻 👍🏻 👍🏻 👍🏻 \n")
        defer { print("\n - - - - - - - - - - INCOMING END - - - - - - - - - - - -\n") }
        print("MIME Type : " ,(response.mimeType ?? ""))
        if let url = response.url {
            print("URL : " ,url)
        }
        print("Received Data Length : " , response.expectedContentLength , "Bytes")
    }
}

