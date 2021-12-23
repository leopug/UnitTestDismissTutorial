//
//  ViewController.swift
//  UnitTestDismissTutorial
//
//  Created by Leonardo on 22/12/2021.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let logManager: LoggingManager
    private var detailsViewController: DetailsViewController
    
//    init(logManager: LoggingManager = LogManager(), detailsViewControllerFactory: @autoclosure () -> DetailsViewControllerFactory = { DefaultDetailsViewControllerFactory() }()) {
    init(logManager: LoggingManager = LogManager(), detailsViewControllerFactory: DetailsViewControllerFactory = DefaultDetailsViewControllerFactory()) {
        self.logManager = logManager
        self.detailsViewController = detailsViewControllerFactory.create()
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(openModal), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(closeModal), userInfo: nil, repeats: false)
    }
    
    @objc private func openModal() {
        present(detailsViewController, animated: true)
    }
    
    @objc private func closeModal() {
        detailsViewController.dismiss(animated: true, completion: { [weak self] in
            self?.logManager.log(text: "leo DetailsViewController was dismissed!!!")
        })
    }
}
