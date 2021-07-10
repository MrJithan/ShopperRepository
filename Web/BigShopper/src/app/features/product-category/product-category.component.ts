import { Component, OnInit } from '@angular/core';
import { CategoryModel } from 'src/app/shared/models/category.model';
import { DefaultCategory, ShopperService } from 'src/app/shared/services/shopper.service';

@Component({
  selector: 'app-product-category',
  templateUrl: './product-category.component.html',
  styleUrls: ['./product-category.component.css']
})
export class ProductCategoryComponent implements OnInit {

  constructor( private shopperService: ShopperService) { }

  categoryId = 0;
  parentId = 0;
  totalCount = 0;
  categoryList: CategoryModel[] = [];
  parentCategoryList: CategoryModel[] = [];
  selectedCategory: CategoryModel = DefaultCategory;

  ngOnInit(): void {
    this.shopperService.totalCount.subscribe(count => {
      this.totalCount = count;  
    });
    this.populateCategories();
  }

  populateCategories(){
    this.shopperService.getCategories(this.categoryId).subscribe(
      result => {
        this.categoryList = result;
        this.parentId = result[0].parentId;
      },
      (error) => {
        console.log(error);
      },
      () => {        
      }
    );
  }

  categorySelected(categoryId: number){
    this.categoryId = categoryId;
    this.populateCategories();
    this.getSelectedCategory();
  }

  getSelectedCategory(){
    this.shopperService.getSelectedCategory(this.categoryId).subscribe(
      result => {
        this.selectedCategory = result;
        this.shopperService.selectedCategory.next(result);
      },
      (error) => {
        console.log(error);
      },
      () => {
      }
    );
  }

}
