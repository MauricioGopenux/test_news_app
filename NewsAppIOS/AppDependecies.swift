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
    private let newDetailsInteractor: NewsDetailsInteractor = NewsDetailsInteractor()
    private let newsDetailsPresenter: NewsDetailsPresenter = NewsDetailsPresenter()
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
        listNewRouter.setDetailMovieRouter(newsDetailsRouter: newsDetailsRouter)
        listNewRouter.setMoviesViewController(listNewsVC: listNewsViewController)
        listNewsPresenter.setListNewsInteractor(listNewsInteractor: listNewsInteractor)
        listNewsPresenter.setListNewsRouter(listNewsRouting: listNewRouter)
        listNewsPresenter.setListNewsViewProtocol(newsViewProtocol: listNewsViewController)
        listNewsViewController.setListNewsPresenter(listNewsPresenter: listNewsPresenter)
    }
    
    func configNewsDetailsVC(news: News) -> UIViewController{
        newsDetailsViewController = NewsDetailsViewController()
        newDetailsInteractor.setNewsRepository(newsRepository: newsDataRepository)
        newDetailsInteractor.setListNewsInteractor(listNewsInteractor: listNewsInteractor)
        newsDetailsPresenter.setNews(news: news)
        newsDetailsPresenter.setDetailViewProtocol(detailViewProtocol: newsDetailsViewController)
        newsDetailsPresenter.setListNewsInteractor(newsDetailsInteractor: newDetailsInteractor)
        newsDetailsViewController.setNewsDetailsPresenter(newsDetailPresenter: newsDetailsPresenter)
        
        return newsDetailsViewController
    }
}
