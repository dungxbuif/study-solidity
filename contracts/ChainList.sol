pragma solidity ^0.5.16;

import "./Ownable";

contract ChainList is Ownable {
    // custom types
    struct Article {
        uint256 id;
        address payable seller;
        address payable buyer;
        string name;
        string description;
        uint256 price;
    }

    // state variables

    mapping(uint256 => Article) public articles;
    uint256 articleCounter;

    event LogSellArticle(
        uint256 indexed _id,
        address indexed _seller,
        string _name,
        uint256 _price
    );

    event LogBuyArticle(
        uint256 indexed _id,
        address indexed _seller,
        address indexed _buyer,
        string _name,
        uint256 _price
    );

    // deactivate the contract
    function kill() public onlyOwner {
        selfdestruct(owner);
    }

    function sellArticle(
        string memory _name,
        string memory _description,
        uint256 _price
    ) public {
        articleCounter++;
        articles[articleCounter] = Article(
            articleCounter,
            msg.sender,
            address(0x0),
            _name,
            _description,
            _price
        );
        emit LogSellArticle(articleCounter, msg.sender, _name, _price);
    }

    // fetch the number of articles in the contract
    function getNumberOfArticles() public view returns (uint256) {
        return articleCounter;
    }

    // fetch and return all article IDs for articles still for sale
    function getArticlesForSale() public view returns (uint256[] memory) {
        // prepare output array
        uint256[] memory articleIds = new uint256[](articleCounter);

        uint256 numberOfArticlesForSale = 0;
        // iterate over articles
        for (uint256 i = 1; i <= articleCounter; i++) {
            // keep the ID if the article is still for sale
            if (articles[i].buyer == address(0x0)) {
                articleIds[numberOfArticlesForSale] = articles[i].id;
                numberOfArticlesForSale++;
            }
        }

        // copy the articleIds array into a smaller forSale array
        uint256[] memory forSale = new uint256[](numberOfArticlesForSale);
        for (uint256 j = 0; j < numberOfArticlesForSale; j++) {
            forSale[j] = articleIds[j];
        }
        return forSale;
    }

    function buyArticle(uint256 _id) public payable {
        require(articleCounter > 0);
        require(_id > 0 && _id <= articleCounter);
        Article storage article = articles[_id];
        require(article.buyer == address(0x0));
        require(msg.sender != article.seller);
        require(msg.value == article.price);
        article.buyer = msg.sender;
        article.seller.transfer(msg.value);
        emit LogBuyArticle(
            _id,
            article.seller,
            article.buyer,
            article.name,
            article.price
        );
    }
}
