using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace QuanLyQuanCafe.DTO
{
    public class Bill
    {
        private int iD;
        private DateTime? dateCheckIn;
        private DateTime? dateCheckOut;
        private int status;
        public Bill(int id, DateTime? dateCheckIn, DateTime? dateCheckOut, int status)
        {
            this.ID = id;
            this.DateCheckIn = dateCheckIn;
            this.DateCheckOut = dateCheckOut;
            this.Status = status;
        }

        public Bill(DataRow row)
        {
            this.ID = (int)row["id"];
            this.DateCheckIn=(DateTime?)row["dateChecIn"];

            var dateCheckOutTemp =row["dateCheckOut"];
            if(dateCheckOutTemp.ToString() != "")
                this.dateCheckOut=(DateTime?)dateCheckOutTemp;
            this.Status=(int)row["status"];
        }
        public int Status
        {
            get { return status; }
            set { status = value; }
        }


        public DateTime? DateCheckOut
        {
            get { return dateCheckOut; }
            set { dateCheckOut = value; }
        }

        public DateTime? DateCheckIn
        {
            get { return dateCheckIn; }
            set { dateCheckIn = value; }
        }

        public int ID
        {
            get { return iD; }
            set { iD = value; }
        }
    }
}