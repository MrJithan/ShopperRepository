import { Component, OnInit } from '@angular/core';
import { ProductModel } from 'src/app/shared/models/product.model';
import { ShopperService } from 'src/app/shared/services/shopper.service';

@Component({
  selector: 'app-products-grid',
  templateUrl: './products-grid.component.html',
  styleUrls: ['./products-grid.component.css']
})
export class ProductsGridComponent implements OnInit {

  productsList: ProductModel[] = [];
  constructor( private shopperService: ShopperService) { 
  }

  ischecked = false;
  totalCount = 0;

  ngOnInit(): void {
    this.shopperService.selectedCategory.subscribe(category => {
      this.populateProducts(category.categoryId);
    });
  }

  populateProducts(categoryId: number){
    this.shopperService.getProducts(categoryId).subscribe(
      result => {
        this.productsList = result;
        this.shopperService.totalCount.next(result.length);
      },
      (error) => {
        console.log(error);
      },
      () => {
      }
    );
  }

}
