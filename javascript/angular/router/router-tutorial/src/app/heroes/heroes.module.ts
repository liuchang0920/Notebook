import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { HeroListComponent } from './hero-list/hero-list.component';
import { HeroDetailComponent } from './hero-detail/hero-detail.component';

import { HeroService } from './hero.service';

import { HeroRoutingModule } from './heroes-routing/heroes-routing.module';

@NgModule({
  imports: [
    CommonModule,
    HeroRoutingModule,
    FormsModule
  ],
  declarations: [HeroListComponent, HeroDetailComponent],
  providers: [
    HeroService,
  ]
})
export class HeroesModule { }
