   M S B A M L   `   `   `  ����C  ?DataBase, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullE'clr-namespace:DataBase.View.ManagerViewDataBase.View.ManagerView  5      ,    &DataBase.View.ManagerView.TechServices   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      9local'clr-namespace:DataBase.View.ManagerView     5      .��5	      � $��5q�6     � RowDefinitions  5
   
   �� 5      $
��Auto �6   �� 5      $��* �6    � ColumnDefinitions 5   
   �� 5      $��* �6   �� 5      $��* �6   �� 5      $��* �6   .+�5   
   �� $��0��6   $��5q�6%   .+�5      �� $��INSERT��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   �� 5      $��EmployeeId (Necessarily)��6   �� 5      ��6   �� *
EmployeeId+�� 5      $��VehicleId (Necessarily)��6   �� 5      ��6   �� *	VehicleId+�� 5      $��Mileage (>0)��6   �� 5      ��6   �� *	Mileage+�� 5!      $��CarriedAt (yyyy-MM-dd)��6   �� 5"      ��6   �� *	CarriedAt+�� 5$      $��Execute insert��6   $��INSERT��5&      $	��150��5'      $��Center=�5(      $��0 10 0 0q�5)      ��5%      �� *ExecuteQueryCommand+5)      5*      �� 5-   
   $��1��6   $��5q�6%   .+�5.      �� $��UPDATE��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   �� 50      $��Id (Necessarily)��6   �� 51      ��6   �� *Id+�� 53      $��
EmployeeId��6   �� 54      ��6   �� *
EmployeeId+�� 56      $��	VehicleId��6   �� 57      ��6   �� *	VehicleId+�� 59      $��Mileage��6   �� 5:      ��6   �� *	Mileage+�� 5<      $��CarriedAt (yyyy-MM-dd)��6   �� 5=      ��6   �� *	CarriedAt+�� 5?      $��Execute update��6   $��UPDATE��5A      $	��150��5B      $��Center=�5C      $��0 10 0 0q�5D      ��5@      �� *ExecuteQueryCommand+5D      5E      �� 5H   
   $��2��6   $��5q�6%   .+�5I      �� $��DELETE��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   �� 5K      $��Id (Necessarily)��6   �� 5L      ��6   �� *Id+�� 5N      $��Execute delete��6   $��DELETE��5P      $	��150��5Q      $��Center=�5R      $��0 10 0 0q�5S      ��5O      �� *ExecuteQueryCommand+5S      5T      &   System.Windows.Controls.DataGrid  5W   
   $��1��6   $��3��5X         AutoGenerateColumns$
 True��5Z         
IsReadOnly$
 True��5[      $��5q�5\      ��5Y      �� *
QueryTable+5\      5]      5^      