using BigShopper.Models;
using System.Collections.Generic;

namespace BigShopper.Services
{
    public interface IShopperService
    {
        IEnumerable<ProductDetail> GetProductList(int categoryId);

        IEnumerable<SubCategory> GetSubCategoryList(int categoryId);

        ProductCategory GetSelectedCategory(int categoryId);
    }
}
