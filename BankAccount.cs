using System;
using System.Collections.Generic;
using System.Text;

namespace assignment_day2
{
    class BankAccount
    {
        public int UserId { get; set; }
        public string CustomerName { get; set; }
        public string MobileNumber { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        protected void CreateAccount()
        {
            Console.Write("Enter UserID = ");
            UserId = Convert.ToInt32(Console.ReadLine());
            Console.Write("Enter customer name = ");
            CustomerName = Console.ReadLine();
            Console.Write("Enter mobilphone number = ");
            MobileNumber = Console.ReadLine();
            Console.Write("Enter Email = ");
            Email = Console.ReadLine();
            Console.Write("Enter address = ");
            Address = Console.ReadLine();
        }
        protected void PrintAccount()
        {
            Console.WriteLine("User ID ="+UserId);
            Console.WriteLine("Customer name ="+CustomerName);
            Console.WriteLine("Mobilphone number ="+MobileNumber);
            Console.WriteLine("Email = "+Email);
            Console.WriteLine("Address ="+Address);
        }
    }
    class CheckingAccount:BankAccount
    {
        public string AccountNumber { get; set; }
        public decimal AvailableBalance { get; set; }
        public void AddCheckingAccount()
        {
            CreateAccount();
            Console.Write("Enter checking account number=");
            AccountNumber = Console.ReadLine();
            Console.Write("Enter Available balance =");
            AvailableBalance = Convert.ToDecimal(Console.ReadLine());
        }
        public void PrintCheckingAccount()
        {
            PrintAccount();
            Console.WriteLine("Checking account number ="+AccountNumber);
            Console.WriteLine("Available balance ="+AvailableBalance);
        }
    }
    class SavingAccount:BankAccount
    {
        public string AccountNumber { get; set; }
        public decimal AvailableBalance { get; set; }
        public void AddSavingAccount()
        {
            CreateAccount();
            Console.Write("Enter saving account number=");
            AccountNumber = Console.ReadLine();
            Console.Write("Enter Available balance =");
            AvailableBalance = Convert.ToDecimal(Console.ReadLine());
        }
        public void PrintSavingAccount()
        {
            PrintAccount();
            Console.WriteLine("Saving account number =" + AccountNumber);
            Console.WriteLine("Available balance =" + AvailableBalance);
        }
    }
}

