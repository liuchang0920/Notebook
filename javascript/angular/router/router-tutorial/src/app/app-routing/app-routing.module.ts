import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

// add routes
import { RouterModule, Routes } from '@angular/router';

import { CrisisCenterComponent } from '../crisis-center/crisis-center.component';
// import { HeoresComponent } from '../heores/heores.component';
import { PageNotFoundComponent } from '../page-not-found/page-not-found.component';

// routes
const appRoutes: Routes = [
  {
    path: 'crisis-center', component: CrisisCenterComponent
  }
  // used in hero module instead
  // {
  //   path: 'heroes', component: HeoresComponent
  // }
  , {
    path: '', redirectTo: '/heroes', pathMatch: 'full'
  } , {
    path: '**', component: PageNotFoundComponent
  }
];


@NgModule({
  imports: [
    CommonModule,
    RouterModule.forRoot(appRoutes,
      {enableTracing: true})
  ],
  exports: [
    RouterModule
  ],
  declarations: []
})
export class AppRoutingModule { }
