//
//  RequestBuilder.swift
//  CovidHelper
//
//  Created by Raviteja on 15/05/21.
//

import Foundation
import Alamofire

class RequestFilesData {
    let url: String
    var method: HTTPMethod = .post
    let parameters: baseParameters?
    var headers: [String : String]?
    let fileData: [Data]
    let fileName : [String]
    let fileMimetype : [String]
    let fileparam : [String]
    let numberOfFiles: Int
    
    init(url: (URLS , APISuffix), method: HTTPMethod, parameters: baseParameters? = nil, headers: Bool , fileData: [Data] , fileName : [String] , fileMimetype : [String] , fileParam : [String], numberOfFiles: Int) {
        self.url = url.0.getDescription + url.1.getDescription
        self.method = method
        self.parameters = parameters
        if(headers){
            self.headers = [
                "Authorization": "Bearer ((UserData.shared?.getUserData?.token",
            ]
        }
        self.fileData = fileData
        self.fileMimetype = fileMimetype
        self.fileName = fileName
        self.fileparam = fileParam
        self.numberOfFiles = numberOfFiles
    }
    
    deinit {
        print(#file , "destructor called")
    }
}

class RequestFileData {
    let url: String
    var method: HTTPMethod = .post
    let parameters: baseParameters?
    var headers: [String : String]?
    let fileData: Data
    let fileName : String
    let fileMimetype : String
    let fileparam  :String
    
    init(url: (URLS , APISuffix), method: HTTPMethod, parameters: baseParameters? = nil, headers: Bool , fileData: Data , fileName : String , fileMimetype : String , fileParam : String) {
        self.url = url.0.getDescription + url.1.getDescription
        self.method = method
        self.parameters = parameters
        if(headers){
            //print((UserData.shared?.getUserData?.token ?? ""))
            self.headers = [
                "Authorization": "Bearer ((UserData.shared?.getUserData?.token",
                // "Accept": "application/json" ,
                //"Content-type": "multipart/form-data"
            ]
        }
        self.fileData = fileData
        self.fileMimetype = fileMimetype
        self.fileName = fileName
        self.fileparam = fileParam
    }
    
    deinit {
        print(#file , "destructor called")
    }
}

class Request {
    var url: String
    var method: HTTPMethod = .get
    var parameters: baseParameters?
    var headers: HTTPHeaders?
    
    init(url: (URLS , APISuffix), method: HTTPMethod, parameters: baseParameters? = nil, headers: Bool) {
        self.url = url.0.getDescription + url.1.getDescription
        self.method = method
        self.parameters = parameters
        self.headers = ["Content-Type": "application/json"]
        if(headers){
            self.headers = [
                "Authorization": "Bearer ((UserData.shared?.getUserData?.token",
                // "Accept": "application/json" ,
                //"Content-type": "multipart/form-data"
            ]
        }
    }
    
    deinit {
        print(#file , "destructor called")
    }
}

/*
 protocol EndPointAPIType {
 var baseURL:    URL {get}
 var headers: HTTPHeaders {get}
 }
 
 enum authEndpoint {
 case login(param: Parameters)
 }
 
 extension authEndpoint: EndPointAPIType {
 var baseURL: URL {
 switch self {
 case .login(_):
 return URL()
 }
 }
 
 var headers: HTTPHeaders {
 <#code#>
 }
 
 
 }
 */
