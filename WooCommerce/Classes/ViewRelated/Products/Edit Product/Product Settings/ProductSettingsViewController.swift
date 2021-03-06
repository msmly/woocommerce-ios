import UIKit
import Yosemite

// MARK: - ProductSettingsViewController
//
final class ProductSettingsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel: ProductSettingsViewModel

    init(product: Product) {
        viewModel = ProductSettingsViewModel(product: product)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureMainView()
        configureTableView()
    }

}

// MARK: - View Configuration
//
private extension ProductSettingsViewController {

    func configureNavigationBar() {
        title = NSLocalizedString("Product Settings", comment: "Product Settings navigation title")

        removeNavigationBackBarButtonText()
    }

    func configureMainView() {
        view.backgroundColor = .listBackground
    }

    func configureTableView() {
        viewModel.registerTableViewCells(tableView)
        viewModel.registerTableViewHeaderFooters(tableView)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.backgroundColor = .listBackground
        tableView.removeLastCellSeparator()
    }
}

// MARK: - UITableViewDataSource Conformance
//
extension ProductSettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        let row = section.rows[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)

        row.configure(cell: cell)

        return cell
    }
}

// MARK: - UITableViewDelegate Conformance
//
extension ProductSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = viewModel.sections[section]

        let headerID = TwoColumnSectionHeaderView.reuseIdentifier
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as? TwoColumnSectionHeaderView else {
            assertionFailure("Unregistered \(TwoColumnSectionHeaderView.self) in UITableView")
            return nil
        }

        headerView.leftText = section.title
        headerView.rightText = nil

        return headerView
    }
}
