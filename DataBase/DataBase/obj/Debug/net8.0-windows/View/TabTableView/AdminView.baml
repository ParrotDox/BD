   M S B A M L   `   `   `  ����C  ?DataBase, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null-clr-namespace:DataBase.ViewDataBase.View  5      [2clr-namespace:DataBase.ViewModel.TabTableViewModel$DataBase.ViewModel.TabTableViewModel  5      *    $DataBase.View.TabTableView.AdminView   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      -localclr-namespace:DataBase.View     5      PtabTableViewModel2clr-namespace:DataBase.ViewModel.TabTableViewModel     5        � DataContext  5      2   ,DataBase.ViewModel.TabTableViewModel.AdminVM  5   
   .��5      �� $��10q�6   .+�5   
   �� $��	SQL query��6   $��18(�6$   �� 5   
   -   5        $��SqlCommandTextBox��5      $��18(�6+   $	��300��69   $	��Top=�6F   $��0,10,0,0q�6^   $��Stretch=�6p    �� AcceptsReturn$
 True��5   
   ��5   
   �� *
SqlCommand+ �� UpdateSourceTrigger$ PropertyChanged=��� 5   
   $��Выполнить��6   $��18(�6%   $	��140��63   $��50��6?   $	��Top=�6K   $��Center=�6c   $��	0,20,0,10q�6�   ��5   	   �� *ExecuteCommand+�� 5   
   $��Result��6   $��18(�6!   �� 5   
   -   5        $��ResultTextBox��5      $��30��6'   $	��Top=�63   $��0,20,0,0q�6K   $��Stretch=�6]    �� 
IsReadOnly$
 True��5   &   " �� VerticalScrollBarVisibility$
 Auto=�68   ��6
   �� *
ResultText+68   �� 5   
   $��Result (table)��6   $��18(�6)   &   System.Windows.Controls.DataGrid  5    
   -   5        $��ResultDataGrid��5       $	��Top=�6)   $��0,20,0,0q�6A   $��Stretch=�6S      AutoGenerateColumns$
 True��5!   .   ��6   �� *
QueryTable+6.   5#      5$      