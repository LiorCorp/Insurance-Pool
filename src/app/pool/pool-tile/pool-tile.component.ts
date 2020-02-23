import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-pool-tile',
  templateUrl: './pool-tile.component.html',
  styleUrls: ['./pool-tile.component.scss']
})
export class PoolTileComponent implements OnInit {
  
  @Input() poolIcon;
  @Input() collateral;
  @Input() coverage;
  constructor() { }

  ngOnInit() {
  }

}
