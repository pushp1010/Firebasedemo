//
//  IssueDetailViewController.swift
//  Firebase-Issue
//
//  Created by PushpendraSingh on 24/06/19.
//  Copyright © 2019 PushpendraSingh. All rights reserved.
//

import UIKit


 let internetErrorTitle = "No Connection"
 let internetErrorMessage = "Please check your internet connectivity and try again"
 let internetErrorCode = -1009

 let genericErrorTitle = "Something went wrong"
 let genericErrorMesssage = "The server encountered a temporary error and could not serve your request. Please try again in some time."

 typealias completion = ((Data?,[Dictionary<String,Any>]?,ApplicationError?)->Void)?

public enum RequestType:String{
  case GET = "GET"
  case POST = "POST"
  case DELETE = "DELETE"
  case PUT = "PUT"
}

 enum ContentType:String
{
	case applicationJSON = "application/json"
  case applicationEncoded = "application/x-www-form-urlencoded"
}

//protocol ApplicationProtocol: Error {
//
//  var localizedTitle: String { get }
//  var localizedDescription: String { get }
//  var code: Int { get }
//}

struct ApplicationError:Error{
    var localizedTitle: String
    var code: Int
    var localizedDescription: String
  
   init(localizedTitle: String, localizedDescription: String, code: Int) {
    self.localizedTitle = localizedTitle
    self.localizedDescription = localizedDescription
    self.code = code
  }
}

class ConnectionManager {
  
    var completionHandler:completion
    
    init(){
        completionHandler = nil
    }
  

   func getDataJsonContentType(with url:URL, completion: @escaping (Data?, [Dictionary<String,Any>]?, ApplicationError?) -> Swift.Void) -> Void {
    self.completionHandler = completion
    if Reachability().isConnectedToNetwork() {
      self.sendRequest(urlRequest: self.creatURLRequest(contentType:.applicationJSON, requestType: .GET, param: nil, url: url))
    }
    else
    {
     self.showNetworkError()
    }
  }
    
    func putDataWithApplicationJSON(with url: URL,
                                    postBody: Data,
                                    completion: @escaping (Data?, [Dictionary<String,Any>]?, Error?) -> Swift.Void) -> Void {
        self.completionHandler = completion
        if Reachability().isConnectedToNetwork() {
            
            self.sendRequest(urlRequest: self.creatURLRequest(contentType: .applicationJSON,
                                                              requestType: .PUT,
                                                              param:postBody,
                                                              url: url))
        } else {
            self.showNetworkError()
        }
    }
    
    
     func postDataWithApplicationJSON(with url: URL,
                                          postBody: Data,
                                          completion: @escaping (Data?, [Dictionary<String,Any>]?, ApplicationError?) -> Swift.Void) -> Void {
        self.completionHandler = completion
        if Reachability().isConnectedToNetwork() {
            self.sendRequest(urlRequest:self.creatURLRequest(contentType: .applicationJSON,
                                                             requestType: .POST,
                                                             param:postBody,
                                                             url: url))
        } else {
            self.showNetworkError()
        }
    }
    
     func deleteDataWithApplicationJSON(with url: URL,
                                              postBody: Data?,
                                              completion: @escaping (Data?,
        [Dictionary<String,Any>]?,
        ApplicationError?) -> Swift.Void) -> Void {
        self.completionHandler = completion
        if Reachability().isConnectedToNetwork() {
            
            self.sendRequest(urlRequest: self.creatURLRequest(contentType: .applicationJSON,
                                                              requestType: .DELETE,
                                                              param: postBody,
                                                              url: url))
        } else {
            self.showNetworkError()
        }
    }
    
  
    func sendRequest(urlRequest:URLRequest) -> Void {
    
    DispatchQueue.global(qos: .background).async {
      let session = URLSession(configuration: .default)
      let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
        
       
        
        if error != nil {
          UIAlertController.showAlert(title:"Error" , message:error!.localizedDescription)
          if let handler = self.completionHandler {
            handler(nil,nil,ApplicationError(localizedTitle: "Network Connection", localizedDescription: error!.localizedDescription, code: -1001))
          }
        } else {
          
          let httpResponse = response as? HTTPURLResponse
          
            print("statusCode: \(String(describing: httpResponse?.statusCode))")
            print("statusCode: \(String(describing: httpResponse?.url?.absoluteString))")
            
            switch httpResponse?.statusCode {
            case 200, 201,204 :
                if let handler = self.completionHandler {
                    if error != nil{
                        handler(data,nil, ApplicationError(localizedTitle:"Error", localizedDescription: HTTPURLResponse.localizedString(forStatusCode:(httpResponse?.statusCode)! ), code: (httpResponse?.statusCode)!))
                    }
                    else{
                        handler(data, nil, nil)
                    }
                }
            case 400,401,404:
                if let handler = self.completionHandler {
                    
                    handler(nil,nil , ApplicationError(localizedTitle:"Error", localizedDescription: HTTPURLResponse.localizedString(forStatusCode:(httpResponse?.statusCode)! ), code: (httpResponse?.statusCode)!))
                }
                
            default :
                self.parseError(data: data!)
            }
        }
               
      })
      task.resume()
    }
  }
        
  private  func parseError(data:Data) -> Void {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                print(json)
                let dict:[String:Any] = json as [String: Any]
                
                if dict["errors"] != nil {
                    let messages:[String] = dict["errors"] as! [String]
                    var message:String =  ""
                    for error in messages
                    {
                        message = message + error
                    }
                    self.returnHandler(title: "", errorDescription: message, code: 999)
                }
            }
        }
        catch {
            self.returnHandler(title: genericErrorTitle,
                               errorDescription: genericErrorMesssage,
                               code: 999)
        }
    }
    
    private func returnHandler(title:String, errorDescription: String, code: Int) -> Void {
        if let handler = self.completionHandler {
            handler(nil,nil,ApplicationError(localizedTitle: title,
                                             localizedDescription: errorDescription,
                                             code: code))
        }
    }
  
  private  func creatURLRequest(contentType:ContentType,requestType:RequestType,param:Data?,url:URL)-> URLRequest
  {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = requestType.rawValue
    if (param != nil){
      urlRequest.httpBody = param
    }
    urlRequest.addValue(contentType.rawValue, forHTTPHeaderField:"Content-Type")
    return urlRequest
  }
    
 private func showNetworkError()
    {
        UIAlertController.showAlert(title: "Network Connection", message: "There is no internet connection")
        
        if let handler = self.completionHandler {
       handler(nil,nil,ApplicationError(localizedTitle: "Network Connection" , localizedDescription: "There is no internet connection", code: -1009))
        }
    }
}
