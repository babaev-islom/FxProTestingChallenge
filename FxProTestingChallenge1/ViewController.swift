import UIKit

protocol LoaderService {
    func load(completion: @escaping (Result<String, Error>) -> Void)
}

class FakeLoaderService: LoaderService {
    func load(completion: @escaping (Result<String, Error>) -> Void) {
        completion(.success("test string"))
    }
}

class ViewModel {
    var onDataLoad: ((String) -> Void)?
    var onLoadingStateChange: ((_ isLoading: Bool) -> Void)?
    var onErrorStateChange: ((String?) -> Void)?
    
    func viewDidLoad() {
        onLoadingStateChange?(true)
        onErrorStateChange?(nil)
        FakeLoaderService().load { [self] result in
            onLoadingStateChange?(false)
            switch result {
            case let .success(data):
                onDataLoad?(data)
            case .failure:
                onErrorStateChange?("received error")
            }
        }
    }
}

class ViewController: UIViewController {
    private var viewModel: ViewModel?
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 30, weight: .semibold)
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        self.viewModel = ViewModel()
        
        viewModel?.onDataLoad = { [weak self] data in
            self?.label.text = data
        }
        
        viewModel?.onLoadingStateChange = { [weak self] isLoading in
            self?.label.text = isLoading ? "Loading..." : "Loaded"
        }
        
        viewModel?.onErrorStateChange = { [weak self] message in
            self?.label.text = message
        }
        
        viewModel?.viewDidLoad()
    }
}

