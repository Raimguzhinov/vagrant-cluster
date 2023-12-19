setup:
	vagrant up && \
	vagrant ssh controller -- -t 'source /home/vagrant/.bashrc' && \
	vagrant ssh dias -- -t 'source /home/vagrant/.bashrc' && \
	vagrant ssh yana -- -t 'source /home/vagrant/.bashrc'

ssh:
	vagrant ssh controller

sinfo:
	vagrant ssh controller -- -t 'sinfo'
	vagrant ssh controller -- -t 'squeue'

sping:
	vagrant ssh dias -- -t 'scontrol ping'
	vagrant ssh yana -- -t 'scontrol ping'

reload:
	vagrant reload controller
	vagrant reload dias
	vagrant reload yana

reset-nodes:
	vagrant ssh controller -- -t 'sudo systemctl restart munge && sudo systemctl restart slurmctld' && \
	vagrant ssh dias -- -t 'sudo systemctl restart munge && sudo systemctl restart slurmd' && \
	vagrant ssh yana -- -t 'sudo systemctl restart munge && sudo systemctl restart slurmd' && \
	vagrant ssh controller -- -t 'scontrol update NodeName=dias State=down Reason=hung_proc' && \
	vagrant ssh controller -- -t 'scontrol update NodeName=yana State=down Reason=hung_proc' && \
	vagrant ssh controller -- -t 'scontrol update NodeName=dias State=resume' && \
	vagrant ssh controller -- -t 'scontrol update NodeName=yana State=resume'

benchmark:
	@printf "\n>>> Running a benchmark\n"
	@printf "\n>>> Output:\n"
	@printf "\n>>> Master-node (controller):\n" && \
	vagrant ssh controller -- -t '/vagrant/analysis.sh'
	@printf "\n>>> Worker 1 (dias):\n" && \
	vagrant ssh dias -- -t '/vagrant/analysis.sh'
	@printf "\n>>> Worker 2 (yana):\n" && \
	vagrant ssh yana -- -t '/vagrant/analysis.sh'

monitor:
	@printf "\n>>> Running a monitor\n"
	@printf "\n>>> Output:\n"
	@printf "\n>>> Worker 1 (dias):\n" && \
	open http://10.10.17.113:8080/monitorix
	@printf "\n>>> Worker 2 (yana):\n" && \
	open http://10.10.17.112:8080/monitorix
	@printf "\n>>> Master-node (controller):\n" && \
	open http://10.10.17.100:8082	

mpi-test:
	@printf "\n>>> Running a test job\n"
	@vagrant ssh controller -- -t 'sbatch /vagrant/job.sh'
	@printf "\n>>> Output:\n"
	@printf "\n>>> Master-node (controller):\n" && \
	vagrant ssh controller -- -t 'cat nfs_test/mpi-hello.out'
	@printf "\n>>> Worker 1 (dias):\n" && \
	vagrant ssh dias -- -t 'cat web_storage/mpi-hello.out'
	@printf "\n>>> Worker 2 (yana):\n" && \
	vagrant ssh yana -- -t 'cat web_storage/mpi-hello.out'

halt:
	vagrant ssh controller -- -t 'sudo shutdown -h now'
	vagrant ssh dias -- -t 'sudo shutdown -h now'
	vagrant ssh yana -- -t 'sudo shutdown -h now'

stop:
	vagrant halt controller
	vagrant halt dias
	vagrant halt yana

destroy:
	vagrant destroy controller
	vagrant destroy dias
	vagrant destroy yana
