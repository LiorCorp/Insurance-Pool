import { Injectable } from "@angular/core";
import { HttpClient } from "@angular/common/http";
import { Observable } from "rxjs";

@Injectable({
  providedIn: "root"
})
export class AppService {
  constructor(private http: HttpClient) {}

  public getExchangesJSON(): Observable<any> {
    return this.http.get("assets/json/exchange.json");
  }
  public getPoolsJSON(): Observable<any> {
    return this.http.get("assets/json/pool-ui.json");
  }
}
