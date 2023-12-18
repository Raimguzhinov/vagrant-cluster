#!/bin/bash 
#SBATCH -J mpi-hello             
#SBATCH -n 2                     
#SBATCH -t 0:10:00               
#SBATCH -o ob.out         
 
mpicc hello.c -o hello 
mpirun --allow-run-as-root -np 2 ./hello 
