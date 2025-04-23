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
    
    //MARK: UI-Components
    lazy var mainView: UIView = {
        mainView = UIView()
        mainView.backgroundColor = .appGrey
        mainView.layer.cornerRadius = 12
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    lazy var mainLabel = MainLabels(title: "All your favorites", titleSize: 24, textColor: .black, subtitle: "Get all your loved foods in one once place, you just place the order we do the rest", spacing: 16)
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
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupConstraints()
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        updateUIForCurrentStep()
    }
    
    //MARK: Constraints
    private func setupConstraints() {
        view.addSubview(mainView)
        view.addSubview(mainLabel)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        
        mainView.snp.makeConstraints { make in
            make.height.equalTo(screenHeight*292/812)
            make.width.equalTo(screenWidth*240/375)
            make.centerX.equalToSuperview()
            make.top.lessThanOrEqualToSuperview().offset(screenHeight*114/812)
        }
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainView.snp.bottom).offset(screenHeight*63/812)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(screenHeight*32/812)
        }
        nextButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(pageControl.snp.bottom).offset(screenHeight*69/812)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        skipButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nextButton.snp.bottom).offset(screenHeight*16/812)
            make.bottom.equalToSuperview().inset(screenHeight*24/812)
        }
    }
 
    //MARK: Logics
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
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        let logInVC = LogInViewController()
        navigationController?.setViewControllers([logInVC], animated: true)
    }
}
