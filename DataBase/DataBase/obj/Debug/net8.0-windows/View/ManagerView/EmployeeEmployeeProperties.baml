   M S B A M L   `   `   `  ����C  ?DataBase, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullE'clr-namespace:DataBase.View.ManagerViewDataBase.View.ManagerView  5      :    4DataBase.View.ManagerView.EmployeeEmployeeProperties   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      9local'clr-namespace:DataBase.View.ManagerView     5      .��5	      � $��5q�6     � RowDefinitions  5
   
   �� 5      $
��Auto �6   �� 5      $��* �6    � ColumnDefinitions 5   
   �� 5      $��* �6   �� 5      $��* �6   �� 5      $��* �6   .+�5   
   �� $��0��6   $��5q�6%   .+�5      �� $��INSERT��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   �� 5      $��EmployeeId (Necessarily)��6   �� 5      ��6   �� *
EmployeeId+�� 5      $��PropertyId (Necessarily)��6   �� 5      ��6   �� *
PropertyId+�� 5      $��Value��6   �� 5      ��6   �� *Val+�� 5!      $��Execute insert��6   $��INSERT��5#      $	��150��5$      $��Center=�5%      $��0 10 0 0q�5&      ��5"      �� *ExecuteQueryCommand+5&      5'      �� 5*   
   $��1��6   $��5q�6%   .+�5+      �� $��UPDATE��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   �� 5-      $��EmployeeId (Necessarily)��6   �� 5.      ��6   �� *
EmployeeId+�� 50      $��PropertyId (Necessarily)��6   �� 51      ��6   �� *
PropertyId+�� 53      $��Value��6   �� 54      ��6   �� *Val+�� 56      $��Execute update��6   $��UPDATE��58      $	��150��59      $��Center=�5:      $��0 10 0 0q�5;      ��57      �� *ExecuteQueryCommand+5;      5<      �� 5?   
   $��2��6   $��5q�6%   .+�5@      �� $��DELETE��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   �� 5B      $��EmployeeId (Necessarily)��6   �� 5C      ��6   �� *
EmployeeId+�� 5E      $��PropertyId (Necessarily)��6   �� 5F      ��6   �� *
PropertyId+�� 5H      $��Execute delete��6   $��DELETE��5J      $	��150��5K      $��Center=�5L      $��0 20 0 0q�5M      ��5I      �� *ExecuteQueryCommand+5M      5N      &   System.Windows.Controls.DataGrid  5Q   
   $��1��6   $��3��5R         AutoGenerateColumns$
 True��5T         
IsReadOnly$
 True��5U      $��5q�5V      ��5S      �� *
QueryTable+5V      5W      5X      