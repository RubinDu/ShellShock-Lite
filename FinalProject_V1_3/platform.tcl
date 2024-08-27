# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct E:\fpga_workspace\FinalProject_V1_3\platform.tcl
# 
# OR launch xsct and run below command.
# source E:\fpga_workspace\FinalProject_V1_3\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {FinalProject_V1_3}\
-hw {E:\fpga_workspace\project_final\project_final\FinalProject_V1_3.xsa}\
-out {E:/fpga_workspace}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {FinalProject_V1_3}
platform generate -quick
platform generate
