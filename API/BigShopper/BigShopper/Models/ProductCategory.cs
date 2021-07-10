using System;
using System.Collections.Generic;

#nullable disable

namespace BigShopper.Models
{
    public partial class ProductCategory
    {
        public int CategoryId { get; set; }
        public int? ParentId { get; set; }
        public string CategoryDescription { get; set; }
    }
}
