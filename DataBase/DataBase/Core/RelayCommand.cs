using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace DataBase.Core
{
    public class RelayCommand : ICommand
    {
        public Action<object?> Exec { get; set; }
        public Predicate<object?> CanExec { get; set; }

        public event EventHandler? CanExecuteChanged;
        public RelayCommand(Action<object?> act, Predicate<object?> condition)
        {
            Exec = act;
            CanExec = condition;
        }
        public bool CanExecute(object? parameter)
        {
            return CanExec == null || CanExec(parameter);
        }

        public void Execute(object? parameter)
        {
            if(Exec != null) 
            {
                Exec(parameter);
            }
        }
    }
}
