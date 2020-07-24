# robotframework-jenkins-run
This is a simple project to show how to integrate robot run in jenkins with freestyle project. Robotframework-jenkins-run also provide step by step to poll scm push to trigger the build.
It also helps on using [robotframework-metrics](https://pypi.org/project/robotframework-metrics/) to view the dashboard report on jenkins.

# Table of contents
1. [Pre-requisites](#preRequisites)
2. [Steps in Jenkins](#jenkinsStep)

[Troubleshooting viewing report](#Troubleshoot_viewreport)

## 1. Pre-requisites <a name=""></a>
* Clone this project on your local computer.
```
https://github.com/Anilkumar-Shrestha/robotframework-jenkins-run.git
```
* install Jenkins on your PC. for installation, follow steps as: [install jenkins on windows](https://dzone.com/articles/how-to-install-jenkins-on-windows)
* Go to "Manage plugins" in left bar and click on "plugin Manager". You will see the horizontal bar, click on available and type "Robot Framework plugin" on search bar. Install the plugin without restart.
 ![jenkin_rf_plugin](./ss/jenkin_rf_plugin.jpg)

## 2. Steps in Jenkins <a name="jenkinsStep"></a>

* Create New item.
![new_item_click](./ss/new_item_click.jpg)
* Give a suitable project name and select the free style project and click on OK button as shown.
![2_name_freestyle_project](./ss/2_name_freestyle_project.jpg)
* Go to Source code management and select Git radiobutton. Provide the repos url and give your credentials.
![scm](./ss/3_scm.jpg)
> *for Credential setting, please see the link [Adding credentials](https://www.jenkins.io/doc/book/using/using-credentials/)*
* Go to Build trigger and select the Poll SCM button and enter 5 * with spaces to check changes in every minutes.
![poll-scm](./ss/4_poll-scm.jpg)
* Go to Build and click on Add build steps. It pop up the list where you should click on "Execute Window batch Command".
![5_batch_build_step](./ss/5_batch_build_step.jpg)
* Enter the below batch cmd on the command box as shown.
```
robot --outputdir testresults/ requestTest.robot &
robotmetrics -M outputReportMetrics.html --inputpath ./testresults/ --output output.xml --log log.html
```
![6_execute_cmd](./ss/6_execute_cmd.jpg)
* Go to Post-build Actions and click on Add build steps. Select "Publish robot framework test results".
![7_publish_rfresults](./ss/7_publish_rfresults.jpg)
* Add testresults in directory and outputReportMetrics.html on Other files to copy box. CLick Save.
![8_rfmetricsreport](./ss/8_rfmetricsreport.jpg)

* Now, trigger job using Build Now.
![9_buildnow](./ss/9_buildnow.jpg)
> > * After build is complete, click on Robot results.
> > * Click on Original result files.
> > * Open "outputReportMetrics.html" report.

## Troubleshooting report <a name="Troubleshoot_viewreport"></a>
If you get an error below while opening html. Please follow the steps.
![issue_viewing_html](./ss/issue_viewing_html.jpg)

1. Try enabling javascript for browser. example for [chrome](https://support.google.com/adsense/answer/12654?hl=en). 
2. If that doesn't work :
> > * Go to C:\Program Files (x86)\Jenkins
> > * edit jenkins.xml file and add below code snippet in the file removing the existing one. 
```
<arguments>-Xrs -Xmx256m -Dhudson.lifecycle=hudson.lifecycle.WindowsServiceLifecycle -Dhudson.model.DirectoryBrowserSupport.CSP="" -jar "%BASE%\jenkins.war" --httpPort=8080 --webroot="%BASE%\war"</arguments>
```
![solution_html_vie](./ss/solution_html_view.jpg)

