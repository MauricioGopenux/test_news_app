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
    
    func configDetailsNewsVC(referenceVC: UIViewController, news: News, updateNewsPresenterProtocol: UpdateNewsPresenterProtocol) {
        let detailVC =  appDependencies.configNewsDetailsVC(news: news, updateNewsPresenterProtocol: updateNewsPresenterProtocol)
        showDetailsNews(referenceVC: referenceVC, detailVC: detailVC)
    }
    
    private func showDetailsNews(referenceVC: UIViewController, detailVC: UIViewController) {
        referenceVC.navigationController?.pushViewController(detailVC, animated: true)
    }
}
