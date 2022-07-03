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

    function mint(address owner, uint256 amount) public {
        _mint(owner, amount);
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

    function getTaskState(uint256 taskId) public view returns(TaskState) {
        return _taskMapping[taskId].State;
    }

    function createTask(address owner, string memory taskDetailUri, string memory name, uint256 usdAmount) public returns (uint256) {
        _taskIds.increment();

        uint256 newTaskId = _taskIds.current();
        _mint(owner, newTaskId);
        _taskMapping[newTaskId].Name = name;
        _taskMapping[newTaskId].DetailUri = taskDetailUri;
        _taskMapping[newTaskId].State = TaskState.TODO;
        emit TaskToTodo(msg.sender, newTaskId, name);
        return newTaskId;
    }

    function takeTask(address owner, uint256 taskId) OnlyTaskInState2(taskId, TaskState.TODO, TaskState.REJECTED) public {
        // function _transfer(address from, address to, uint256 tokenId)
        require(balanceOf(msg.sender) == 0, "Sender has alrady taken one task.");
        require(_taskMapping[taskId].State == TaskState.TODO || _taskMapping[taskId].State == TaskState.REJECTED, "Task must be in TODO or REJECTED state to be taken.");
        _safeTransfer(owner, msg.sender, taskId, "");
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
    struct LabellessTaskDetails {
        address Customer;
        address Labeller;
        address Verifier;
        address Innovator;        
        uint256 UsdAmount;
        uint256 LltAmount;
        uint256 labellerUsdValue;
        uint256 labellerLltValue;
        uint256 verifierUsdValue;
        uint256 verifierLltValue;
        uint256 innovatorUsdValue;
        uint256 innovatorLltValue;
    }

    IERC20 _usd;
    LabellessToken _llt;
    LabellessGovToken _xllt;
    LabellessSoulBoundToken _lst;

    LabellessTask _tasks;
    mapping(uint256 => LabellessTaskDetails) _taskDetails;

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
        uint256 taskId = _tasks.createTask(address(this), taskDetailUri, name, amount);
        _taskDetails[taskId] = LabellessTaskDetails(msg.sender, address(0), address(0), address(0), 0, 0, 0, 0, 0, 0, 0, 0);
    }

    // Labeller
    function takeTask(uint256 taskId) public {
        // TODO: implement following
        // To avoid one create many users and take the tasks,
        // we can require users to deposit a certain amount of LLT,
        // we will return the LLT after it’s submitted 3days later.
        _tasks.takeTask(address(this), taskId);
        _taskDetails[taskId].Labeller = msg.sender;
    }

    function submitTask(uint256 taskId, string memory taskResultUrl) public {
        _tasks.submitTask(address(this), taskId, taskResultUrl);
    }

    function reviewTask(uint256 taskId) public {
        _tasks.reviewTask(address(this), taskId);
        _taskDetails[taskId].Verifier = msg.sender;
   }

    function verifyTask(uint256 taskId) public {
        _tasks.verifyTask(address(this), taskId);
    }

    function rejectTask(uint256 taskId) public {
        _tasks.verifyTask(address(this), taskId);
    }

    function distributeAwards(uint256 taskId) public {
        require(_tasks.getTaskState(taskId) == LabellessTask.TaskState.VERIFIED);

        ///////////////////////////////
        // System Settings
        ///////////////////////////////
        uint256 aFeePerc = 5; // 5%

        ////////////////////////////////
        // Parameter Calculations
        ///////////////////////////////
        _taskDetails[taskId].labellerUsdValue = _taskDetails[taskId].UsdAmount * (100 - aFeePerc)/ 100 / 3; // $(1-a%) * y / 3, Get x1 LLT
        _taskDetails[taskId].labellerLltValue = _taskDetails[taskId].labellerUsdValue; // TBD: x1 LLT == USD Value

        _taskDetails[taskId].verifierUsdValue = _taskDetails[taskId].UsdAmount * (100 - aFeePerc)/ 100 / 3; // $(1-a%) * y / 3, Get x2 LLT
        _taskDetails[taskId].verifierLltValue = _taskDetails[taskId].verifierUsdValue; // TBD: x2 LLT == USD Value

        _taskDetails[taskId].innovatorUsdValue = _taskDetails[taskId].UsdAmount * (100 - aFeePerc)/ 100 / 3; // $(1-a%) * y / 3, Get x3 LLT
        _taskDetails[taskId].innovatorLltValue = _taskDetails[taskId].innovatorUsdValue; // TBD: x3 LLT == USD Value

        // Operational Expense
        uint256 aFee = _taskDetails[taskId].UsdAmount * aFeePerc / 100;
        uint256 bFee = aFee * 20 / 100; // 20% "Distribute $ to active labeler, proportional to LLTs"
        uint256 cFee = aFee * 30 / 100; // 30% "Treasury"
        uint256 dFee = aFee * 50 / 100; // 50% "Buy on open market"
        require((bFee + cFee + dFee) == aFee); // aFee constraint

        // total constraint
        require((_taskDetails[taskId].labellerUsdValue + _taskDetails[taskId].verifierUsdValue + _taskDetails[taskId].innovatorUsdValue + aFee) == _taskDetails[taskId].UsdAmount);

        ////////////////////////////////////////
        //// Distribution Actions
        ////////////////////////////////////////
        LabellessTaskDetails memory taskDetails = _taskDetails[taskId];

        // To Labeller
        _usd.transferFrom(address(this), taskDetails.Labeller, taskDetails.labellerUsdValue);
        _llt.mint(taskDetails.Labeller,taskDetails.labellerLltValue); // LLT award shall be different than USD value?

        // To Verifier
        _usd.transferFrom(address(this), taskDetails.Labeller, taskDetails.verifierUsdValue);
        _llt.mint(taskDetails.Verifier, taskDetails.verifierLltValue);

        // To Innovator
        _usd.transferFrom(address(this), taskDetails.Labeller, taskDetails.innovatorUsdValue);
        _llt.mint(taskDetails.Verifier, taskDetails.innovatorLltValue);

        // Award the distributor action taker, it is Labelless DAO by default (?)
        _llt.mint(msg.sender, 10000000); // Award the diststributor : ETH/SOL => LLT / AMM
    }
}