 dbstop if error;
  QM_data_5 = QMDA_Main(10000, .01, 30000, [1.95, 1.95, 1.95], [2,2,2]);
  plot3(QM_data_5(1,:), QM_data_5(2,:), QM_data_5(3,:))
  
 %QM_data = QMDA_main_embedded_initial(2500, .01, 5000, [2;2;2]);
 %plot3(QM_data(1,:), QM_data(2,:), QM_data(3,:))
 
%dbstop if error;
%QM_data = delay_coordinate_QMDA_Main(3000, .02,160 , [2;2], 3);
%plot3(QM_data(1,:), QM_data(2,:), QM_data(3,:))


%Don't forget to change back the training data initial points

%.0125 timestep with N = 10000, 8000 training  and 500 spectral didnt work
%(only one lobe)

