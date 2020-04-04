//
//  Employee.swift
//  HttpUtility
//
//  Created by Pradeep on 04/04/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import Foundation

struct EmployeeResponse: Decodable {
    let id: Int
    let name, role, joiningDate: String
    let depID, salary: Int
    let workPhone: String

    enum CodingKeys: String, CodingKey {
        case id, name, role, salary, workPhone
        case joiningDate = "joining_date"
        case depID = "dep_id"
    }
}
struct ReportResponse:  Decodable{
    let reports:[Report]
}
struct Report: Decodable {
    let id: Int
    let labourHours,totalCost: String
}

struct RegisterUserEncoding :Encodable{
    
    let firstName,lastName,email,password:String
    
    enum CodingKeys:String, CodingKey{
        
        case firstName = "First_Name"
        case lastName = "Last_Name"
        case email = "Email"
        case password = "Password"
    }
}
struct RegistrationResponse: Decodable {
    let errorMessage: String
    let data: DataClass

}

// MARK: - DataClass
struct DataClass: Decodable {
    let name, email, id, joining: String

//    enum CodingKeys: String, CodingKey {
//        case name = "Name"
//        case email = "Email"
//        case id = "Id"
//        case joining = "Joining"
//    }
}


struct Employee{
    
    private let httpUtility: HttpUtility
    
    init(_httpUtility: HttpUtility) {
        httpUtility = _httpUtility
    }
    
    func getEmployeeData() {
        
        httpUtility.getDataFromApi(requestUrl: URL(string: EndPoint.apiUrl)!, resultType: [EmployeeResponse].self) { (employeeResult) in
            
            for emp in employeeResult {
                debugPrint("Emp id = \(emp.id) joining = \(emp.joiningDate) phone = \(emp.workPhone)")
            }
        }
    }
    
    func getReportData()  {
        
        httpUtility.getDataFromApi(requestUrl: URL(string: EndPoint.reportUrl)!, resultType: ReportResponse.self) { (reportResponse) in
            
            for reports in reportResponse.reports {
                debugPrint("reports id = \(reports.id) labourHours = \(reports.labourHours) totalcost = \(reports.totalCost)")
            }
        }
    }
    
    func postApiData()  {
        
        let requestBody = RegisterUserEncoding(firstName: "vivek", lastName: "pratap", email: "vivek@gmail.com", password: "99999")
        do {
            let requestData = try JSONEncoder().encode(requestBody)
            httpUtility.postApiData(requestUrl: EndPoint.registerUser, requestBody: requestData, resultType: RegistrationResponse.self, completionHandler: { (response) in
                debugPrint(response.data.name)
            })
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    func getUserData()  {
        
        var urlRequest = URLRequest(url: URL(string: EndPoint.getUser)!)

        urlRequest.httpMethod = "get"

        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            if(data != nil && data?.count != 0)
            {
                //use decodable here to parse the json response, if you are new to decodable then watch the video
                //decodable video: https://youtu.be/RiuvxmoU37E
                let response = String(data: data!, encoding: .utf8)
                debugPrint(response!)
            }
        }.resume()
        
        URLSession.shared.dataTask(with: URL(string: EndPoint.getUser)!) { (data, response, error) in
           if(data != nil && data?.count != 0)
            {
                //use decodable here to parse the json response, if you are new to decodable then watch the video
                //decodable video: https://youtu.be/RiuvxmoU37E
                let response = String(data: data!, encoding: .utf8)
                debugPrint(response!)
            }
        }.resume()
    }
}
