//
//  DetailsNewsRouter.swift
//  NewsAppIOS
//
//  Created by Radmas on 25/03/25.
//

import UIKit

class NewsDetailsRouter {
    private weak var appDependencies: AppDependencies!
    
    func setAppDependencies(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
    }
    
    func configDetailsNewsVC(referenceVC: UIViewController, news: News) {
        let detailVC =  appDependencies.configNewsDetailsVC(news: news)
        configureNavigationBar(referenceVC: referenceVC)
        showDetailsNews(referenceVC: referenceVC, detailVC: detailVC)
    }
    
    private func showDetailsNews(referenceVC: UIViewController, detailVC: UIViewController) {
        referenceVC.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func configureNavigationBar(referenceVC: UIViewController) {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        backButton.tintColor = .black
        referenceVC.navigationItem.backBarButtonItem = backButton
    }
}
