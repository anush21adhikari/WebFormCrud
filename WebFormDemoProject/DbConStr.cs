using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebFormDemoProject
{
    public static class DbConStr
    {
        public static string ConnectionString
        {
            get
            {
                return System.Configuration.ConfigurationManager.ConnectionStrings["ConnString"].ConnectionString;
            }
        }
    }
}