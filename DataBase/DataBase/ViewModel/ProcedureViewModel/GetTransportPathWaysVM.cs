using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataBase.ViewModel.ProcedureViewModel
{
    public class GetTransportPathWaysVM : ProcedureBaseVM
    {
        public override SqlCommand FormQuery()
        {
            SqlCommand command = new("EXEC sp_GetPassengerTransportPathWays");
            return command;
        }
    }
}
