//
//  ViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 05.04.2025.
//

import UIKit
import SnapKit

struct OnboardingStep {
    let title: String
}

class OnboardingViewController: UIViewController {
    
    lazy var mainView: UIView = {
        mainView = UIView()
        mainView.backgroundColor = .appGrey
        mainView.layer.cornerRadius = 12
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    lazy var mainLabel = MainLabels(title: "All your favorites", subtitle: "Get all your loved foods in one once place,you just place the orer we do the rest")
    lazy var pageControl: UIPageControl = {
        pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .appOrange
        pageControl.pageIndicatorTintColor = .appLightOrange
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    lazy var nextButton = MainButton(textButton: "NEXT", target: self, action: #selector(nextTapped))
    lazy var skipButton: UIButton = {
        skipButton = UIButton()
        skipButton.setTitle("Skip", for: .normal)
        skipButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        skipButton.setTitleColor(.black, for: .normal)
        skipButton.backgroundColor = .white
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        return skipButton
    }()
    
    private let steps: [OnboardingStep] = [
        OnboardingStep(title: "All your favorites"),
        OnboardingStep(title: "All your favorites"),
        OnboardingStep(title: "Order from choosen chef"),
        OnboardingStep(title: "Free delivery offers")
    ]
    private var currentStepIndex = 0
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setView()
        updateUIForCurrentStep()
    }
    
    private func setView(){
        setMainView()
        setMainLabel()
        setPageControl()
        setNextButton()
        setSkipButton()
    }
    
    private func setMainView() {
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints { make in
            make.height.equalTo(screenHeight*292/812)
            make.width.equalTo(screenWidth*240/375)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(screenHeight*114/812)
        }
    }
    
    private func setMainLabel(){
        mainLabel.titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        mainLabel.titleLabel.textColor = .black
        mainLabel.subTitleLabel.textColor = .black
        mainLabel.subTitleLabel.numberOfLines = 0
        mainLabel.subTitleLabel.lineBreakMode = .byWordWrapping
        view.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainView.snp.bottom).offset(screenHeight*63/812)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func setPageControl(){
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(screenHeight*32/812)
        }
        
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
    }
    
    private func setNextButton(){
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(screenHeight*69/812)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func setSkipButton(){
        view.addSubview(skipButton)
        
        skipButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nextButton.snp.bottom).offset(screenHeight*16/812)
//            make.bottom.greaterThanOrEqualTo(view.snp.bottom).offset(24)
        }
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
    }
        
    private func updateUIForCurrentStep() {
        let step = steps[currentStepIndex]
        mainLabel.titleLabel.text = step.title
        pageControl.currentPage = currentStepIndex
        skipButton.isHidden = currentStepIndex == steps.count - 1
        if currentStepIndex == steps.count - 1 {
            nextButton.setTitle("GET STARTED", for: .normal)
        } else {
            nextButton.setTitle("NEXT", for: .normal)
        }
    }
    
    @objc private func pageControlChanged(_ sender: UIPageControl) {
        currentStepIndex = sender.currentPage
        updateUIForCurrentStep()
    }
    
    @objc private func nextTapped() {
        if currentStepIndex < steps.count - 1 {
            currentStepIndex += 1
            updateUIForCurrentStep()
        } else {
            goToLogInScreen()
        }
    }
    
    @objc private func skipTapped() {
        goToLogInScreen()
    }
    
    private func goToLogInScreen() {
        let logInVC = LogInViewController()
        logInVC.modalPresentationStyle = .fullScreen
        present(logInVC, animated: true, completion: nil)
    }
}
