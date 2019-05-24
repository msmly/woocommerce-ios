import UIKit
import Gridicons


// MARK: - ProductReviewsTableViewCell
//
final class ProductReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var reviewTotalsLabel: UILabel!
    @IBOutlet weak var starRatingView: RatingView!

    var starRating: Int? {
        didSet {
            guard let starRating = starRating else {
                starRatingView.isHidden = true
                return
            }

            starRatingView.rating = CGFloat(starRating)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        configureLabels()
        configureStarView()
    }

    func configureLabels() {
        reviewLabel.applyBodyStyle()
        reviewTotalsLabel.applyBodyStyle()
    }

    func configureStarView() {
        starRatingView.starImage = Star.filledImage
        starRatingView.emptyStarImage = Star.emptyImage
    }
}


// MARK: - Constants
//
private extension ProductReviewsTableViewCell {
    enum Star {
        static let size = CGSize(width: 20, height: 20)
        static let filledImage = Gridicon.iconOfType(.star,
                                                     withSize: Star.size
            ).imageWithTintColor(StyleManager.grayStarColor)
        static let emptyImage = Gridicon.iconOfType(.starOutline,
                                                    withSize: Star.size
            ).imageWithTintColor(StyleManager.grayStarColor)
    }
}