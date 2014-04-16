aws-mlep_v1.0
=============

Cloud-Based Optimization (AWS) component for MLE+.

Requirements
------------
* UNIX Machine: aws-mlep can only be run on a unix-machine.  
* AWS account credentials: http://docs.aws.amazon.com/general/latest/gr/aws-security-credentials.html
* Matlab Installation.  

Installation
------------
1. Download the folder into your machine or clone the repository. 
2. Go into the awsinit.m file and edit the credential information with your own. 
3. Run the installation file awsinit.m 


Examples
========
We have setup 4 different example projects that should be available to run as long as you have a AWS account. AWS-MLEP allows you to perform parametric simulation and search optimization by implementing a Genetic Algorithm. In each of these two categories we can optimized for design as well as run-time parameters. Design parameters refer to fixed value parameters during the simulation, these include wall thickness and material properties. Run-time parameters include room setpoints, occupancy, lighting, loads, etc.    
 
Parametric Analysis
-------------------
This is an example to try multiple construction material properties as well as different thickness. 

1. Construction Material Properties
2. Demand Response: Changes in setpoints strategies. 

Seartch Optimization: Genetic Algorithm
--------------------------------------
This examples use the search optimization to find an optimal based on a objective function. 

1. 
2. 


