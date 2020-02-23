import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PoolTileContentComponent } from './pool-tile-content.component';

describe('PoolTileContentComponent', () => {
  let component: PoolTileContentComponent;
  let fixture: ComponentFixture<PoolTileContentComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PoolTileContentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PoolTileContentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
