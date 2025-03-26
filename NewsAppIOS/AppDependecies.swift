//
//  AppDependecies.swift
//  NewsAppIOS
//
//  Created by Radmas on 25/03/25.
//

import Foundation
import UIKit

class AppDependencies {
    
    private let coreDataManager = CoreDataManager.shared
    private let newsApiDataSource: NewsApiDataSource = NewsApiDataSource()
    private let newsDiskDataSource: NewsDiskDataSource = NewsDiskDataSource()
    private var newsDataRepository: NewsDataRepository!
    private let listNewsInteractor: ListNewsInteractor = ListNewsInteractor()
    private let listNewsPresenter: ListNewsPresenter = ListNewsPresenter()
    private let listNewRouter: ListNewsRouter = ListNewsRouter()
    
    private let newsDetailsRouter: NewsDetailsRouter = NewsDetailsRouter()
    private let newsDetailsPresenter: NewsDetailsPresenter = NewsDetailsPresenter()
    private let newsDetailsInteractor: NewsDetailsInteractor = NewsDetailsInteractor()
    private var newsDetailsViewController: NewsDetailsViewController!
    
    func injectDependencies(window: UIWindow) {
        if let navigationController = window.rootViewController as? UINavigationController{
            if let listNewsViewController = navigationController.visibleViewController as?  ListNewsViewController {
                newsDataRepository = NewsDataRepository(newsDiskDataSource: newsDiskDataSource, newsApiDataSource: newsApiDataSource)
                newsDiskDataSource.setNSManagedObjectContext(context: coreDataManager.context)
                injectAppDependenciesToDetailRouter()
                injectNewsDependencies(listNewsViewController: listNewsViewController)
            }
        }
    }
    
    private func injectAppDependenciesToDetailRouter() {
        newsDetailsRouter.setAppDependencies(appDependencies: self)
    }
    
    private func injectNewsDependencies(listNewsViewController: ListNewsViewController) {
        listNewsInteractor.setNewsRepository(newsRepository: newsDataRepository)
        listNewsInteractor.setNewsPresenter(newsPresenter: listNewsPresenter)
        listNewRouter.setDetailsNewsRouter(newsDetailsRouter: newsDetailsRouter)
        listNewRouter.setListNewsViewController(listNewsVC: listNewsViewController)
        listNewsPresenter.setListNewsInteractor(listNewsInteractor: listNewsInteractor)
        listNewsPresenter.setListNewsRouter(listNewsRouting: listNewRouter)
        listNewsPresenter.setListNewsViewProtocol(newsViewProtocol: listNewsViewController)
        listNewsViewController.setListNewsPresenter(listNewsPresenter: listNewsPresenter)
    }
    
    func configNewsDetailsVC(news: News) -> UIViewController{
        injectDependenciesNewsDetailsVC()
        newsDetailsViewController = NewsDetailsViewController()
        newsDetailsPresenter.setNews(news: news)
        newsDetailsPresenter.setDetailViewProtocol(detailViewProtocol: newsDetailsViewController)
        newsDetailsViewController.setNewsDetailsPresenter(newsDetailPresenter: newsDetailsPresenter)
        
        return newsDetailsViewController
    }
    
    private func injectDependenciesNewsDetailsVC() {
        newsDetailsPresenter.setNewsDetailsInteractor(newsDetailsInteractor: newsDetailsInteractor)
        newsDetailsPresenter.setListNewsPresenter(newsPresenterProtocol: listNewsPresenter)
        newsDetailsInteractor.setNewsRepository(newsRepository: newsDataRepository)
        newsDetailsInteractor.setNewsPresenter(newsDetailsPresenter: newsDetailsPresenter)
    }
}
