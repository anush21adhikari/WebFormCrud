using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace WebFormDemoProject
{
    public class PasswordHelper
    {
        public static string HashPassword(string password)
        {
            string hashedPassword = null;
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                hashedPassword = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
            }

            return hashedPassword;
        }
    }
}