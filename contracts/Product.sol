pragma solidity ^0.4.17;

contract ProductFactory {
    address[] deployedProducts;

    function createProduct(string name, string description, uint totalNumStages) public {
        address newProduct = new Product(msg.sender, name, description, totalNumStages);
        deployedProducts.push(newProduct);
    }

    function getDeployedProducts() public view returns(address[]) {
        return deployedProducts;
    }
}

// A product in the supply chain
contract Product {
    address issuer;
    string name;
    string description;
    uint currNumStages;
    uint totalNumStages;
    Stage currentStage;
    Stage[] stages; // all the stages the product has gone through

    // A stage in the product's supply chain cycle
    struct Stage {
        address issuer;
        uint256 startDate;
        uint256 endDate;
        string description;
    }
    
    function Product(address _issuer, string _name, string _description, uint _totalNumStages) public {
        issuer = _issuer;
        name = _name;
        description = _description;
        totalNumStages = _totalNumStages;
    }

    // Add a stage to the product's chain
    function startStage(uint256 startDate, string _description) public {
        require(currentStage.startDate == 0);

        // Stage memory stage = Stage({
        //     issuer: msg.sender,
        //     description: _description,
        //     entryDate: 123,
        //     exitDate: 0
        // });
        // stages.push(stage);

        currentStage = Stage({
            issuer: msg.sender,
            description: _description,
            startDate: startDate,
            endDate: 0
        });
    }

    // Finish the current stage
    function finishStage(uint256 date) public {
        require(msg.sender == currentStage.issuer);

        Stage memory finishedStage = Stage({
            issuer: currentStage.issuer,
            description: currentStage.description,
            startDate: currentStage.startDate,
            endDate: date
        });

        stages.push(finishedStage);
        currNumStages += 1;

        // reset the current stage
        currentStage = Stage({
            issuer: 0x0,
            description: "",
            startDate: 0,
            endDate: 0
        });
    }
}
