//
//  DetailsViewControllerFactory.swift
//  UnitTestDismissTutorial
//
//  Created by Leonardo on 22/12/2021.
//

import Foundation

protocol DetailsViewControllerFactory {
    func create() -> DetailsViewController
}

class DefaultDetailsViewControllerFactory: DetailsViewControllerFactory {
    func create() -> DetailsViewController { DetailsViewController() }
}
