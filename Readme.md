
import Foundation

.Technical assessment is simple project which show the movie list and also show details page for each movie


#Getting started

1.Download the technical assessment project files from repository
2.Install CoCoaPods
3.Run pod install so you can install depenedecies in your project
4.Open the project file in xcode
5.Review the code and make sure you understand what it does
6.Run the Active Scheme

   
#Architechture

.technical assessment project is implemented using MVVM  with clean Architechture
it consists of three layers 

.Data layer : contains all Dto models and contract for the api requests needed for the api     
.Domain layer : it contains              
                repo: which applying the contarct and make all the necessary api requests . 
                useCase: using repo to make the api request and transform the response from model to entity using mapper.
.presentaionLayer : it contains the views and the viewmodels of the project .
.Coordinator : handle the navigation between view controller
.project doen't have any a database,usev interface or any complex elements

#Structure

.Modules: the source code file for specific module, Files within module folder are organized in subfolders such as "view" and "Modules"
.Resources: Non-code files  that are used by the project which incluse storyboard and images .
.Network: Files or classes related to communication with external api


#Runing the test

The Technical Assessment can be tested by using the built-in framework XCTest

