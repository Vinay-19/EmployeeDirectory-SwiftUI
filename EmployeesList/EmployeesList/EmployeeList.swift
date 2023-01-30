//
//  Response.swift
//  EmployeesList
//
//  Created by Vinay Kumar Thapa on 2023-01-30.
//

import Foundation


struct EmployeeList: Codable{
    
    var employees: [EmployeeDetails]
    
}

struct EmployeeDetails: Codable {
    var uuid: String
    var full_name: String
    var phone_number: String
    var email_address: String
    var team: String
    var photo_url_small: String
    var photo_url_large: String
    
}
