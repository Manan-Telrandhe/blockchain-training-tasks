// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract contracta {
    function sendtob(address b) external payable {
        require(msg.value>0,"no eth send");
        (bool success, ) = payable(b).call{value: msg.value}("");
        require(success,"transaction failed");
    }

    //also we can do it by creating instance and directly calling from contracta also 
    

    function sendtod(address d) external payable {
        require(msg.value>0,"no eth send");
        (bool success, ) = address(d).call{value: msg.value}("");
        require(success,"transaction failed");
    }
    
}

contract contractb {
    event received(address sender,uint amount);

    receive() external payable { 
        emit received(msg.sender,msg.value);
    }

    function forwardtoc(address c) external payable {
        require(msg.value>0,"no eth send");
        payable(c).transfer(msg.value);
    }
    
}

contract contractc {
    event received(address sender,uint amount);
    receive() external payable { 
        emit received(msg.sender,msg.value);
    }
}

contract contractd {
    receive() external payable {
        revert("transaction rejected");
    }
}

