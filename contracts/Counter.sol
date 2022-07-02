pragma solidity ^0.7.0;
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// Shall use other tokens
contract LabellessStableToken is ERC20 {
    constructor() ERC20("Labelless USD Stable Token", "USD") public {
        _mint(msg.sender, 10000000000000000000000000000);
    }
}

contract LabellessToken is ERC20 {
    constructor() ERC20("Labelless Utility Token", "LLT") public {
        _mint(msg.sender, 10000000000000000000000000000);
    }
}

contract LabellessGovToken is ERC20 {
    constructor() ERC20("Labelless Gov Token", "xLLT") public {
        _mint(msg.sender, 10000000000000000000000000000);
    }
}

contract LabellessSoulBoundToken is ERC721 {
    constructor() ERC721("Labelless Soul Bound Token", "LST") public {
        _mint(msg.sender, 10000000000000000000000000000);
    }
}

struct Task {
    string Name;
    string DetailUri;
    string ResultUri;
}

contract LabellessTask is ERC721 {
    using Counters for Counters.Counter;

    constructor() ERC721("Labelless Task", "LLTSK") public {  
    }

    Counters.Counter private _taskIds;

    mapping(uint256 => Task) _taskMapping;

    function createTask(address owner, string memory taskDetailUri, string memory name) public returns (uint256) {
        _taskIds.increment();

        uint256 newTaskId = _taskIds.current();
        _mint(owner, newTaskId);
        _taskMapping[newTaskId].Name = name;
        _taskMapping[newTaskId].DetailUri = taskDetailUri;
        return newTaskId;
    }

    function takeTask(address owner, uint256 taskId) public {
        // function _transfer(address from, address to, uint256 tokenId)
        require(balanceOf(msg.sender) == 0, "Sender has alrady taken one task.");
        _safeTransfer(owner, msg.sender, taskId, "");
    }

    function submitTask(address owner, uint256 taskId, string memory resultUri) public {
        // function _transfer(address from, address to, uint256 tokenId)
        require(ownerOf(taskId) == msg.sender);
        _taskMapping[taskId].ResultUri = resultUri;
        _safeTransfer(msg.sender, owner, taskId, "");
    }

    function reviewTask(address owner, uint256 taskId) public {
        // function _transfer(address from, address to, uint256 tokenId)
        require(balanceOf(msg.sender) == 0, "Sender has alrady taken one task.");
        _safeTransfer(owner, msg.sender, taskId, "");
    }

    function verifyTask(address owner, uint256 taskId) public {
        // function _transfer(address from, address to, uint256 tokenId)
        require(ownerOf(taskId) == msg.sender);
        _safeTransfer(msg.sender, owner, taskId, "");
    }

    function rejectTask(address owner, uint256 taskId) public {
        // function _transfer(address from, address to, uint256 tokenId)
        require(ownerOf(taskId) == msg.sender);
        _safeTransfer(msg.sender, owner, taskId, "");
    }
}

contract Labelless {
    IERC20 _usd;
    LabellessToken _llt;
    LabellessGovToken _xllt;
    LabellessSoulBoundToken _lst;

    LabellessTask _tasks;

    function initilaize(IERC20 USD, LabellessToken LLT, LabellessGovToken xLLT, LabellessSoulBoundToken LST, LabellessTask tasks) public {
        _usd = USD;
        _llt = LLT;
        _xllt = xLLT;
        _lst = LST;
        _tasks = tasks;
    }

    // Customer
    // Require virtually "payable" by ERC20 USDC
    function createTask(string memory taskDetailUri, string memory name, uint256 amount) public {
        require(_usd.transferFrom(msg.sender, address(this), amount));
        _tasks.createTask(address(this), taskDetailUri, name);
    }

    // Labeller
    function takeTask(uint256 taskId) public {
        _tasks.takeTask(address(this), taskId);
    }

    function submitTask(uint256 taskId, string memory taskResultUrl) public {
        _tasks.submitTask(address(this), taskId, taskResultUrl);
    }

    function reviewTask(uint256 taskId) public {
        _tasks.reviewTask(address(this), taskId);
    }

    function verifyTask(uint256 taskId) public {
        _tasks.verifyTask(address(this), taskId);
    }

    function rejectTask(uint256 taskId) public {
        _tasks.verifyTask(address(this), taskId);
    }

    uint256 count = 0;
    event CountedTo(uint256 number);
    function getCount() public view returns (uint256) {
        return count;
    }
    function countUp() public returns (uint256) {
        console.log("countUp: count =", count);
        uint256 newCount = count + 1;
        require(newCount > count, "Uint256 overflow");
        count = newCount;
        emit CountedTo(count);
        return count;
    }
    function countDown() public returns (uint256) {
        console.log("countDown: count =", count);
        uint256 newCount = count - 1;
        require(newCount < count, "Uint256 underflow");
        count = newCount;
        emit CountedTo(count);
        return count;
    }
}