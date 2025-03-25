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
    
    func showDetailNews(referenceVC: UIViewController, news: News) {
        let detailVC =  appDependencies.configNewsDetailsVC(news: news)
        referenceVC.navigationController?.pushViewController(detailVC, animated: true)
    }
}
