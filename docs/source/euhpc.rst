################
Valutazioni EHPC
################

Link
----

https://access.eurohpc-ju.europa.eu/

https://access.eurohpc-ju.europa.eu/auth/login

***
REG
***

EHPC-REG-2025R02-368
--------------------

**Are the codes to be used in the project suitable for the architecture
of the machine chosen?** AthenaPK is a freely-distributed software code
that makes use of GPU and has already been successfully run on Leonardo
Booster.

**Is the code installed on the machine chosen?** The code is not
installed, but the required compiler and libraries are already available
on Leonardo Booster.

**Is the amount of time requested compatible with the work plan?** The
estimated node hours for each run type align with the total required
node hours. The work plan presents a reasonable distribution of time
across the project duration, allocated among six team members.

**Does the project require further testing and optimization?** The code
has already been tested on a broad set of HPC systems, like JUWELS
BoosterGPU, which employs NVIDIA A100 GPUs and is architecturally
similar to Leonardo-Booster, and also directly on Leonardo-Booster,
where it demonstrate excellent strong and weak scaling up to 128 GPUs,
with 32 GPUs offering the best throughput-to-cost ratio.

**Comment on the anticipated efficiency of the resource utilization**
The time-to-solution plot indicates excellent scalability on Leonardo
Booster, with strong and weak scaling both performing effectively.
Checkpoint files will be created at 4-6 hour intervals to enhance fault
tolerance and ensure computational resiliency.

**Comment globally on the provided technical data and your conclusions**
The proposed use of AthenaPK aligns well with the Leonardo Booster
architecture, as the code has already demonstrated proven performance
and compatibility with similar GPU-based HPC systems. Although the
software is not yet installed on the machine, the necessary compilers
and libraries are available, facilitating straightforward deployment.
The requested computational time is coherent with the outlined work plan
and adequately distributed among the project participants. Furthermore,
given the code’s extensive testing history and strong scalability
results up to 128 GPUs, no further preliminary optimization appears
necessary prior to production runs. The anticipated resource efficiency
is high, as demonstrated by excellent strong and weak scaling on the
target architecture. The inclusion of regular checkpointing every few
hours provides additional robustness and efficient recovery capability.

**Reason for classification** The project is technically well-prepared,
the resource request is justified, and the expected utilization of
Leonardo Booster is both effective and efficient.

**Application Support Team (AST)** An AST was not requested

EHPC-REG-2025R02-366
--------------------

**Are the codes to be used in the project suitable for the architecture
of the machine chosen?** AthenaPK is a public software code that makes
use of GPU and has already been successfully run on Leonardo Booster.

**Is the code installed on the machine chosen?** The code is not
installed, but the necessary compiler and libraries are already present
on Leonardo Booster.

**Is the amount of time requested compatible with the work plan?** The
estimated node hours for each run type are consistent with the total
required node hours. The work plan provides a balanced allocation of
time throughout the project, distributed among the six team members. To
minimize potential delays due to factors such as installation periods,
temporary cluster downtime, or long queue times, it is recommended to
utilize all allocated resources within the first nine months, allowing a
buffer for unforeseen issues.

**Does the project require further testing and optimization?** The code
has been thoroughly tested across various HPC systems, including JUWELS
BoosterGPU, which uses NVIDIA A100 GPUs and shares a similar
architecture with Leonardo-Booster, as well as directly on
Leonardo-Booster itself, where it demonstrated excellent strong and weak
scaling up to 128 GPUs, with optimal throughput-to-cost performance
achieved at 32 GPUs.

**Comment on the anticipated efficiency of the resource utilization**
The time-to-solution analysis demonstrates outstanding scalability on
the Leonardo Booster system, with both strong and weak scaling
performing efficiently. Checkpoint files will be generated every 4-6
hours to improve fault tolerance and maintain computational resilience.

**Comment globally on the provided technical data and your conclusions**
The proposed use of AthenaPK on the Leonardo Booster platform is
technically well justified and appropriate for the project’s
computational needs. The code is fully compatible with the machine’s
GPU-based architecture, as demonstrated by previous successful runs on
Leonardo Booster. Although the code is not currently installed, all
essential compilers and libraries are already available, ensuring a
straightforward installation process with minimal setup effort. The
requested computational time is coherent with the project work plan. The
distribution of node hours across different run types and among the six
team members indicates sound planning and efficient workload management.
The recommendation to complete the dominant portion of computations
within the first nine months is aimed to mitigate any risck in view of
possible installation periods or queue delays. Given the code’s proven
scalability and stability, no further optimization or testing appears
necessary. Benchmarking results confirm excellent efficiency on Leonardo
Booster, showing strong and weak scaling performance up to 128 GPUs and
optimal cost-efficiency around 32 GPUs.

**Reason for classification** The project is technically sound, the
resource request is well-justified, and the use of Leonardo Booster
appears both effective and efficient.

**Application Support Team (AST)** An AST was not requested

EHPC-REG-2026R01-024
--------------------

**Are the codes to be used in the project suitable for the architecture
of the machine chosen?** Amitis is a code developed by the PI, optimized
for parallel execution on Nvidia GPUs, is implemented in CUDA and uses
OpenMPI. All required libraries have already been installed and the code
has already been used on Leonardo-Booster

**Is the code installed on the machine chosen?** The code is not
installed, but the necessary compiler and libraries are already present
on Leonardo Booster.

**Is the amount of time requested compatible with the work plan?** Since
the scope of this project is limited to the execution of 120
simulations, both the estimation of the required node hours and the
proposed work plan are straightforward, and the project can be
efficiently managed and completed by the two team members.

**Does the project require further testing and optimization?** The code
has already been benchmarked and used on Leonardo-Booster in two
previous EuroHPC calls, as well as on several GPU-based systems,
demonstrating excellent strong and weak scaling up to 128 GPUs.

**Comment on the anticipated efficiency of the resource utilization**
The time-to-solution analysis demonstrates very good scalability on
Leonardo Booster, with both strong and weak scaling performing
efficiently. Checkpoint files will be generated every 12 hours to
improve fault tolerance and maintain computational resilience.

**Comment globally on the provided technical data and your conclusions**
The proposed use of Amitis code on Leonardo Booster is technically well
justified and appropriate for the project’s computational needs. The
code is fully compatible with the machine’s GPU-based architecture, as
demonstrated by previous successful runs on Leonardo Booster. Although
the code is not currently installed, all essential compilers and
libraries are already available, ensuring a straightforward installation
process with minimal setup effort. The requested computational time is
coherent with the outlined work plan and the project can be handled
efficiently and completed by the two team members. Given the code’s
proven scalability and stability, no further optimization or testing
appears necessary. Previous works results confirm excellent efficiency
on Leonardo Booster, showing strong and weak scaling performance up to
128 GPUs.

**Reason for classification** The project is technically solid, the
resource request is appropriate, and the intended use of Leonardo
Booster is efficient and well targeted.

**Application Support Team (AST)** An AST was not requested

***
DEV
***

EHPC-DEV-2025D05-028
--------------------

**Are the codes to be used in the project suitable for the architecture
of the machine chosen?** PLUTO code is public, it’s based on MPI
libraries and has already been used on Leonardo DCGP.

**Is the code installed on the machine chosen?** The necessary compiler
and libraries for PLUTO code are already available on Leonardo DCGP.

**Are the targets proposed feasible within the allocation time -
Workplan?** The resources allocated to the project are adequate, and it
is realistic to fully utilize the 4000 node hours within the 6 month
allocation period.

**Comment globally on the provided technical data and your conclusions**
The project is going to utilize the PLUTO code, a well tested and
parallelized tool. The proposed approach for addressing bottlenecks is
sound and well considered. The requirements for thread count, RAM, and
storage capacity are easily satisfied. Code and computational resources
are a good match, installation requirements are met, and the timeline is
feasible.

**Classification** Accepted

**Reason for classification** The project is well presented, robust and
feasible.

EHPC-DEV-2025D05-031
--------------------

**Are the codes to be used in the project suitable for the architecture
of the machine chosen?** PLUTO is a freely-distributed software code
that uses MPI libraries for parallel computing and has already been
successfully run on the Leonardo DCGP system

**Is the code installed on the machine chosen?** The required compiler
and libraries are already available on Leonardo DCGP.

**Are the targets proposed feasible within the allocation time -
Workplan?** The resources assigned to the project are adequate, and it
is feasible to make full use of the 4000 node hours within the 6 month
allocation period.

**Comment globally on the provided technical data and your conclusions**
The project will employ PLUTO, a robust and widely tested
parallelization tool. The strategy for identifying and addressing
computational bottlenecks isis sound and well considered. Requirements
for thread count, memory, and storage are readily met by the selected
cluster. The code is well suited to the available computational
resources, installation prerequisites are fulfilled, and the project
timeline is achievable.

**Classification** Accepted

**Reason for classification** The project is clearly presented, solid,
and achievable.

EHPC-DEV-2026D04-161
--------------------

**Are the codes to be used in the project suitable for the architecture
of the machine chosen?** gPLUTO is a freely-distributed software code,
GPU-enabled successor of PLUTO, that uses MPI libraries for parallel
computing and has already been successfully run on Leonardo Booster.

**Is the code installed on the machine chosen?** The code is not
installed, but the necessary compiler and libraries are already present
on Leonardo Booster.

**Are the targets proposed feasible within the allocation time -
Workplan?** The resources assigned to the project are adequate, and it
is feasible to make full use of the 4500 node hours within the 12 month
allocation period.

**Comment globally on the provided technical data and your conclusions**
The project will employ gPLUTO, a next-generation code that has been
successfully tested on multiple European pre-exascale systems, including
Leonardo, where it demonstrated excellent portability and scalability.
The strategy for identifying and mitigating computational bottlenecks is
well-structured and thoughtfully designed. The selected cluster fully
satisfies the requirements for thread count, memory, and storage.
Overall, the code is well matched to the available computational
resources, all installation prerequisites are met, and the project
timeline is realistic and achievable.

**Classification** Accepted

**Reason for classification** The project is clearly presented, solid,
and achievable.

EHPC-DEV-2026D04-204
--------------------

**Are the codes to be used in the project suitable for the architecture
of the machine chosen?** RICH is a publicly available software code
engineered for large-scale distributed-memory high-performance computing
systems; its optional MPI parallelism makes it particularly well-suited
for the Leonardo DCGP partition.

**Is the code installed on the machine chosen?** The code is not
installed, but the necessary compiler and libraries are already present
on Leonardo DCGP.

**Are the targets proposed feasible within the allocation time -
Workplan?** The resources assigned to the project are adequate, and it
is feasible to make full use of the 4000 node hours within the 6 month
allocation period.

**Comment globally on the provided technical data and your conclusions**
The project will employ RICH, a hydrodynamic simulation code with MPI
parallelism that demonstrates strong and weak scalability up to 1500
cores. Although it has not yet been used on the Leonardo DCGP partition,
its CPU-only, MPI-based architecture is well suited to this cluster. The
strategy for identifying and mitigating computational bottlenecks is
well-structured and thoughtfully designed, and the selected partition
fully satisfies the requirements for core count, memory, and storage.
Overall, the code is well matched to the available computational
resources, all installation prerequisites are met, and the project
timeline is realistic and achievable.

**Classification** Accepted

**Reason for classification** The proposal is clearly articulated,
robust, and feasible within the stated timeline.

EHPC-DEV-2026D05-170
--------------------

**Are the codes to be used in the project suitable for the architecture
of the machine chosen?** PLUTO code is public, it’s based on MPI
libraries and has already been used on Leonardo DCGP.

**Is the code installed on the machine chosen?** The necessary compiler
and libraries for PLUTO code are already available on Leonardo DCGP.

**Are the targets proposed feasible within the allocation time -
Workplan?** The resources allocated to the project are adequate, and it
is realistic to fully utilize the 4000 node hours within the 12 month
allocation period.

**Comment globally on the provided technical data and your conclusions**
The project will make use of the PLUTO code, a reliable and extensively
validated parallelization tool. The approach to identifying and
mitigating computational bottlenecks is well considered and sound. The
requirements for thread count, memory, and storage are fully supported
by the selected cluster. Overall, the code aligns well with the
available computational resources, installation requirements are
satisfied, and the proposed timeline is realistic and attainable.

**Classification** Accepted

**Reason for classification** The project is clearly presented, solid,
and achievable.

EHPC-DEV-2026D06-074 (19 Giugno)
--------------------------------

**Are the codes to be used in the project suitable for the architecture
of the machine chosen?** Both DDF-pipeline and killMS are publicly
available software code and their extensive use of parallelism makes
them suitable for Leonardo DCGP.

**Is the code installed on the machine chosen?** The codes are not
installed, but the necessary compiler and libraries are already present
on Leonardo DCGP.

**Are the targets proposed feasible within the allocation time -
Workplan?** The resources required for the project are adequate, and it
is realistic to fully utilize the 4000 node hours within the 12 month
allocation period.

**Comment globally on the provided technical data and your conclusions**
The project proposes to use DDF-pipeline and killMS, both of which rely
heavily on parallelism. Their software requirements appear to be
satisfied, and the requested node hours can be realistically utilized in
the proposed timeline.

However, there are significant concerns regarding the required thread
count and memory, which exceed the cluster’s job limits. The proposal
mentions a typical run involving 200 nodes, surpassing the Leonardo DCGP
maximum availability of 128 nodes. Moreover, the stated requirement of
450000 processes, equivalent to over 4000 nodes, far exceeds the total
capacity of the cluster, which consists of 1,536 nodes.

**Classification** Rejected

**Reason for classification** The required resources exceed partition
job limits

***
EXT
***

EHPC-EXT-2025E02-054
--------------------

**Are the codes to be used in the project suitable for the architecture
of the machine chosen?** BHAC is an open-source software code designed
to run on CPUs and that uses a pure MPI-based parallelization and has
been successfully run on cluster with similar technical characteristics
to Leonardo DCGP.

**Is the code installed on the machine chosen?** The code is not
installed, but the necessary compiler and libraries are already present
on Leonardo DCGP.

**Is the amount of time requested compatible with the work plan?** The
estimated node hours for each run type are consistent with the total
required node hours. The work plan provides a balanced allocation of
time throughout the project, distributed among the team members.

**Does the project require further testing and optimization?** The code
has already been tested on several HPC systems, including the Snellius
supercomputer, which shares similar technical characteristics with
Leonardo DCGP, and has shown excellent scalability up to 4096 cores.
Nevertheless, an initial phase devoted to setting up and tuning the
numerical codes and computational grids is planned.

**Comment on the anticipated efficiency of the resource utilization**
The time-to-solution plot indicates excellent scalability on the HPC
cluster Snellius, that has similar technical characteristics as
Leonardo, with scaling efficiency above 83% within the tested domain.
Checkpoint files will be generated every 12 hours to improve fault
tolerance and maintain computational resilience.

**Comment globally on the provided technical data and your conclusions**
The proposed use of BHAC on the Leonardo DCGP platform is technically
well justified and appropriate for the project’s computational needs.
The code is fully compatible with the machine’s architecture, as
demonstrated by previous successful runs on similar HPC systems.
Although the code is not currently installed, all essential compilers
and libraries are already available, ensuring a straightforward
installation process with minimal setup effort. The requested
computational time is coherent with the outlined work plan and
distributed among the project participants. The anticipated resource
efficiency is high, as demonstrated by excellent strong and weak scaling
on clusters with similar technical characteristics. The inclusion of
regular checkpointing every few hours provides additional robustness and
efficient recovery capability.

**Reason for classification** The project is technically sound, the
resource request is well supported, and the use of Leonardo DCGP appears
both effective and efficient.

**Application Support Team (AST)** An AST was not requested