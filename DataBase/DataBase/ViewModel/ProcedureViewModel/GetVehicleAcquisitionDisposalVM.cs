using Microsoft.Data.SqlClient;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace DataBase.ViewModel.ProcedureViewModel
{
    public class GetVehicleAcquisitionDisposalVM : ProcedureBaseVM
    {
        public string? Year { get; set; }
        public string? Month { get; set; }
        public string? Day { get; set; }

        public override SqlCommand? FormQuery()
        {
            int year = 0;
            int month = 0;
            int day = 0;
            bool isYearCorrect = int.TryParse(Year, out year);
            bool isMonthCorrect = int.TryParse(Month, out month);
            bool isDayCorrect = int.TryParse(Day, out day);
            SqlCommand command = new("EXEC sp_GetVehicleAcquisitionDisposal @Year,@Month,@Day");

            if (isYearCorrect && year < 2100 && year > 2000) 
            {
                SqlParameter yearParameter = new("@Year", SqlDbType.Int);
                yearParameter.Value = year;
                command.Parameters.Add(yearParameter);
            }
            else 
            {
                MessageBox.Show("Year parameter is incorrect or not inputted", "Warning", MessageBoxButton.OK,MessageBoxImage.Warning);
                return null;
            }
            if(isMonthCorrect && month > 0 && month < 13) 
            {
                SqlParameter monthParameter = new("@Month", SqlDbType.Int);
                monthParameter.Value = month;
                command.Parameters.Add(monthParameter);
            }
            else 
            {
                SqlParameter monthParameter = new("@Month", SqlDbType.Int);
                monthParameter.Value = DBNull.Value;
                command.Parameters.Add(monthParameter);
            }
            if (isDayCorrect && day > 0 && month < 32)
            {
                SqlParameter dayParameter = new("@Day", SqlDbType.Int);
                dayParameter.Value = month;
                command.Parameters.Add(dayParameter);
            }
            else
            {
                SqlParameter dayParameter = new("@Day", SqlDbType.Int);
                dayParameter.Value = DBNull.Value;
                command.Parameters.Add(dayParameter);
            }
            return command;
        }
    }
}
