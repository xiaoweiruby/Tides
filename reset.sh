#########################################################################
# File : reset.sh
# Author: Chorder
# mail: chorder AT chorder.net
# Created Time: Wed 31 May 2017 10:35:06 PM CST
#########################################################################
#!/bin/bash

rake db:drop
rake db:create
rake db:migrate
rake db:seed
rake assets:precompile
