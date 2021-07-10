import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { ProductCategoryComponent } from './features/product-category/product-category.component';
import { ProductsGridComponent } from './features/products-grid/products-grid.component';
import { ShopperService } from './shared/services/shopper.service';

@NgModule({
  declarations: [
    AppComponent,
    ProductCategoryComponent,
    ProductsGridComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule
  ],
  providers: [ShopperService],
  bootstrap: [AppComponent]
})
export class AppModule { }
