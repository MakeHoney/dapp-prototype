import Web3 from 'web3';
import { address, ABI } from './constants/managerContract';

let getContract = new Promise((resolve, reject) => {
    let web3 = new Web3(window.web3.currentProvider);
    let managerContractInstance = new web3.eth.Contract(address, ABI);
    resolve(managerContractInstance);
});

export default getContract;