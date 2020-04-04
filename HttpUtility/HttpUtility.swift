//
//  HttpUtility.swift
//  HttpUtility
//
//  Created by Pradeep on 04/04/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import Foundation


struct HttpUtility{
    
    func getDataFromApi<T: Decodable>(requestUrl: URL, resultType:T.Type, completionHandler:@escaping (_ result: T) -> Void) {
        
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            
            if (error == nil && data != nil && data?.count != 0) {
                
                let jsonDecoder = JSONDecoder()
                do {
                    let result = try jsonDecoder.decode(T.self, from: data!)
                    
                    _ = completionHandler(result)
                } catch let error {
                    debugPrint(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func postApiData<T:Decodable>(requestUrl:String,requestBody:Data, resultType: T.Type, completionHandler:@escaping(_ result:T) -> Void) {
          
          let requestApiUrl = URL(string: requestUrl)!
          var urlRequest = URLRequest(url: requestApiUrl)
          urlRequest.httpMethod = "post"
          urlRequest.httpBody = requestBody
          urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
              URLSession.shared.dataTask(with: urlRequest) { (responseData, httpUrlResponse, error) in
                  
                  if(error == nil && httpUrlResponse != nil && responseData?.count != 0){
                      // parse the response data here
                      let decoder = JSONDecoder()
                      do {
                          let result = try decoder.decode(T.self, from: responseData!)
                          _=completionHandler(result)
                          
                      } catch let error {
                          debugPrint("error occured while decoding = \(error.localizedDescription)")
                      }
                  }
              }
          .resume()
      }
}

