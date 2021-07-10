using System;
using System.Collections.Generic;

#nullable disable

namespace BigShopper.Models
{
    public partial class ProductDetail
    {
        public int? ProductId { get; set; }
        public int? CategoryId { get; set; }
        public string ProductDescription { get; set; }
        public decimal? Price { get; set; }
    }
}
