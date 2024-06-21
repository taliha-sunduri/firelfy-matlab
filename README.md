# firelfy-matlab

RF_FA_NB_GUI.m, located under the Code folder, should be opened in the MATLAB environment. The program can be run by entering the necessary parameters in the user interface window that will appear when the Run button is clicked. In order to use the data sets, the data set to be used, located under the Database folder, must be entered in the RF_FA_NB_GUI.m file. It should be in the folder where it is located. When writing the names of Data Sets in the interface, .arff must be written at the end. In order to obtain the results obtained in this project, the values ​​must be entered as follows.

Tree number for random forest should be entered as 2000 for SRBCT and Colon Tumor, and 5000 for other data sets.
gamma=1
alpha=0.7
beta0=2
alpha dumping ratio=0.98
number of fireflies=10
number of iterations = 100 or 200
The number of Most Important Genes should be entered as 100 for SRBCT and Colon Tumor and 500 for other data sets.
omega=0.9999

In order to obtain the results obtained in this project, it is necessary to average the results obtained by entering different random seed values. If you want to see the results obtained after each iteration in the MATLAB console, Show Iteration should be checked. After clicking the Run button, the results obtained can be seen in the Results panel.