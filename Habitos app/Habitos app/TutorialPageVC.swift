//
//  TutorialPageVC.swift
//  Single Project To-Do
//
//  Created by Lucas Fernandez Nicolau on 15/05/19.
//  Copyright © 2019 {lfn}. All rights reserved.
//

import UIKit

class TutorialPageVC: UIPageViewController {
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var pageControl = UIPageControl()
    var appHasBeenOpenedBefore = false
    var defaults: UserDefaults?
    var mainVC: MainPage?
    //tela que vai ser a primeira
    
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "tutorial_pg_1"),
            self.getViewController(withIdentifier: "tutorial_pg_2"),
            self.getViewController(withIdentifier: "tutorial_pg_3"),
            self.getViewController(withIdentifier: "tutorial_pg_4"),
            self.getViewController(withIdentifier: "tutorial_pg_5")
        ]
    }()
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        if let tutorialLastPageVC = vc as? UltimaPgTutorial {
            // classe da ultima pagina do tutorial
            tutorialLastPageVC.mainVC = mainVC
            return tutorialLastPageVC
        }
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        configurePageControl()
        
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        defaults = UserDefaults()
        guard let defaults = defaults else { return }
        appHasBeenOpenedBefore = defaults.bool(forKey: "theAppHasBeenOpenedBefore")
        
        if appHasBeenOpenedBefore {
            view.alpha = 0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !appHasBeenOpenedBefore {
            defaults?.set(true, forKey: "theAppHasBeenOpenedBefore")
        } else {
            self.dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "goToTheApp", sender: self)
        }
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 80, width: UIScreen.main.bounds.width, height: 50))
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        self.pageControl.isUserInteractionEnabled = false
        self.view.addSubview(pageControl)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.modalPresentationStyle = .custom
        segue.destination.modalTransitionStyle = .crossDissolve
    }
}
//controla o flow das paginas
extension TutorialPageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        guard pages.count > previousIndex else { return nil }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else { return nil }
        
        guard pages.count > nextIndex else { return nil }
        
        return pages[nextIndex]
    }
}

extension TutorialPageVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.firstIndex(of: pageContentViewController)!
    }
}

