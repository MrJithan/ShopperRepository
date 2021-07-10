using BigShopper.Models;
using BigShopper.Services;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace BigShopper.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ShopperController : ControllerBase
    {
        private readonly IShopperService _service;

        public ShopperController(IShopperService service)
        {
            _service = service;
        }

        [Route("products")]
        [HttpGet]
        public IEnumerable<ProductDetail> GetProductList(int categoryId)
        {
            return _service.GetProductList(categoryId);
        }

        [Route("subCategories")]
        [HttpGet]
        public IEnumerable<SubCategory> GetSubCategoryList(int categoryId)
        {
            return _service.GetSubCategoryList(categoryId);
        }

        [Route("category")]
        [HttpGet]
        public ProductCategory GetSelectedCategory(int categoryId)
        {
            return _service.GetSelectedCategory(categoryId);
        }
    }
}
