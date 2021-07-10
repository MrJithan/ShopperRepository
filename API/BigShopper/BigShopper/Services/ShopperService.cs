using BigShopper.Models;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;

namespace BigShopper.Services
{
    public class ShopperService: IShopperService
    {
        private readonly ShopperContext _context;
        public ShopperService(ShopperContext context)
        {
            _context = context;
        }
        public IEnumerable<ProductDetail> GetProductList(int categoryId)
        {
            var productList = _context.ProductDetails.FromSqlRaw($"Exec usp_GetProductDetails_sel @categoryId = { categoryId}").AsEnumerable();
            return productList.Select(pd => new ProductDetail { 
                                                            ProductId = pd.ProductId,
                                                            CategoryId = pd.CategoryId, 
                                                            ProductDescription = pd.ProductDescription, 
                                                            Price = pd.Price
                                                         }).ToList();
        }
        public IEnumerable<SubCategory> GetSubCategoryList(int categoryId)
        {
            var categoryList = _context.SubCategories.FromSqlRaw($"Exec usp_GetSubCategoryDetails_sel @categoryId = { categoryId}").AsEnumerable();
            return categoryList.Select(sc => new SubCategory
            {
                CategoryId = sc.CategoryId,
                ParentId = sc.ParentId,
                CategoryDescription = sc.CategoryDescription,
                TotalCount = sc.TotalCount
            }).ToList();
        }

        public ProductCategory GetSelectedCategory(int categoryId)
        {
            return _context.ProductCategories.FirstOrDefault(c => c.CategoryId == categoryId);
        }
    }
}
