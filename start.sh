#!/bin/bash

#allows test execution
if [ -z $SERVICE_DIR ]; then export SERVICE_DIR=`pwd`; fi
if [ -z $ENV ]; then export ENV=IUHPC; fi

if [ $ENV == "IUHPC" ]; then
	module load nodejs
fi
node $SERVICE_DIR/genpbs.js > submit.pbs

#rm -f finished

# Steven's code
cp ~/freesurfer.tar.gz ./ && tar -xf freesurfer.tar.gz && rm freesurfer.tar.gz

if [ $ENV == "IUHPC" ]; then
	echo "Submitting.."
	jobid=`qsub submit.pbs`
	echo $jobid > jobid
fi

if [ $ENV == "VM" ]; then
    nohup time $SERVICE_DIR/submit.pbs > stdout.log 2> stderr.log &
    echo $! > pid
fi

