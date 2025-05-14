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
    public class GetSpecialistWorkReportVM : ProcedureBaseVM
    {
        public string? Year { get; set; }
        public string? Month { get; set; }
        public string? Day { get; set; }
        public string? EmployeeId { get; set; }
        public string? VehicleId { get; set; }

        public override SqlCommand? FormQuery()
        {
            int vehicleId = 0;
            int employeeId = 0;
            int year = 0;
            int month = 0;
            int day = 0;
            bool isVehicleIdCorrect = int.TryParse(VehicleId, out vehicleId);
            bool isEmployeeIdCorrect = int.TryParse(EmployeeId, out employeeId);
            bool isYearCorrect = int.TryParse(Year, out year);
            bool isMonthCorrect = int.TryParse(Month, out month);
            bool isDayCorrect = int.TryParse(Day, out day);
            SqlCommand command = new("EXEC sp_GetSpecialistWorkReport @EmployeeId,@VehicleId,@Year,@Month,@Day");

            if (isEmployeeIdCorrect)
            {
                SqlParameter idParameter = new("@EmployeeId", SqlDbType.Int);
                idParameter.Value = employeeId;
                command.Parameters.Add(idParameter);
            }
            else
            {
                SqlParameter idParameter = new("@EmployeeId", SqlDbType.Int);
                idParameter.Value = DBNull.Value;
                command.Parameters.Add(idParameter);
            }
            if (isVehicleIdCorrect)
            {
                SqlParameter idParameter = new("@VehicleId", SqlDbType.Int);
                idParameter.Value = vehicleId;
                command.Parameters.Add(idParameter);
            }
            else
            {
                SqlParameter idParameter = new("@VehicleId", SqlDbType.Int);
                idParameter.Value = DBNull.Value;
                command.Parameters.Add(idParameter);
            }
            if (isYearCorrect && year < 2100 && year > 2000)
            {
                SqlParameter yearParameter = new("@Year", SqlDbType.Int);
                yearParameter.Value = year;
                command.Parameters.Add(yearParameter);
            }
            else
            {
                MessageBox.Show("Year parameter is incorrect or not inputted", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
                return null;
            }
            if (isMonthCorrect && month > 0 && month < 13)
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
                dayParameter.Value = day;
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
