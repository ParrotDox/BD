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
    public class GetVehicleMileageReportVM : ProcedureBaseVM
    {
        public string? Year { get; set; }
        public string? Month { get; set; }
        public string? Day { get; set; }
        public string? VehicleId { get; set; }
        public string? VehicleType { get; set; }

        public override SqlCommand? FormQuery()
        {
            int vehicleId = 0;
            int year = 0;
            int month = 0;
            int day = 0;
            bool isVehicleIdCorrect = int.TryParse(VehicleId, out vehicleId);
            bool isYearCorrect = int.TryParse(Year, out year);
            bool isMonthCorrect = int.TryParse(Month, out month);
            bool isDayCorrect = int.TryParse(Day, out day);
            SqlCommand command = new("EXEC sp_GetVehicleMileageReport @VehicleId,@VehicleType,@Year,@Month,@Day");

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
            if (!VehicleType.IsNullOrEmpty())
            {
                SqlParameter vehicleTypeParameter = new("@VehicleType", SqlDbType.VarChar);
                vehicleTypeParameter.Value = VehicleType;
                command.Parameters.Add(vehicleTypeParameter);
            }
            else
            {
                SqlParameter vehicleTypeParameter = new("@VehicleType", SqlDbType.VarChar);
                vehicleTypeParameter.Value = DBNull.Value;
                command.Parameters.Add(vehicleTypeParameter);
            }
            return command;
        }
    }
}
