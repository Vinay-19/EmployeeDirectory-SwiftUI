//
//  ContentView.swift
//  EmployeesList
//
//  Created by Vinay Kumar Thapa on 2023-01-30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var empUserResponse = [EmployeeDetails]()
    
    var body: some View {
        NavigationView{
            List(empUserResponse,id:\.uuid) { response in
                NavigationLink{
                    Form{
                        Text("Contact: \(response.phone_number)")
                        Text("Team: \(response.team)")
                        
                    }.navigationTitle("Employee Details").navigationBarTitleDisplayMode(.inline)
                    
                }label: {
                    HStack(spacing: 20){
                        AsyncImage(url: URL(string: response.photo_url_small)){ phase in
                            if let image = phase.image {
                                image.resizable()
                                    .scaledToFit()
                                    .clipShape(Capsule())
                            }else{
                                ProgressView()
                            }
                        }.frame(width: 80, height: 80)
                        VStack(alignment: .leading, spacing: 10){
                            Text(response.full_name)
                            Text(response.email_address)
                        }
                    }
                }
            }.task {
                await fetchEmployeeData()
            }.navigationTitle("Employees")
        }
    }
    
    func fetchEmployeeData() async {
        
        guard let url = URL(string: "https://run.mocky.io/v3/000c0dda-bbaf-4d52-9e1a-58d3a11e912b") else {
            print("Invalid URL")
            return
        }
        
        do{
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedReponse = try? JSONDecoder().decode(EmployeeList.self, from: data) {
                empUserResponse = decodedReponse.employees
            }
            
        }catch{
            print("Invalid Data")
        }
        
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
