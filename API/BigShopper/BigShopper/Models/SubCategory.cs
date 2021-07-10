using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BigShopper.Models
{
    public partial class SubCategory
    {
        public int CategoryId { get; set; }
        public int ParentId { get; set; }
        public string CategoryDescription { get; set; }
        public int TotalCount { get; set; }
    }
}
