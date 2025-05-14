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
    public class GetVehiclePartsUsageVM : ProcedureBaseVM
    {
        public string? Year { get; set; }
        public string? Month { get; set; }
        public string? Day { get; set; }
        public string? PartId { get; set; }
        public string? VehicleType { get; set; }
        public string? VehicleMake { get; set; }

        public override SqlCommand? FormQuery()
        {
            int partId = 0;
            int year = 0;
            int month = 0;
            int day = 0;
            bool isPartIdCorrect = int.TryParse(PartId, out partId);
            bool isYearCorrect = int.TryParse(Year, out year);
            bool isMonthCorrect = int.TryParse(Month, out month);
            bool isDayCorrect = int.TryParse(Day, out day);
            SqlCommand command = new("EXEC sp_GetVehiclePartsUsage @VehicleType,@VehicleMake,@PartId,@Year,@Month,@Day");

            if (isPartIdCorrect)
            {
                SqlParameter idParameter = new("@PartId", SqlDbType.Int);
                idParameter.Value = partId;
                command.Parameters.Add(idParameter);
            }
            else
            {
                SqlParameter idParameter = new("@PartId", SqlDbType.Int);
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
            if (!VehicleMake.IsNullOrEmpty())
            {
                SqlParameter vehicleMakeParameter = new("@VehicleMake", SqlDbType.VarChar);
                vehicleMakeParameter.Value = VehicleMake;
                command.Parameters.Add(vehicleMakeParameter);
            }
            else
            {
                SqlParameter vehicleMakeParameter = new("@VehicleMake", SqlDbType.VarChar);
                vehicleMakeParameter.Value = DBNull.Value;
                command.Parameters.Add(vehicleMakeParameter);
            }
            return command;
        }
    }
}
