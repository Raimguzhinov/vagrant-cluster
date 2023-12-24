#!/bin/bash
#SBATCH -J mpi-hello
#SBATCH -n 2
#SBATCH -t 0:10:00
#SBATCH --output=/home/vagrant/web_storage/mpi-hello.out
#SBATCH --error=/home/vagrant/web_storage/mpi-hello.log

mpicc /vagrant/hello.c -o /home/vagrant/web_storage/hello
mpirun --allow-run-as-root -np 2 /home/vagrant/web_storage/hello
