Valuazioni ISCRA
========================
Linee guida:
------------

Linee guida [ISCRA C](https://wiki.u-gov.it/confluence/display/SCAIIN/ISCRA+C)  
Linee guida [ISCRA B](https://wiki.u-gov.it/confluence/display/SCAIIN/ISCRA+B)

Spunti per Motivation
---------------------

I suggest (for the next call) providing some more explicit explanation about the core hours estimation.

The project is interesting and well-written. 

Manca tuttavia qualsiasi dettaglio computazionale circa le simulazioni che si intendono fare (i.e. risorse necessarie per una tipica simulazione, durata di una tipica simulazione, etc...).
Si raccomanda per i progetti futuri di inserire adeguati dettagli computazionali per giustificare la richiesta di risorse.

No details have been provided on either the type of simulations that will be performed or the software that will be used.
The request for the maximum number of hours is not justified.
For the future, it is strongly recommended to detail the computational requirements and the type of simulations and not just ask for maximum hours.
The computational request is in line with that of an iscraC. 

Spunti per Additional notes
---------------------------
Non giustifica in modo esplicito le ore richieste, ma dal cv e dai lavori è uno che sa quello che fa, per cui approverei su entrambi i cluster, magari da valutare il budget su g100.


ISCRA B
=======
Iscra B LAZEYRAS (HP10BLXSO1)
-------------------------------
**Motivation:**  
The requested resources for the optimal case of 3 simulations is suitable for Galileo100.  
To allow the required number of nodes per run and the required memory per node, partition g100_usr_prod and the qos g100_qos_bprod are suggested.  
Output data, which will be downloaded and post-processed on a local machine, require about 4TB of work quota, while scratch area can be used for temporary data

**Comment on the software required (parallel libraries, scientific libraries, other specific libraries, compilers and development tools):**  
Necessary compiler and libraries for code GIZMO, based on MPI parallelization, are available on Galileo100.  
The code is public, has already been used on Marconi and its compiling should therefore be straightforward on Galileo100.

**Comment on the applications to be used (stability and maturity of the codes, scalability and efficiency, etc) and evaluate the enabling effort with respect to the proposal:**  
GIZMO code is massively parallel and able to run efficiently on an increasing number of cores.  
The I/O part of the code is also MPI parallelized and hence takes a negligible part of the total execution time.  
Scalability tests for GIZMO have been performed on Marconi. It is also very similar to the already tested Arepo code, with important additional features.

**Additional notes:**  
Current proposal follows a previous rejected proposal, for which have been addressed the scientific referees' concerns on uniqueness of the code and hydrodynamical model used and fragmentation of low mass halos in WDM simulation
Current proposal follows a previous rejected proposal, for which have been addressed the scientific referees' concerns on uniqueness of the code and hydrodynamical model used and fragmentation of low mass halos in WDM simulation



Iscra B COZZO (HP10B89PCC)
-----------------------------
The requested resources for the optimal case is suitable for Galileo100.
To allow the required number of nodes per run, partition g100_usr_prod and the deafult qos are suggested, although with a constrain on the required memory per node limited to 366 GB.
The default WORK space is 1 TB, but it could be increased at the moment of need, after request.
Scratch area can be used for temporary data.
The quota requested for archive must be requested trough a classD proposal.


Iscra B: VAZZA (HP10B5E3BD)
-----------------------------
**Motivation:**  
The project and the requested resources are suitable on Leonardo. Enzo code is a well known astrophysical code that demonstrates a very good scalability.  
To allow the required number of nodes and memory per run, partition boost_usr_prod and the deafult qos are suggested.  
The default work space is 1 tb, but it could be increased at the moment of need, after request.  
Scratch area can be used for temporary data.  
The quota requested for archive must be requested trough a classd proposal.  

**Comment on the software required (parallel libraries, scientific libraries, other specific libraries, compilers and development tools):**  
Enzo code has been already installed on several cineca clusters without any particular issues. Libraries needed by ENZO are already installed on Leonardo.

**Comment on the applications to be used (stability and maturity of the codes, scalability and efficiency, etc) and evaluate the enabling effort with respect to the proposal:**  
Enzo is a well known code with very good scalability and can make good use of Leonardo GPUs.


Iscra B: PEREGO (HP10B9SC7Q)
-----------------------------
**Motivation:**  
The project and the requested resources are suitable on Leonardo.
AthenaK code has not been significatly used on our clusters, but some tests were performed on Leonardo and extensive experiments have been performed on similar clusters.
To allow the required number of nodes per run, partition boost_usr_prod and the default qos are suggested.
The default WORK space is 1 TB, which should meet the project's needs, but it could be increased at the moment of need, after request.
SCRATCH area can be used to store temporarily data before transfer them to local machines.

**Comment on the software required (parallel libraries, scientific libraries, other specific libraries, compilers and development tools):**  
Although AthenaK code is still new on Cineca clusters, libraries and compilers needed are already present on Leonardo.

**Comment on the applications to be used (stability and maturity of the codes, scalability and efficiency, etc) and evaluate the enabling effort with respect to the proposal:**  
Some tests with AthenaK have already been run on Leonardo, and although not heavily used, it shows good scalability on other clusters with similar GPUs and can potentially perform well on Leonardo Booster.

Iscra B: PRINCIPE (HP10BQRWLE)
-------------------------------
**Motivation:**  
The project and the requested resources are suitable on Leonardo.  
The requirements for a typical run are fully acceptable.  
The total number of requested GPU and core hours falls within the limits proposed by Iscra B, but this value should be determined through a calculation that considers the time required to reach a solution, the anticipated number of runs, and the number of cores utilized per run.  
The tools are reported to have a good scalability on parallel systems, although the effectiveness of scalability and efficiency is not clearly presented in the proposal.  
Disk requirements are extremely high. The temporary disk quota (10 TB) seems quite large, and it could constitute a problem. The analysis storage quota (250 TB) is above the limit even for a Iscra D proposal, for which the applicant already planned to submit a request.  

**Comment on the software required (parallel libraries, scientific libraries, other specific libraries, compilers and development tools):**  
Software used are mostly Python-based, which is installed on our clusters, and all the other necessary compiler and libraries needed are available on Leonardo.  

**Comment on the applications to be used (stability and maturity of the codes, scalability and efficiency, etc) and evaluate the enabling effort with respect to the proposal:**  
This project involves multiple codes and software, with various level of scalability, but all of them exhibit good scalability and can make good use of Leonardo GPUs.

Iscra B: GIRI (HP10B4ZD56)
-----------------------------
**Motivation:**  
The project and requested resources are well suited for the Leonardo system.
PLUTO, a widely recognized astrophysical code, has demonstrated excellent scalability on Leonardo.
To accommodate the required number of nodes and memory per run, the partition dcgp_usr_prod along with the default qos settings are appropriate.
Disk space requirements are small: the default workspace provides 1 TB of storage, which can be increased upon request if necessary. Additionally, the SCRATCH area is available for temporary data storage.

**Comment on the software required (parallel libraries, scientific libraries, other specific libraries, compilers and development tools):**  
Necessary software and libraries are already available on Leonardo.
The PLUTO code is publicly accessible and based on MPI libraries. The required compilers and libraries are installed on Leonardo, and since PLUTO has been successfully used on this system before, compiling it should be straightforward.

**Comment on the applications to be used (stability and maturity of the codes, scalability and efficiency, etc) and evaluate the enabling effort with respect to the proposal:**  
PLUTO is a well known code with very good scalability and can make good use of Leonardo CPUs.

Iscra B: DAMIANO (HP10BKFSPX)
-------------------------------
**Motivation:**  
The project and requested resources are suited for the Leonardo system.
OpenGADGET3 is a popular astrophysical code, widely used on CINECA's clusters, which has shown good scalability on Leonardo.
To accommodate the 64 nodes and memory per run requested, the partition dcgp_usr_prod along with the dcgp_qos_bprod qos settings are appropriate.
The default WORK space is 1 TB, but it can be increased at the moment of need, after request. Scratch area can be used for temporary data.

**Comment on the software required (parallel libraries, scientific libraries, other specific libraries, compilers and development tools):**  
Necessary software and libraries are already available on Leonardo. OpenGADGET3 is a publicly accessible parallelized code with a hybrid MPI+OpenMP architecture. The required compilers and libraries are installed on Leonardo, and since it has been successfully used on this system before, compiling it should be straightforward.

**Comment on the applications to be used (stability and maturity of the codes, scalability and efficiency, etc) and evaluate the enabling effort with respect to the proposal:**  
OpenGADGET3 is a well known code with very good scalability and can make good use of Leonardo CPUs.

Iscra B: RAGAGNIN (HP10BUFI59)
-------------------------------
**Motivation:**  
The project and requested resources are suited for the Leonardo system.
OpenGADGET3 is a popular astrophysical code, widely used on CINECA clusters, which has shown good scalability on Leonardo.
For output data, default WORK space is 1 TB, but it could be increased at the moment of need, after request at superc@cineca.it. If necessary SCRATCH area can be used for temporary data.

**Comment on the software required (parallel libraries, scientific libraries, other specific libraries, compilers and development tools):**  
Necessary software and libraries are already available on Leonardo. OpenGADGET3 is a publicly accessible parallelized code with a hybrid MPI+OpenMP architecture. The required compilers and libraries are installed on Leonardo, and since it has been successfully used on this system before, compiling it should be straightforward.


**Comment on the applications to be used (stability and maturity of the codes, scalability and efficiency, etc) and evaluate the enabling effort with respect to the proposal:**  
OpenGADGET3 is a well known code with very good scalability and can make good use of Leonardo CPUs.

Iscra B: CAMMELLI (HP10B7JEHN)
-------------------------------
**Motivation:**  
The project and the requested resources are suitable on Leonardo Booster.
AthenaPK code was tested on Leonardo-Booster via ISCRA-C projects showing excellent scalability both in the strong and weak regimes.
To allow the required number of nodes per run, partition boost_usr_prod and the boost_qos_bprod qos are suggested.
The default WORK space is 1 TB, but it can be increased at the moment of need, after request.
SCRATCH area can be used to store temporarily data before transfer them to local machines.

**Comment on the software required (parallel libraries, scientific libraries, other specific libraries, compilers and development tools):**  
AthenaPK is a publicly accessible parallelized code, its required compilers and libraries are installed on Leonardo, and since it has been successfully used on this system before, compiling it should be straightforward.

**Comment on the applications to be used (stability and maturity of the codes, scalability and efficiency, etc) and evaluate the enabling effort with respect to the proposal:**  
In addition to several different top100 supercomputers, AthenaPK code has also been tested on Leonardo-Booster via ISCRA-C projects showing excellent scalability both in the strong and weak regimes.

Iscra B: QUADRIO (HP10B1PR3D)
-------------------------------
**Motivation:**  
The proposed resources fall within the limits of the projects, however, no estimation has been provided for these values. Moreover, the minimum resource requirement reported exceeds the optimal configuration, and the software and libraries necessary for the work are not specified.  
It is recommended to first submit a request for an ISCRA C project, to be used as a benchmark. This would allow for a more accurate assessment of machine performance and enable the subsequent planning of a larger-scale simulation under an ISCRA B project.

**Comment on the software required (parallel libraries, scientific libraries, other specific libraries, compilers and development tools):**  
Othe than C compiler, necessary software and libraries are not specified.

**Comment on the applications to be used (stability and maturity of the codes, scalability and efficiency, etc) and evaluate the enabling effort with respect to the proposal:**  
The scalability test presented for AMPHIBIOUS demonstrates good performance. However, the methodology and the system on which it was conducted are not clearly described.

**Internal Additional notes (please comment negative recommendation)**  
It is unclear how the requested resources have been estimated, as no benchmarks or workplan are provided.
I suggest first applying for an ISCRA C project and, once benchmark values are available, submitting an ISCRA B request.

Iscra B: GAGGERO (HP10BEDVDW)
-------------------------------
**Motivation:**  
The project is well presented, the requested resources are justified and within the limits of an Iscra B on G100.  
The software required is broadly used and demonstrates a very good scalability.  
To allow the required number of nodes per run and the required memory per node, partition g100_usr_prod and the default qos are suggested.  
Disk requirements, limited to 2TB thanks to pre and post processing and storage hosted on a local machine, will be easy to satisfy.  

**Comment on the software required (parallel libraries, scientific libraries, other specific libraries, compilers and development tools):**  
The two necessary software, OpenFOAM e STAR CCM+, are already available on G100 and have been widely used on this system.

**Comment on the applications to be used (stability and maturity of the codes, scalability and efficiency, etc) and evaluate the enabling effort with respect to the proposal:**  
OpenFOAM and STAR CCM+ are well known software that show good performances on G100.

Iscra B: PEREGO (HP10BF6C00)
-------------------------------
**Motivation:**  
The project is technically sound and clearly presented, the computational resources requested are within the limits of an ISCRA B project and are well justified.
The AthenaK code has already been employed on Leonardo Booster, and the tests conducted have provided positive results.
To ensure the required number of nodes per run, it is recommended to use the boost_usr_prod partition with the default QoS.
The default WORK space of 1 TB should meet the project’s requirements, but it may be increased upon request.
The SCRATCH area may be utilised for temporary data storage prior to transferring files to local machines.

**Comment on the software required (parallel libraries, scientific libraries, other specific libraries, compilers and development tools):**  
The necessary software and libraries are already available on Leonardo, and both the AthenaK code and the BNS_NURATES library are publicly accessible.

**Comment on the applications to be used (stability and maturity of the codes, scalability and efficiency, etc) and evaluate the enabling effort with respect to the proposal:**  
AthenaK has already been deployed on Leonardo, and tests conducted on this and similar clusters, in combination with BNS_NURATES library, have demonstrated very good performance.

Iscra B: SCHLEICHER (HP10B88G71)
-------------------------------
**Motivation:**  

**Comment on the software required (parallel libraries, scientific libraries, other specific libraries, compilers and development tools):**  

**Comment on the applications to be used (stability and maturity of the codes, scalability and efficiency, etc) and evaluate the enabling effort with respect to the proposal:**  


Iscra B: BOULA (HP10BA9JKC)
-------------------------------
**Motivation:**  

**Comment on the software required (parallel libraries, scientific libraries, other specific libraries, compilers and development tools):**  

**Comment on the applications to be used (stability and maturity of the codes, scalability and efficiency, etc) and evaluate the enabling effort with respect to the proposal:**  



----------------------------------------------------------------------------------------------------------------------------------
ISCRA C
=======
Iscra C: BALDI (HP10C52ODR)
-------------------------------
**Motivation:**   
Project ok, healpix module in not currently installed on G100 but we plan to install it.
If not present, the user can install it locally

Iscra C: CAPUZZO DOLCETTA (HP10C4QXSV)
-------------------------------
**Motivation:**   
Project ok, Nbody6++GPU code is public, it's suitable for parallel and GPU accelerated runs and has already been used on LEONARDO BOOSTER.


Iscra C: DESPALI (HP10CY85VI)
-------------------------------
**Motivation:**   
Project ok, but current partitions allow runs with max 64 nodes per run, thus the maximum number of cores have to be decreased to 3072.

Iscra C: VAZZA (HP10C78P90)
-------------------------------
**Motivation:**   
Project ok, the code has been used by applicant and his team in previous projects, libraries needed by ENZO are already installed on Leonardo.

Iscra C: NTORMOUSI (HP10COB24C)
-------------------------------
**Motivation:**   
The project can not be evaluated due to lack of information.  
Details would be necessary about resources with estimations on the number of nodes, the number of runs, and the wall time for each simulation, in order to justify the total amount requested.  
Info on what code or libraries are going to be used would also be useful, along with the reasons behind the requested cluster.

Iscra C: MARIS (HP10C9SIY8)
-------------------------------
**Motivation:**   
Project ok, requirements compliant after email exchange that rectified the resources requested.  
Please note that in order to obtain 10TB of storage, once the project is created, will be necessary to send a ticket asking for the extension of the storage from the default 1TB to the desired 10TB, the supply of which is subject to availability at the time.

**Additional notes:**  
Resources stated in HPC Requirements section are incorrect, after contacting the PI, he clarified he needs:  
100000 core hours  
240 maximum cores  
10TB of storage

Iscra C: LAROSA (HP10CJ0LMT)
-------------------------------
**Motivation:**   
 The code has been used by applicant and his team in previous projects.

Iscra C: QUADRI (HP10C5NK7D)
-------------------------------
**Motivation:**   
Project ok, libraries needed are already installed on Leonardo or can be installed by the user.

Iscra C: BOULA (HP10CJIYEO)
-------------------------------
**Motivation:**   
Project ok, PLUTO code is public, its necessary compiler and libraries are available, it's based on MPI libraries and has already been tested on Galileo100.


Iscra C: RAGAGNIN (HP10CZNHIO)
-------------------------------
**Motivation:**   
Project ok, libraries needed for compiling OpenGadget are or are going to be installed on Leonardo.  
Be aware that once Leonardo enters production phase, max number of nodes will be reduced to 256, hence maximum number of usable GPU is going to be 1024.


Iscra C: ENIA (HP10CG3I4K)
-------------------------------
**Motivation:**   
Project ok, needed libraries are already present on Leonardo in the cineca-ai module.  
In order to use jupyter, we suggest to use our forward2 tool.

Iscra C: DE RENZIS (HP10CJTYQ2)
-------------------------------
**Motivation:**   
Project ok, tensorflow is available through cineca-ai module.

Iscra C: CONTARINI (HP10C2PR6R)
-------------------------------
**Motivation:**   
The project can not be evaluated because it lacks information.  
Would be necessary details about resources with estimations on the number of nodes, the number of runs, and the wall time for each simulation, in order to justify the total amount requested.  
Also an explanation on why both clusters are requested would be useful.

Iscra C: MALENZA (HP10C0YMCK)
-------------------------------
**Motivation:**   
Project ok. Anyway, it would be appreciated even a rough explanation for the requested budget, such as number of jobs, size and walltime of the job.  
Please take this into account for future applications, as also stated in the previous ISCRA request.


**Additional notes:**
There is no explanation about how the budget will be used.  
The project aims to test results of different libraries, this kind of benchmarks don't usually use a big amount of data, so the request of 10.000 GPU hours are not motivated. Suggestion is to start with a small budget and increase it only if applicants ask for an increment.


Iscra C: BRANCA (HP10CNFQA7)
-------------------------------
**Motivation:**   
Project ok, needed libraries for DeepXDE are already present on Leonardo in the cineca-ai module.


Iscra C: BORTOLAS (HP10CMMM5Q)
-------------------------------
**Motivation:**   
Project ok, requirements compliant after email exchange that rectified the resources requested.  
Libraries needed by BIFROST code are already installed on Leonardo.

**Additional notes:**  
Resources stated in HPC Requirements section are incorrect.  
After contacting the PI, she clarified she needs:
- 10.000 GPU hours on Leonardo
- 4 maximum GPUs
- 1TB of storage

Iscra C: QUERCI (HP10C8L5SR)
-------------------------------
**Motivation:**  
Project ok, the code has been used by applicant and his team in previous try project, libraries needed by FLASH code are already installed on Leonardo.


Iscra C: DI SANTO (HP10CHDEMO)
-------------------------------
**Motivation:**  
In estimating the resources needed by the applicant, only 20 cores are considered.  
Since each node of G100 hosts 2 CPU Intel Xeon Platinum 8276 with 24 cores each, resulting in 48 cores per node, using the whole node could reduce the CPU hours needed for the applicant's simulations.  
This just to inform users that a single node has 48 cores. This may help in organizing the job scripts.  
In the application the libraries needed by codes MORDOR and AREPO are missing.  
In case some fundamental library is not present on the cluster, please write to superc@cineca.it for evaluating a new module installation.  
For future applications I suggest to briefly describe the code and its dependencies and if the code has been ported to GPUs or not to better help the allocation of the project in the correct cluster.  
The need of 2 TB of storage depends on the storage situation. When needed please write to superc@cineca.it to check for its availability.

Iscra C: VERDINI (HP10CZ41KO)
-------------------------------
**Motivation:**  
Project ok, the code has already been ported on Leonardo booster.
In case some fundamental library is not present on the cluster, the user can install it locally or write to superc@cineca.it for evaluating a new module installation.  

Iscra C: SANGALLI (HP10C8JJ1U)
-------------------------------
**Motivation:**  
Project ok, the code has already been used by applicant and his team in previous projects, software required are already installed on Leonardo.

Iscra C: ORSINI (HP10CNMQES)
-------------------------------
**Motivation**  
Project ok. The requested resources are reasonable, and the required software is already available on Leonardo. It is recommended that the user utilize miniconda rather than anaconda.

**Additional notes:**  
The user, in addition to the resources on Leonardo Booster, requests 128 core hours on G100 for offline data preprocessing of a dataset containing approximately 100k samples. This operation will be performed once, with the result saved to disk.

Iscra C: BARBIERI (HP10C6POO5)
-------------------------------
**Motivation**  
Project ok. Following email exchange, the requested resources have been confirmed to be technically feasible and that necessary software is already installed on Leonardo.

**Additional notes**  
The PI clarified the requirements in an email exchange.
They plan to run a total of 36 jobs, each requiring 32 cores, grouped in sets of 4. Therefore, the number of concurrent cores is 4 × 32 = 128, rounded up to 2 nodes.

There is an option to run all 36 jobs simultaneously, which would require 36 × 32 = 1,152 cores, equivalent to 11 nodes. However, this is not the planned approach.
For this reason, while the maximum potential core usage is 1152, the actual expected usage is 128 cores (2 nodes).

Iscra C: PAIS (HP10CFNPS2)
-------------------------------
**Motivation**  
Project ok, PLUTO code is public, its necessary compiler and libraries are available and it's based on MPI libraries. Requirements for AM3 and Mesa are already present on Leonardo.

Iscra C: JENNINGS (HP10CRLBIY)
-------------------------------
**Motivation**  
The project is generally feasible. Necessary software components are already available, and the storage requirements are modest.
However, the requested number of 8192 GPUs, approximately 60% of the entire cluster’s GPU capacity, significantly exceeds the maximum available allocation. Specifically, the maximum number of GPUs accessible with the boost_qos_bprod qos is 1024, corresponding to 256 nodes. The current GPU request surpasses this limit.
Additionally, it would be helpful to receive a rough justification for the requested budget, including details such as the anticipated number of jobs, as well as typical job sizes and walltimes.

**Additional notes**  
The PI requested an unusually large number of GPUs (8192), which greatly exceeds the available resources.

Iscra C: MARULLI (HP10CQNH8Y)
-------------------------------
**Motivation**  
Project ok. The requested resources are within the constraints and the required software is already available on Leonardo.

Iscra C: ARMENIO (HP10CN6XTA)
-------------------------------
**Motivation**  
The project cannot be evaluated because the necessary information is missing.
To justify the total amount requested, details are required on the available resources, including estimates of the number of nodes, the number of runs, and the wall time for each simulation.
It would also be helpful to specify which code or libraries will be used and to explain the reasons for requesting the cluster.

Iscra C: NARRACCI (HP10CYZ618)
-------------------------------
**Motivation**  
The project is acceptable, and the requested computational resources are within the limits of the assigned project class. However, we would appreciate at least a brief explanation of how the estimated resources were determined. Please keep this in mind for future applications.

Iscra C: AMBROGIONI (HP10CD6TEG)
-------------------------------
**Motivation**  
The project is acceptable, and the requested computational resources are within the limits of the assigned project class. However, we would appreciate at least a brief explanation of how the estimated resources were determined. Please keep this in mind for future applications.

Iscra C: LUCHINA (HP10CSLDPN)
-------------------------------
**Motivation**  
Project ok. The requested computational resources are within the limits of the assigned project class. The FLASK code is publicly available, its required compiler and libraries are accessible, and it uses OpenMP for parallelization.

Iscra C: BORGHI (HP10C8209W)
-------------------------------
**Motivation**  
 The project continues a previous ISCRA C, and the requested computational resources fall within the limits of the assigned project class.

Iscra C: SYTOV (HP10CA2N2O)
-------------------------------
**Motivation**  
Project approved. The requested computational resources fall within the limits of the assigned project class.
The applicant has already tested the WarpX code on the Leonardo Booster. Both OpenPMD and Geant4 can be installed via Spack, and Jupyter Notebook is available through the cineca-hpyc module. The necessary libraries for the remaining required software are already provided within the environment.  
Please note that in order to obtain 5 TB of storage, once the project is created, will be necessary to send a ticket asking for the extension of the storage from the default 1TB to the desired 5 TB, the supply of which is subject to availability at the time.  

**Additional notes**  
The applicant requests that priority be given to resources for Leonardo Booster.

Iscra C:  DE FILIPPO (HP10CDX5I8)
-------------------------------
**Motivation**  
The proposal does not indicate the number of hours required for the project, making it impossible to assess.

Iscra C:  PAGANI (HP10C4PQ09)
-------------------------------
**Motivation**  
The project is acceptable, the requested computational resources are within the limits of the assigned project class and the required software is already available on Leonardo.
For future applications, we would appreciate at least a brief explanation of how the estimated resources were determined.

Iscra C:  RAGAGNIN (HP10CA75OD)
-------------------------------
**Motivation**  
Project ok, the requested computational resources fall within the allowed limits, and the required software is already available on Leonardo.
To obtain the requested storage, once the project has been created, please contact superc@cineca.it to request an extension from the default 1 TB to 15 TB. Please note that allocation of additional storage is subject to availability at the time of the request.

Iscra C:  MORSHED (HP10CHEXFS)  1 Luglio
-------------------------------
**Motivation**  
The project is acceptable, and the requested computational resources are within the limits of the assigned project class. However, it would be appreciated even a rough explanation for the requested budget, such as number of jobs, size and walltime of the job. Please keep this in mind for future applications.

ISCRA D
=======

Iscra D: RAGAGNIN (HP10D538JW)
-------------------------------
Nessuna aggiunta
