   M S B A M L   `   `   `  ����C  ?DataBase, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullE'clr-namespace:DataBase.View.ManagerViewDataBase.View.ManagerView  5      *    $DataBase.View.ManagerView.AssetTypes   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      9local'clr-namespace:DataBase.View.ManagerView     5      .��5	      � $��5q�6     � RowDefinitions  5
   
   �� 5      $
��Auto �6   �� 5      $��* �6    � ColumnDefinitions 5   
   �� 5      $��* �6   �� 5      $��* �6   �� 5      $��* �6   .+�5   
   �� $��0��6   $��5q�6%   .+�5      �� $��INSERT��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   �� 5      $��TypeName��6   �� 5      ��6   �� *
TypeName+�� 5      $��Execute insert��6   $��INSERT��5      $	��150��5      $��Center=�5      $��0 10 0 0q�5       ��5      �� *ExecuteQueryCommand+5       5!      �� 5$   
   $��1��6   $��5q�6%   .+�5%      �� $��UPDATE��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   �� 5'      $��Id��6   �� 5(      ��6   �� *Id+�� 5*      $��TypeName��6   �� 5+      ��6   �� *
TypeName+�� 5-      $��Execute update��6   $��UPDATE��5/      $	��150��50      $��Center=�51      $��0 10 0 0q�52      ��5.      �� *ExecuteQueryCommand+52      53      �� 56   
   $��2��6   $��5q�6%   .+�57      �� $��DELETE��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   �� 59      $��Id��6   �� 5:      ��6   �� *Id+�� 5<      $��Execute delete��6   $��DELETE��5>      $	��150��5?      $��Center=�5@      $��0 20 0 0q�5A      ��5=      �� *ExecuteQueryCommand+5A      5B      &   System.Windows.Controls.DataGrid  5E   
   $��1��6   $��3��5F         AutoGenerateColumns$
 True��5H         
IsReadOnly$
 True��5I      $��5q�5J      ��5G      �� *
QueryTable+5J      5K      5L      