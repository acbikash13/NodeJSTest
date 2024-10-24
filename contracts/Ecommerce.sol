pragma solidity ^0.8.17;

contract EcommerceV3Transfer {
    int public revenue; // Total revenue the owner is making for selling the product
    string public ownerName; // Name of the person who created the e-commerce site
    address owner;  // Wallet address of the person who created the e-commerce site

    struct Product {
        uint productNo;
        string prodName;
        int noItem;
        int unitCost;
        uint totalPurchase;
    }

    struct ReturnRequest {
        address customerWalletAddress;
        uint productId;
        int noItems;
    }

    // List of all return requests
    ReturnRequest[] public returnRequests;

    mapping(address => int) individualSpend;  // Tracks how much ether/wei each customer has spent
    mapping(uint => int) individualProduct;  // Tracks how many units of each product have been sold

    Product[] public productList;  // Array of all products
    uint public totalProducts; // Total number of products available

    constructor() {
        ownerName = "Shahid";
        owner = msg.sender; // Contract creator becomes the owner
        revenue = 0;
    }

    // Only the owner can add a new product to the product list
    function addProduct(uint id, string memory name, int num, int cost) public returns (string memory message) {
        require(msg.sender == owner, "You are not authorized");
        Product memory newProduct = Product(id, name, num, cost, 0);
        productList.push(newProduct);
        totalProducts = totalProducts + 1;
        return "Product added successfully";
    }

    // Any customer can purchase an item
    function purchaseItem(uint id, int quant) public payable returns (string memory message) {
        int cost = productList[id].unitCost * quant;
        productList[id].noItem = productList[id].noItem - quant;
        individualProduct[id] = individualProduct[id] + quant;
        individualSpend[msg.sender] = individualSpend[msg.sender] + cost;

        // Send ether/wei to the owner
        (bool sent, ) = owner.call{value: uint(cost)}("");
        require(sent, "Failed to send Ether");

        revenue = revenue + cost;
        return "Purchase successful";
    }

    // Function to request a return of a product
    function requestReturn(uint productId, int noOfItems) public {
        require(noOfItems > 0, "Invalid number of items");
        require(productList[productId].totalPurchase >= uint(noOfItems), "Return request exceeds purchase quantity");

        // Add the return request to the list
        returnRequests.push(ReturnRequest({
            customerWalletAddress: msg.sender,
            productId: productId,
            noItems: noOfItems
        }));
    }

    // Function for the owner to accept a return and refund the customer
    function acceptReturn(uint refundIndex) public payable {
        require(msg.sender == owner, "You are not authorized");

        // Get the return request details
        ReturnRequest memory request = returnRequests[refundIndex];
        Product memory product = productList[request.productId];

        // Calculate the refund based on the current price of the product
        int refundAmount = product.unitCost * request.noItems;

        // Refund the customer
        (bool sent, ) = request.customerWalletAddress.call{value: uint(refundAmount)}("");
        require(sent, "Refund failed");

        // Update product and revenue data
        productList[request.productId].noItem = productList[request.productId].noItem + request.noItems;
        revenue = revenue - refundAmount;
    }

    // Owner can change the price of a product
    function changePrice(uint id, int price) public returns (string memory) {
        require(msg.sender == owner, "You are not authorized");
        productList[id].unitCost = productList[id].unitCost + price;
        return "Price updated successfully";
    }

    // Owner can increase the quantity of an existing product
    function addItem(uint id, int quant) public returns (string memory) {
        require(msg.sender == owner, "You are not authorized");
        productList[id].noItem = productList[id].noItem + quant;
        return "Quantity added successfully";
    }

    // Get how much a customer has spent
    function getAccountHistory(address addr) public view returns (int) {
        return individualSpend[addr];
    }

    // Get how many units of a product have been sold
    function getProductHistory(uint id) public view returns (int) {
        return individualProduct[id];
    }
}