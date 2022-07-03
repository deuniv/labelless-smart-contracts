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
        // _mint(msg.sender, 10000000000000000000000000000);
    }

    function mint(uint256 amount) public {
        _mint(msg.sender, amount);
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


contract LabellessTask is ERC721 {
    using Counters for Counters.Counter;

    // () = createTask => TODO
    // TODO => takeTask => IN_PROGRESS
    // IN_PROGRESS => submitTask => REVIEW
    // REVIEW => reviewTask => IN_REVIEW
    // IN_REVIEW => verifyTask => VERIFIED
    // IN_REVIEW => rejectTask => REJECTED

    enum TaskState { TODO, IN_PROGRESS, REVIEW, IN_REVIEW, VERIFIED, REJECTED }

    struct Task {
        string Name;
        string DetailUri;
        string ResultUri;
        TaskState State;
        address Labeller;
        uint256 UsdAmount;
    }

    constructor() ERC721("Labelless Task", "LLTSK") public {  
    }

    Counters.Counter private _taskIds;

    mapping(uint256 => Task) _taskMapping;

    event TaskToTodo(address creator, uint256 taskId, string name);
    event TaskToInProgress(address creator, uint256 taskId);
    event TaskToReview(address creator, uint256 taskId);
    event TaskToInReview(address creator, uint256 taskId);
    event TaskToVerified(address creator, uint256 taskId);
    event TaskToRejected(address creator, uint256 taskId);

    modifier OnlyTaskInState(uint256 taskId, TaskState state) {
        require(_taskMapping[taskId].State == state);
        _;
    }

    modifier OnlyTaskInState2(uint256 taskId, TaskState state1, TaskState state2) {
        require(_taskMapping[taskId].State == state1 || _taskMapping[taskId].State == state2);
        _;
    }

    function getTaskUsdAmount(uint256 taskId) public view returns(uint256) {
        return _taskMapping[taskId].UsdAmount;
    }

    function getTaskLabeller(uint256 taskId) public view returns(address) {
        return _taskMapping[taskId].Labeller;
    }

    function createTask(address owner, string memory taskDetailUri, string memory name, uint256 usdAmount) public returns (uint256) {
        _taskIds.increment();

        uint256 newTaskId = _taskIds.current();
        _mint(owner, newTaskId);
        _taskMapping[newTaskId].Name = name;
        _taskMapping[newTaskId].DetailUri = taskDetailUri;
        _taskMapping[newTaskId].State = TaskState.TODO;
        _taskMapping[newTaskId].UsdAmount = usdAmount;
        emit TaskToTodo(msg.sender, newTaskId, name);
        return newTaskId;
    }

    function takeTask(address owner, uint256 taskId) OnlyTaskInState2(taskId, TaskState.TODO, TaskState.REJECTED) public {
        // function _transfer(address from, address to, uint256 tokenId)
        require(balanceOf(msg.sender) == 0, "Sender has alrady taken one task.");
        require(_taskMapping[taskId].State == TaskState.TODO || _taskMapping[taskId].State == TaskState.REJECTED, "Task must be in TODO or REJECTED state to be taken.");
        _safeTransfer(owner, msg.sender, taskId, "");
        _taskMapping[taskId].Labeller = msg.sender;
        _taskMapping[taskId].State = TaskState.IN_PROGRESS;
        emit TaskToInProgress(msg.sender, taskId);
    }

    function submitTask(address owner, uint256 taskId, string memory resultUri) OnlyTaskInState(taskId, TaskState.IN_PROGRESS) public {
        // function _transfer(address from, address to, uint256 tokenId)
        require(ownerOf(taskId) == msg.sender);
        _taskMapping[taskId].ResultUri = resultUri;
        _safeTransfer(msg.sender, owner, taskId, "");
        _taskMapping[taskId].State = TaskState.REVIEW;
        emit TaskToReview(msg.sender, taskId);
    }

    function reviewTask(address owner, uint256 taskId) OnlyTaskInState(taskId, TaskState.REVIEW) public {
        // function _transfer(address from, address to, uint256 tokenId)
        require(balanceOf(msg.sender) == 0, "Sender has alrady taken one task.");
        _safeTransfer(owner, msg.sender, taskId, "");
         _taskMapping[taskId].State = TaskState.IN_REVIEW;
        emit TaskToInReview(msg.sender, taskId);
   }

    function verifyTask(address owner, uint256 taskId) OnlyTaskInState(taskId, TaskState.IN_REVIEW) public {
        // function _transfer(address from, address to, uint256 tokenId)
        require(ownerOf(taskId) == msg.sender);
        _safeTransfer(msg.sender, owner, taskId, "");
        _taskMapping[taskId].State = TaskState.VERIFIED;
        emit TaskToVerified(msg.sender, taskId);
    }

    function rejectTask(address owner, uint256 taskId) OnlyTaskInState(taskId, TaskState.IN_REVIEW) public {
        // function _transfer(address from, address to, uint256 tokenId)
        require(ownerOf(taskId) == msg.sender);
        _safeTransfer(msg.sender, owner, taskId, "");
         _taskMapping[taskId].State = TaskState.REJECTED;
        emit TaskToRejected(msg.sender, taskId);
    }
}

contract Labelless {
    IERC20 _usd;
    LabellessToken _llt;
    LabellessGovToken _xllt;
    LabellessSoulBoundToken _lst;

    LabellessTask _tasks;

    uint256 _aFeePercentage;

    function initilaize(IERC20 USD, LabellessToken LLT, LabellessGovToken xLLT, LabellessSoulBoundToken LST, LabellessTask tasks) public {
        _usd = USD;
        _llt = LLT;
        _xllt = xLLT;
        _lst = LST;
        _tasks = tasks;

        _aFeePercentage = 5; // 5%
    }

    // Customer
    // Require virtually "payable" by ERC20 USDC
    function createTask(string memory taskDetailUri, string memory name, uint256 amount) public {
        require(_usd.transferFrom(msg.sender, address(this), amount));
        _tasks.createTask(address(this), taskDetailUri, name, amount);
    }

    // Labeller
    function takeTask(uint256 taskId) public {
        // TODO: implement following
        // To avoid one create many users and take the tasks,
        // we can require users to deposit a certain amount of LLT,
        // we will return the LLT after it’s submitted 3days later.
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
        uint256 taskUsdAmount = _tasks.getTaskUsdAmount(taskId);
        address taskLabeller = _tasks.getTaskLabeller(taskId);
        uint256 awardValue = taskUsdAmount * (100 - _aFeePercentage)/ 100 / 3;
        _usd.transferFrom(address(this), taskLabeller, awardValue);
        _llt.mint(awardValue);
    }

    function rejectTask(uint256 taskId) public {
        _tasks.verifyTask(address(this), taskId);
    }
}