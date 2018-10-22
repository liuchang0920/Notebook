import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

// routing module
import { AppRoutingModule } from './app-routing/app-routing.module';
import { HeroesModule } from './heroes/heroes.module';

import { AppComponent } from './app.component';
import { CrisisCenterComponent } from './crisis-center/crisis-center.component';
import { PageNotFoundComponent } from './page-not-found/page-not-found.component';


@NgModule({
  declarations: [
    AppComponent,
    CrisisCenterComponent,
    PageNotFoundComponent,
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HeroesModule, // 要在后面这个router前导入,因为后面的那个有通配符
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
