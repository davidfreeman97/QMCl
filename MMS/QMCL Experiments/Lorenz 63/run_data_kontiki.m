%%[training] = ode4(@l63_for_ode_solvers,[0:.01:5000],[1;0;0]);
%%[QM] = ode4(@l63_for_ode_solvers,[0:.01:5000],[1.01; 0;0]);

%%training = transpose(training);
%%QM = transpose(QM);
%%QM_initial = QM(:,500000);
%%training_initial = training(:,500000);

%%data_kontiki_output = QMDA_Main_deterministic_RK4(50000, .01, 10000, QM_initial, training_initial, 2, 1000, 1);
%%save("Konitki_Output_Data_5", "data_kontiki_output")




[training] = ode4(@l63_for_ode_solvers,[0:.01:5000],[1;0;0]);
[QM] = ode4(@l63_for_ode_solvers,[0:.01:5000],[1.01; 0;0]);

dbstop if error

training = transpose(training);
QM = transpose(QM);
QM_initial = QM(:,500000);
training_initial = training(:,500000);

%data_kontiki_output = QMDA_Main_deterministic_RK4(30000, .01, 75000, QM_initial, training_initial, 2.5, 1500, 1);
%save("Konitki_Output_Data_2", "data_kontiki_output")

data_kontiki_output = QMDA_Main(20000, .01, 20000, QM_initial, training_initial);
save("Konitki_Stochastic_Output_Data_2", "data_kontiki_output")
