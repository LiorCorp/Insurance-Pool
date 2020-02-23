import { WEB3 } from './../web3';
import {Injectable, Inject} from "@angular/core";
import Web3 from "web3";
declare let require: any;

let tokenAbi = require("build/contracts/Insurance.json");
const CONTRACT: string = "0xC40349a78282d4Fc05f0EAE990D9047b2Eb8d58e";

@Injectable({
  providedIn: "root"
})
export class PoolService {
  account: any;
  contract: any;

  constructor(@Inject(WEB3) private web3: Web3) {
    this.contract = new this.web3.eth.Contract(
      tokenAbi.abi,
      CONTRACT
    );
  }

  getAccountInfo(): Promise<any> {
    let that = this;
    return new Promise((resolve, reject) => {
      this.web3.eth.getCoinbase(function(err, account) {
        that.account = account;
        if (err === null) {
          that.web3.eth.getBalance(account, function(err, balance) {
            if (err === null) {
              return resolve({
                fromAccount: account,
                balance: that.web3.utils.fromWei(balance, "ether")
              });
            } else {
              return reject({fromAccount: "error", balance: balance});
            }
          });
        }
      });
    });
  }

  joinPool(
    _transferFrom,
    _amount: string,
    _exchange: number,
    poolType: number
  ): Promise<any> {
    let that = this;
    return this.contract.methods.transferFund(_exchange, poolType).send({
        from: _transferFrom,
        value: this.web3.utils.toWei(_amount, "ether")});
  }
}
