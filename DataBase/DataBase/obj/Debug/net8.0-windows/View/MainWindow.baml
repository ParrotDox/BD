   M S B A M L   `   `   `  ����C  ?DataBase, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null#clr-namespace:DataBaseDataBase  5   	       DataBase.MainWindow   5   	   W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   (localclr-namespace:DataBase     5   	     � Title$  
MainWindow��5   	    � WindowState$ 	Maximized=�5	   	    � WindowStyle$ SingleBorderWindow=�5
   	    � WindowStartupLocation$ CenterScreen=�5   	   $
��1200��5   	   $	��800��5   	   .��5      �  � ColumnDefinitions 5   
   �� 5      $	��65* �6   �� 5      $	��35* �6   .+�5   
   �  � RowDefinitions 5      �� 5      $��40 �6    �� 5      $��1* �6    .+�5      � $��0��6   $��4q�6     5      �� 5      $	��105 �6'   �� 5      $��1* �6'   .+�5      �� $��0��6   $��14(�6(   $��Connected as:��66   $��0 0 5 0q�6N   $��Right=�6_   $��Center=�6�   �� 5      $��1��6   $��Center=�6@    �� 
IsReadOnly$
 True��6b   $	��100��6t   $
��Left=�6�   ��6*   �� *Role+6�   5      �� 5       -   5         ��Name$
 Tabs��5    &   $��1��6    �� SelectedValuePath$	 Tag��64   	 �� SelectedIndex$	 0��5"      
 �� SelectedValue
 5!      �� *CurrentTabTag+ �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�.@�5#      �� $��Views��6   
 � Tag$ Views��6)   {�65   �� *
isEmployee+.��5$      �� ��6%   �� *
SelectedVM+5%      �� 5&      $��
Procedures��6   $ 
Procedures��6.   {�6?   �� *	IsManager+.��5'      �� ��6%   �� *
SelectedVM+5(      �� 5)      $��Manager��6   $ Manager��6+   {�69   �� *	IsManager+.��5*      �� ��6%   �� *
SelectedVM+5+      �� 5,      $��Admin��6   $ Admin��6)   {�65   �� *	IsAdmin+.��5-      �� ��6%   �� *
SelectedVM+5.      5/      51      � 52   
   $��1��6    53      �� 54      $��40 �6    �� 55      $��1* �6    .+�57      �� $��0��6   $��14(�6!   $��5 0 0 0q�6/   $��Logs (Only for admin)��6@   $
��Left=�6`   $��Center=�6�   &   System.Windows.Controls.DataGrid  58      $��1��6      AutoGenerateColumns$
 True��6E      
IsReadOnly$
 True��6`   ��6$   �� *
LogTable+y�6r   �� *AreLogsHidden+59      5:      5;      