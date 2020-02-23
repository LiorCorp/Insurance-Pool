import {Component, OnInit, Input} from "@angular/core";
import {Observable} from "rxjs";
import {PoolService} from "src/app/eth-services/pool.service";

@Component({
  selector: "app-pool-tile-content",
  templateUrl: "./pool-tile-content.component.html",
  styleUrls: ["./pool-tile-content.component.scss"]
})
export class PoolTileContentComponent implements OnInit {
  pools: Observable<any>;
  @Input() poolIcon;
  @Input() collateral;
  @Input() coverage;
  transferFrom: string;
  exchangeId: number;

  constructor(private readonly poolservice: PoolService) {}

  ngOnInit(): void {
    this.initAndDisplayAccount();
  }

  initAndDisplayAccount() {
    let that = this;
    this.poolservice
      .getAccountInfo()
      .then(function(acctInfo: any) {
        that.transferFrom = acctInfo.fromAccount;
      })
      .catch(function(error) {
        console.log(error);
      });
  }

  joinPool(amount: number, poolType: number) {
    this.poolservice
      .joinPool(this.transferFrom, amount.toString(), this.exchangeId, poolType)
      .then(function(res) {
        console.log("transfer success");
      })
      .catch(function(error) {
        console.log(error);
      });
  }

  onChange(value: number){
   this.exchangeId = value
  }
}
