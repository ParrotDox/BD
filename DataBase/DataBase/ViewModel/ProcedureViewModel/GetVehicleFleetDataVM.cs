using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataBase.ViewModel.ProcedureViewModel
{
    public class GetVehicleFleetDataVM : ProcedureBaseVM
    {
        public override SqlCommand FormQuery()
        {
            SqlCommand command = new("EXEC sp_GetVehicleFleetData");
            return command;
        }
    }
}
