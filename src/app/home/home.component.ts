import { Component, OnInit } from '@angular/core';
import {AppService} from "src/app/services/app.service";
import {Observable} from "rxjs";
import { map } from 'rxjs/operators';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  pools: Observable<any>;
  constructor(private readonly appService: AppService) { }

  ngOnInit() {
    this.pools = this.appService.getPoolsJSON().pipe(
      map((pool) => pool.pool));
  }

}
