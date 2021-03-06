pragma solidity ^0.5.0;

import {GameManager} from "./GameManager.sol";

contract ThreeInARow {
    
    GameManager gameManager;
    
    uint256 public gameCost = 0.1 ether;
    
    address payable public player1;
    address payable public player2;
    
    address payable activePlayer;
    
    event PlayerJoined(address _player);
    event NextPlayer(address _player);
    
    address[3][3] gameBoard;
    
    constructor(address _addrGameManager, address payable _player1) public payable {
        gameManager = GameManager(_addrGameManager);
        require(msg.value == gameCost, "Submit more money! Aborting!");
        player1 = _player1;
        //more functionality here - later!
    }
    
    function joinGame() public payable {
        //here player2 joins the game
        assert(player2 == address(0x0));
        require(msg.value == gameCost, "Submit more money! Aborting!");
        
        player2 = msg.sender;
        emit PlayerJoined(player2);
        
        if(block.number % 2 == 0) {
            activePlayer = player2;
        } else {
            activePlayer = player1;
        }
        
        emit NextPlayer(activePlayer);
    }
    
    function getBoard() public view returns(address[3][3] memory) {
        return gameBoard;
    }
    
    function setStone(uint8 x, uint8 y) public {
        uint8 boardSize = uint8(gameBoard.length);
        require(gameBoard[x][y] == address(0));
        assert(x < boardSize);
        assert(y < boardSize);
        require(msg.sender == activePlayer);
        gameBoard[x][y] = msg.sender;
        
        if(activePlayer == player1) {
            activePlayer = player2;
        } else {
            activePlayer = player1;
        }
        
        emit NextPlayer(activePlayer);
        //we set the stone here
    }
    
    function setWinner(address payable _player) private {
        
    }
    
    function setDraw() private {
        
    }
    
    function withdrawWin() public {
        
    }
    
    function emergencyCashout() public {
        
    }
}