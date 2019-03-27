﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace QuanLyQuanCafe.DTO
{
    public class Menu
    {
        private string foodName;
        private int count;
        private float price;
        private float totalPrice;

        public Menu(string foodName, int count, float price, float totalPrice)
        {
            this.FoodName = foodName;
            this.Count = count;
            this.Price = price;
            this.TotalPrice = totalPrice;
        }

        public Menu(DataRow row)
        {
            this.FoodName = row["Name"].ToString();
            this.Count = (int)row["count"];
            this.Price = (float)Convert.ToDouble(row["price"].ToString());
            this.TotalPrice = (float)Convert.ToDouble(row["totalPrice"].ToString());
        }
        public float TotalPrice
        {
            get { return totalPrice; }
            set { totalPrice = value; }
        }

        public float Price
        {
            get { return price; }
            set { price = value; }
        }
        public int Count
        {
            get { return count; }
            set { count = value; }
        }

        public string FoodName
        {
            get { return foodName; }
            set { foodName = value; }
        }
    }
}
