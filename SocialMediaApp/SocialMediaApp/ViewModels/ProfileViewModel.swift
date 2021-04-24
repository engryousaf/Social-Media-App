//
//  ProfileViewModel.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 23/04/2021.
//

import UIKit
import Foundation

class ProfileViewModel {

    var dataSource: GenericDataSource<ProfileDetails>
    var onError: ((String) -> ())?
    
    var errorMessage: String = "" {
        didSet {
            onError?(errorMessage)
        }
    }
    
    init(dataSource: GenericDataSource<ProfileDetails>) {
        self.dataSource = dataSource
    }
    
    func getUserProfile(userId: Int){
       
        if Reachability.isConnectedToNetwork(){
            let url = AssignmentURL.getUserProfile + "\(userId)"
            Service.shared.getUserProfile(url: URL(string: url)!) { (data, error) in
                if let error = error
                {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let data = data else {return}
                do{
                   let response = try JSONDecoder().decode(ProfileBaseData.self, from: data)
                    if(response.code == 200){
                        let profileArray = self.profileDataFormating(profileData: response)
                        self.dataSource.data.value = profileArray
                    }else{
                        self.errorMessage = Constant.shared.somethingWent
                    }
                   
                }catch{
                    self.errorMessage = error.localizedDescription
                }
            }
        }else{
            self.errorMessage = Constant.shared.noInternet
        }
    }
   private func profileDataFormating(profileData:ProfileBaseData) ->[ProfileDetails]{
       var profileArray = [ProfileDetails]()
        
        let name = ProfileDetails(title:"Name", value: profileData.data?.name ?? "")
        let email = ProfileDetails(title:"Email", value: profileData.data?.email ?? "")
        let gender = ProfileDetails(title:"Gender", value: profileData.data?.gender ?? "")
        let status = ProfileDetails(title:"Status", value: profileData.data?.status ?? "")
        let createdAt = ProfileDetails(title:"Created at", value: profileData.data?.created_at ?? "")
        let updatedAt = ProfileDetails(title:"Updated at", value: profileData.data?.updated_at ?? "")
        
        profileArray.append(name)
        profileArray.append(email)
        profileArray.append(gender)
        profileArray.append(status)
        profileArray.append(createdAt)
        profileArray.append(updatedAt)
        
        return profileArray
    }
}
struct ProfileDetails {
    let title:String
    let value:String
    
    init(title:String,value:String) {
        self.title = title
        self.value = value
    }
}
