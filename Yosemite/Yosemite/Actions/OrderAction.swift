import Foundation
import Networking



// MARK: - OrderAction: Defines all of the Actions supported by the OrderStore.
//
public enum OrderAction: Action {

    /// Searches orders that contain a given keyword.
    ///
    case searchOrders(siteID: Int64, keyword: String, pageNumber: Int, pageSize: Int, onCompletion: (Error?) -> Void)

    /// Synchronizes the Orders matching the specified criteria.
    ///
    case synchronizeOrders(siteID: Int64, statusKey: String?, pageNumber: Int, pageSize: Int, onCompletion: (Error?) -> Void)

    /// Nukes all of the cached orders.
    ///
    case resetStoredOrders(onCompletion: () -> Void)

    /// Retrieves the specified OrderID.
    ///
    case retrieveOrder(siteID: Int64, orderID: Int64, onCompletion: (Order?, Error?) -> Void)

    /// Updates a given Order's Status.
    ///
    case updateOrder(siteID: Int64, orderID: Int64, statusKey: String, onCompletion: (Error?) -> Void)

    /// Gets the number of orders in processing status.
    ///
    case countProcessingOrders(siteID: Int64, onCompletion: (OrderCount?, Error?) -> Void)
}
