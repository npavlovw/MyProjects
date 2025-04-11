//
//  ViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 05.04.2025.
//

import UIKit

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
    lazy var mainLabel: UILabel = {
        mainLabel = UILabel()
        mainLabel.font = .systemFont(ofSize: 29, weight: .bold)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        return mainLabel
    }()
    lazy var subLabel: UILabel = {
        subLabel = UILabel()
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.text = "Get all your loved foods in one once place, you just place the order we do the rest"
        subLabel.numberOfLines = 0
        subLabel.textAlignment = .center
        return subLabel
    }()
    lazy var pageControl: UIPageControl = {
        pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .appOrange
        pageControl.pageIndicatorTintColor = .appLightOrange
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    lazy var nextButton = mainButton(textButton: "NEXT", target: self, action: #selector(nextTapped))
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setView()
        updateUIForCurrentStep()
    }
    
    private func setView(){
        setMainView()
        setMainLabel()
        setSubLabel()
        setPageControl()
        setNextButton()
        setSkipButton()
    }
    
    private func setMainView() {
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 114),
            mainView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 24),
            mainView.widthAnchor.constraint(equalToConstant: 240),
            mainView.heightAnchor.constraint(equalToConstant: 292),
        ])
    }
    
    private func setMainLabel(){
        view.addSubview(mainLabel)
        
        mainLabel.topAnchor.constraint(lessThanOrEqualTo: mainView.bottomAnchor, constant: 63).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setSubLabel(){
        view.addSubview(subLabel)
        
        NSLayoutConstraint.activate([
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 18),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            subLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
    }
    
    private func setPageControl(){
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 32)
        ])
        
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
    }
    
    private func setNextButton(){
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(70)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func setSkipButton(){
        view.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            skipButton.widthAnchor.constraint(equalToConstant: 32),
            skipButton.heightAnchor.constraint(equalToConstant: 19)
        ])
        
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
    }
    
    private func updateUIForCurrentStep() {
        let step = steps[currentStepIndex]
        mainLabel.text = step.title
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
