//
//  RandomUserListViewModel.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import Foundation

final class RandomUserListViewModel: TableViewModel {
    
    typealias Model = [RandomUser]
    internal var model: Model
    
    private var currentPage = 1
    
    private let businessService: BusinessService
    
    init(businessService: BusinessService) {
        self.businessService = businessService
        self.model = []
    }
    
    func isLastElement(for row: Int) -> Bool {
        return row == model.count-1
    }
}

extension RandomUserListViewModel {
    
    func fetchBunchOfRandomUser(completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        businessService.fetchBunchOfRandomUser(currentPage: currentPage) { [weak self] (result: Result<[RandomUser]>) in
            switch result {
            case .success(let randomUsers):
                self?.model += randomUsers
                completion(true, nil)
                
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    func fetchMoreRandomUsers(completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        currentPage += 1
        fetchBunchOfRandomUser(completion: completion)
    }
}
