setup:
	vagrant up && \
	vagrant ssh controller -- -t 'source /home/vagrant/.bashrc' && \
	vagrant ssh dias -- -t 'source /home/vagrant/.bashrc' && \
	vagrant ssh yana -- -t 'source /home/vagrant/.bashrc'

start:
	vagrant ssh controller

sinfo:
	vagrant ssh controller -- -t 'sinfo'

stop:
	vagrant halt --force controller
	vagrant halt --force dias
	vagrant halt --force yana

destroy:
	vagrant destroy --force controller
	vagrant destroy --force dias
	vagrant destroy --force yana
