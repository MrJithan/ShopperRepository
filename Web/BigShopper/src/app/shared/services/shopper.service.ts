import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import { BehaviorSubject, Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { CategoryModel } from '../models/category.model';
import { ProductModel } from '../models/product.model';

export const DefaultCategory: CategoryModel = {
    categoryId: 0,
    parentId: 0,
    categoryDescription: 'Categories',
    totalCount: 0
};

@Injectable({
  providedIn: 'root'
})
export class ShopperService {

  baseUrl = environment.baseApiUrl;
  selectedCategory = new BehaviorSubject<CategoryModel>(DefaultCategory);
  totalCount = new BehaviorSubject<number>(0);

  constructor(private _httpClient: HttpClient) { }

  getCategories(categoryId: number): Observable<CategoryModel[]> {
    return this._httpClient.get<CategoryModel[]>( this.baseUrl + 'shopper/subCategories?categoryId=' + categoryId);
  }

  getProducts(categoryId: number): Observable<ProductModel[]> {
    return this._httpClient.get<ProductModel[]>( this.baseUrl + 'shopper/products?categoryId=' + categoryId);
  }

  getSelectedCategory(categoryId: number): Observable<CategoryModel> {
    return this._httpClient.get<CategoryModel>( this.baseUrl + 'shopper/category?categoryId=' + categoryId);
  }
}
